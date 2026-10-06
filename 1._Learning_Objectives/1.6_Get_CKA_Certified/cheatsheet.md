# kubectl Cheatsheet (CKA)

## Sınav başında kurulum

```bash
alias k=kubectl
source <(kubectl completion bash)
complete -o default -F __start_kubectl k
export do="--dry-run=client -o yaml"
export now="--force --grace-period 0"
```

## YAML üretme (dry-run)

```bash
k run nginx --image=nginx $do > pod.yaml
k create deploy web --image=nginx --replicas=3 $do > deploy.yaml
k expose deploy web --port=80 --target-port=80 $do
k create job j1 --image=busybox $do -- sh -c "echo hi"
k create cronjob cj1 --image=busybox --schedule="*/5 * * * *" $do -- sh -c "date"
k create cm app-cm --from-literal=key=value $do
k create secret generic app-secret --from-literal=pass=1234 $do
k create sa my-sa
k create role r1 --verb=get,list --resource=pods
k create rolebinding rb1 --role=r1 --user=jane
```

## Faydalı komutlar

```bash
k explain pod.spec.containers --recursive
k get pod -o wide --show-labels
k get events --sort-by=.metadata.creationTimestamp
k logs <pod> -c <container> --previous
k config use-context <ctx>
k config get-contexts
k auth can-i create pods --as jane
k top node; k top pod
```

## Troubleshooting sırası

1. `k get nodes`, `k describe node <node>`
2. `systemctl status kubelet`, `journalctl -u kubelet -f`
3. `/etc/kubernetes/manifests/` (static pod'lar: apiserver, scheduler, controller-manager, etcd)
4. `crictl ps`, `crictl logs <id>`
5. `k describe pod`, `k logs`, `k get events`

## etcd yedekleme / geri yükleme

```bash
ETCDCTL_API=3 etcdctl snapshot save /opt/snap.db \
  --endpoints=https://127.0.0.1:2379 \
  --cacert=/etc/kubernetes/pki/etcd/ca.crt \
  --cert=/etc/kubernetes/pki/etcd/server.crt \
  --key=/etc/kubernetes/pki/etcd/server.key

etcdutl snapshot restore /opt/snap.db --data-dir /var/lib/etcd-restore
```

## kubeadm upgrade (özet)

```bash
kubeadm upgrade plan
kubeadm upgrade apply v1.xx.x        # control plane
kubeadm upgrade node                 # worker
kubectl drain <node> --ignore-daemonsets
# kubelet + kubectl paketlerini güncelle, sonra:
systemctl daemon-reload && systemctl restart kubelet
kubectl uncordon <node>
```

> Not: Komutları ve sürüm numaralarını sınav öncesi dokümantasyondan teyit et.
