# Secure Env

After noticing strange behavior on test environment, we want to secure our prod env.

## Change Passwords

We force all our employees to change their passwords.

## Set Jenkins behind Reverse Proxy

We deploy an ingress-nginx in front of jenkins to log all the logins.

## Deploy Tetragon

We deploy tetragon to observe the root console of K8s.

### Define TracingPolicy

We define a tetragon tracing policy that prevents changing haproxy files.

# Attack Again & Defend

## Jenkins Bruteforce

The attacker tries to bruteforce and login to jenkins on the test env again and this time we get the login attempts in the logs:

```bash
kubectl get pod -n ingress-nginx
kubectl logs <Ingress-Controller-Pod-Name> -f -n ingress-nginx
```

## K8s Pod TCP Traffic Routing

The attacker switches to prod env on octant and tries to inject a sidecar container in the app pod, which routes all the tcp traffic to a remote server:

Edit the app deployment:

```bash
kubectl edit deployment/conduit-backend
```

Inject the sidecar container:

```bash
- env:
  - name: LISTEN
    value: :8081
  - name: TALK
    value: 127.0.0.1:8080
  image: tecnativa/tcp-proxy
  imagePullPolicy: Always
  name: sidecar
```

The new container will not be deployed properly, since a SigKill will be sent to end that process from the tetragon policy we defined before. This can be checked using the following command:

```bash
kubectl get pod -n conduit-app
```

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
