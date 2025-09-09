
```bash

3、设置内核参数：
root@k8s:~# cat > /etc/sysctl.d/k8s.conf << EOF
net.ipv4.ip_forward = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
vm.swappiness = 0
EOF
root@k8s:~# echo br_netfilter >> /etc/modules && modprobe br_netfilter
root@k8s:~# sysctl --system
4、关闭交换内存：
root@k8s:~# swapoff -a
root@k8s:~# sed -ir 's/.*swap/#&/g' /etc/fstab
root@k8s:~# rm -Rf /swap.img
root@k8s:~# free -m
apt install -y conntrack iptables ebtables ethtool socat


curl -L https://cdn.dl.k8s.io/release/v1.28.2/bin/linux/amd64/kubeadm -o /usr/local/bin/kubeadm
curl -L https://cdn.dl.k8s.io/release/v1.28.2/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl
curl -L https://cdn.dl.k8s.io/release/v1.28.2/bin/linux/amd64/kubelet -o /usr/local/bin/kubelet
curl -LO https://github.com/containerd/containerd/releases/download/v1.6.28/cri-containerd-cni-1.6.28-linux-amd64.tar.gz
tar -xzf cri-containerd-cni-1.6.28-linux-amd64.tar.gz -C /
chmod +x /usr/local/bin/*



curl -o /etc/systemd/system/containerd.service \
  https://raw.githubusercontent.com/containerd/containerd/main/containerd.service

curl -sSL -o /etc/systemd/system/kubelet.service \
  https://raw.githubusercontent.com/wuqiang0720/blogs/refs/heads/main/K8S/kubelet.service

systemctl daemon-reexec
systemctl enable --now kubelet containerd
systemctl restart kubelet containerd


# kubeadm init --pod-network-cidr=10.244.0.0/16 --cri-socket=unix:///var/run/dockershim.sock
kubeadm init --pod-network-cidr=10.244.0.0/16 --cri-socket=unix:///run/containerd/containerd.sock
```
