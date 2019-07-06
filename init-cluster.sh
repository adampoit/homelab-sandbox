vagrant up

if [ ! -d kubespray ]
then
	git clone https://github.com/kubernetes-sigs/kubespray.git
fi

pushd kubespray
ansible-playbook -i ../cluster/hosts.yml --user=root cluster.yml
popd

export KUBECONFIG=$PWD/cluster/artifacts/admin.conf

kubectl create -f https://github.com/rook/rook/raw/release-1.0/cluster/examples/kubernetes/ceph/common.yaml
kubectl create -f https://github.com/rook/rook/raw/release-1.0/cluster/examples/kubernetes/ceph/operator.yaml

while [ $(kubectl -n rook-ceph get pod | grep ContainerCreating | wc -l) -ne 0 ]; do
	sleep 5
done

kubectl create -f cluster/rook/rook.yaml
kubectl create -f cluster/rook/storageclass.yaml
kubectl create -f cluster/rook/filesystem.yaml

kubectl patch storageclass rook-ceph-block -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'

kubectl apply -f https://raw.githubusercontent.com/google/metallb/v0.7.3/manifests/metallb.yaml
kubectl create -f cluster/metallb.yaml

kubectl create -f cluster/nginx.yaml
