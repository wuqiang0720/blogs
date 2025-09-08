
```
curl -L https://cdn.dl.k8s.io/release/v1.28.2/bin/linux/amd64/kubeadm -o /usr/local/bin/kubeadm
curl -L https://cdn.dl.k8s.io/release/v1.28.2/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl
curl -L https://cdn.dl.k8s.io/release/v1.28.2/bin/linux/amd64/kubelet -o /usr/local/bin/kubelet
curl -LO https://github.com/containerd/containerd/releases/download/v1.6.28/containerd-1.6.28-linux-amd64.tar.gz
tar -xf containerd-1.6.28-linux-amd64.tar.gz -C /usr/local/
chmod +x /usr/local/bin/*



curl -o /etc/systemd/system/containerd.service \
  https://raw.githubusercontent.com/containerd/containerd/main/containerd.service

mkdir -p /etc/systemd/system/kubelet.service.d 
curl -sSL -o /etc/systemd/system/kubelet.service \
  https://raw.githubusercontent.com/wuqiang0720/blogs/refs/heads/main/K8S/kubelet.service

systemctl daemon-reexec
systemctl enable --now kubelet containerd
systemctl restart kubelet containerd


sudo kubeadm init --pod-network-cidr=10.244.0.0/16 --cri-socket=unix:///var/run/dockershim.sock
sudo kubeadm init --pod-network-cidr=10.244.0.0/16 --cri-socket=unix:///run/containerd/containerd.sock




```
