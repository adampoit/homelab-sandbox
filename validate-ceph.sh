export KUBECONFIG=$PWD/cluster/artifacts/admin.conf

kubectl create -f cluster/rook-toolbox.yaml

while [ $(kubectl -n rook-ceph get pod -l "app=rook-ceph-tools" | grep ContainerCreating | wc -l) -ne 0 ]; do
	sleep 5
done

kubectl -n rook-ceph exec -it $(kubectl -n rook-ceph get pod -l "app=rook-ceph-tools" -o jsonpath='{.items[0].metadata.name}') ceph status
kubectl -n rook-ceph delete deployment rook-ceph-tools
