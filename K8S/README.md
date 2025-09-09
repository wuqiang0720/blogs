
```bash

3、设置内核参数：
cat > /etc/sysctl.d/k8s.conf << EOF
net.ipv4.ip_forward = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
vm.swappiness = 0
EOF
echo br_netfilter >> /etc/modules && modprobe br_netfilter
sysctl --system
4、关闭交换内存：
swapoff -a
sed -ir 's/.*swap/#&/g' /etc/fstab
rm -Rf /swap.img
free -m
apt install -y conntrack iptables ebtables ethtool socat


curl -L https://cdn.dl.k8s.io/release/v1.28.2/bin/linux/amd64/kubeadm -o /usr/local/bin/kubeadm
curl -L https://cdn.dl.k8s.io/release/v1.28.2/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl
curl -L https://cdn.dl.k8s.io/release/v1.28.2/bin/linux/amd64/kubelet -o /usr/local/bin/kubelet
curl -LO https://github.com/containerd/containerd/releases/download/v1.6.28/cri-containerd-cni-1.6.28-linux-amd64.tar.gz
tar -xzf cri-containerd-cni-1.6.28-linux-amd64.tar.gz -C /
chmod +x /usr/local/bin/*

kubeadm init phase certs ca
kubeadm init phase kubeconfig kubelet --kubernetes-version=v1.28.2

cat > /etc/systemd/system/kubelet.service << EOF
[Unit]
Description=kubelet: The Kubernetes Node Agent
Documentation=https://kubernetes.io/docs/home/
After=network.target
[Service]
ExecStart=/usr/local/bin/kubelet \
  --kubeconfig=/etc/kubernetes/kubelet.conf \
  --cgroup-driver=systemd \
  --pod-infra-container-image=registry.aliyuncs.com/google_containers/pause:3.9
Restart=always
StartLimitInterval=0
RestartSec=10
[Install]
WantedBy=multi-user.target
EOF

mkdir /etc/containerd/
containerd config default | tee /etc/containerd/config.toml

systemctl daemon-reexec
systemctl enable --now kubelet containerd
systemctl restart kubelet containerd

# kubeadm init --pod-network-cidr=10.244.0.0/16 --cri-socket=unix:///var/run/dockershim.sock
kubeadm init --kubernetes-version=v1.28.2 --apiserver-advertise-address=192.168.125.100 \
--image-repository=registry.aliyuncs.com/google_containers --pod-network-cidr=10.244.0.0/16 --service-cidr=10.96.0.0/12

```
