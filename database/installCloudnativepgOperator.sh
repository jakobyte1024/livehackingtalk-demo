kubectl apply -f \
  https://raw.githubusercontent.com/cloudnative-pg/cloudnative-pg/release-1.19/releases/cnpg-1.19.1.yaml

helm repo add prometheus-community \
  https://prometheus-community.github.io/helm-charts

helm upgrade --install \
  -f https://raw.githubusercontent.com/cloudnative-pg/cloudnative-pg/main/docs/src/samples/monitoring/kube-stack-config.yaml \
  prometheus-community \
  prometheus-community/kube-prometheus-stack

cat <<EOF | kubectl apply -f -
    apiVersion: postgresql.cnpg.io/v1
    kind: Cluster
    metadata:
        name: conduit-db
        namespace: conduit
    spec:
        instances: 2
        primaryUpdateStrategy: supervised
        storage:
            size: 4Gi
        monitoring:
            enablePodMonitor: true
EOF

kubectl apply -f \
  https://raw.githubusercontent.com/cloudnative-pg/cloudnative-pg/main/docs/src/samples/monitoring/cnpg-prometheusrule.yaml

kubectl apply -f \
  https://raw.githubusercontent.com/cloudnative-pg/cloudnative-pg/main/docs/src/samples/monitoring/grafana-configmap.yaml


