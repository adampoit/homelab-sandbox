export KUBECONFIG=$PWD/cluster/artifacts/admin.conf

erb claim=none cluster/plex.yaml.erb | kubectl delete -f -

kubectl delete -f cluster/samba.yaml
kubectl delete -f cluster/pvc.yaml
