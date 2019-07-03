export KUBECONFIG=$PWD/cluster/artifacts/admin.conf

erb claim=none cluster/plex.yaml.erb | kubectl delete -f -
