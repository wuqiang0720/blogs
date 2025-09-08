
```
curl -L https://cdn.dl.k8s.io/release/v1.28.2/bin/linux/amd64/kubeadm -o /usr/local/bin/kubeadm
curl -L https://cdn.dl.k8s.io/release/v1.28.2/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl
curl -L https://cdn.dl.k8s.io/release/v1.28.2/bin/linux/amd64/kubelet -o /usr/local/bin/kubelet
sudo chmod +x /usr/local/bin/kubeadm /usr/local/bin/kubectl /usr/local/bin/kubelet

curl -LO https://github.com/containerd/containerd/releases/download/v1.8.6/containerd-1.8.6-linux-amd64.tar.gz
tar Cxzvf /usr/local containerd-1.8.6-linux-amd64.tar.gz

curl -o /etc/systemd/system/containerd.service \
  https://raw.githubusercontent.com/containerd/containerd/main/containerd.service
systemctl daemon-reexec
systemctl enable --now containerd
mkdir -p /etc/systemd/system/kubelet.service.d 
curl -sSL -o /etc/systemd/system/kubelet.service \
  https://raw.githubusercontent.com/wuqiang0720/blogs/refs/heads/main/K8S/kubelet.service
curl -sSL -o /etc/systemd/system/kubelet.service.d/10-kubeadm.conf \
  https://raw.githubusercontent.com/wuqiang0720/blogs/refs/heads/main/K8S/10-kubeadm.conf


```
