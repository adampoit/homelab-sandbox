export KUBECONFIG=$PWD/cluster/artifacts/admin.conf

kubectl apply -f https://raw.githubusercontent.com/coreos/prometheus-operator/v0.26.0/bundle.yaml

kubectl create -f https://github.com/rook/rook/raw/release-1.0/cluster/examples/kubernetes/ceph/monitoring/service-monitor.yaml
kubectl create -f https://github.com/rook/rook/raw/release-1.0/cluster/examples/kubernetes/ceph/monitoring/prometheus.yaml
kubectl create -f cluster/rook/monitoring/prometheus-service.yaml
kubectl create -f cluster/rook/monitoring/grafana.yaml
