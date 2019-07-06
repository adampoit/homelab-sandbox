export KUBECONFIG=$PWD/cluster/artifacts/admin.conf

kubectl create -f cluster/plex-namespace.yaml
kubectl create -f cluster/pvc.yaml
kubectl create -f cluster/samba.yaml

echo "Provide a plex claim token (https://www.plex.tv/claim/):"
read token

erb claim=$token cluster/plex.yaml.erb | kubectl create -f -
