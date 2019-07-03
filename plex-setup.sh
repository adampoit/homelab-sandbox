export KUBECONFIG=$PWD/cluster/artifacts/admin.conf

kubectl create -f cluster/pvc.yaml

echo "Provide a plex claim token (https://www.plex.tv/claim/):"
read token

erb claim=$token cluster/plex.yaml.erb | kubectl create -f -
