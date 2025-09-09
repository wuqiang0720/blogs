#!/bin/bash
set -euo pipefail

# -----------------------------
# 1. 设置内核参数
# -----------------------------
cat >/etc/sysctl.d/k8s.conf << EOF
net.ipv4.ip_forward = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
vm.swappiness = 0
EOF

echo br_netfilter >> /etc/modules
modprobe br_netfilter
sysctl --system

# -----------------------------
# 2. 关闭交换内存
# -----------------------------
swapoff -a
sed -ir 's/.*swap/#&/g' /etc/fstab
rm -f /swap.img
free -m

# -----------------------------
# 3. 安装必要的系统工具
# -----------------------------
apt-get update
apt-get install -y apt-transport-https ca-certificates curl software-properties-common

# -----------------------------
# 4. 安装 GPG 证书
# -----------------------------
mkdir -p /usr/share/keyrings /etc/apt/keyrings
curl -fsSL https://mirrors.aliyun.com/docker-ce/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-aliyun.gpg
curl -fsSL https://mirrors.aliyun.com/kubernetes-new/core/stable/v1.28/deb/Release.key | gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

# -----------------------------
# 5. 添加软件源
# -----------------------------
add-apt-repository "deb [arch=amd64] https://mirrors.aliyun.com/docker-ce/linux/ubuntu $(lsb_release -cs) stable"
echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://mirrors.aliyun.com/kubernetes-new/core/stable/v1.28/deb/ /" | tee /etc/apt/sources.list.d/kubernetes.list

# -----------------------------
# 6. 安装 containerd 和 kube 组件
# -----------------------------
apt-get update
apt-get install -y containerd.io=1.6.28-2 kubelet kubeadm kubectl

# -----------------------------
# 6.1 配置 containerd
# -----------------------------
containerd config default | tee /etc/containerd/config.toml
sed -i.bak"$(date +%Y%m%d%H%M)" 's/^\(\s*SystemdCgroup\s*=\s*\).*$/\1true/' /etc/containerd/config.toml

# -----------------------------
# 6.2 设置开机自启并启动服务
# -----------------------------
systemctl daemon-reexec
systemctl enable --now containerd kubelet
systemctl restart containerd kubelet

# -----------------------------
# 7. kubeadm 初始化集群
# -----------------------------
kubeadm init \
  --kubernetes-version=v1.28.2 \
  --apiserver-advertise-address=192.168.125.100 \
  --image-repository=registry.aliyuncs.com/google_containers \
  --pod-network-cidr=10.244.0.0/16 \
  --service-cidr=10.96.0.0/12

echo "Kubernetes 初始化完成！请按照 kubeadm 输出提示配置 kubectl。"
