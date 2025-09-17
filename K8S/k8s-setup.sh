#!/bin/bash
set -euo pipefail

# ---------------------------------------------
# 1. 设置内核参数
# ---------------------------------------------
echo "设置 sudoers"
echo "ubuntu ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

echo "写入 sysctl 配置"
cat > /etc/sysctl.d/k8s.conf <<EOF
net.ipv4.ip_forward = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
vm.swappiness = 0
EOF

echo "加载 br_netfilter 模块"
echo br_netfilter >> /etc/modules
modprobe br_netfilter

echo "应用 sysctl 配置"
sysctl --system

# ---------------------------------------------
# 2. 关闭交换内存
# ---------------------------------------------
echo "关闭 swap"
swapoff -a
sed -ir 's/.*swap/#&/g' /etc/fstab
rm -f /swap.img
echo "swap 状态:"
free -m

# ---------------------------------------------
# 3. 安装必要系统工具
# ---------------------------------------------
echo "更新系统并安装工具"
apt-get update
apt-get install -y apt-transport-https ca-certificates curl software-properties-common gnupg lsb-release

# ---------------------------------------------
# 4. 安装 Kubernetes GPG 证书
# ---------------------------------------------
echo "添加 Kubernetes GPG key"
mkdir -p /etc/apt/keyrings
curl -fsSL https://mirrors.aliyun.com/kubernetes-new/core/stable/v1.28/deb/Release.key \
    | gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

# ---------------------------------------------
# 5. 添加 Kubernetes 软件源
# ---------------------------------------------
echo "添加 Kubernetes 软件源"
echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://mirrors.aliyun.com/kubernetes-new/core/stable/v1.28/deb/ /" \
    | tee /etc/apt/sources.list.d/kubernetes.list

# ---------------------------------------------
# 6. 安装 containerd
# ---------------------------------------------
echo "下载并安装 containerd"
curl -LO https://github.com/containerd/containerd/releases/download/v1.6.28/cri-containerd-cni-1.6.28-linux-amd64.tar.gz
tar -xzf cri-containerd-cni-1.6.28-linux-amd64.tar.gz -C /

# ---------------------------------------------
# 7. 安装 kubelet, kubeadm, kubectl
# ---------------------------------------------
echo "更新 apt 并安装 kubelet/kubeadm/kubectl"
apt-get update
apt-get install -y kubelet kubeadm kubectl

# ---------------------------------------------
# 8. 配置 containerd
# ---------------------------------------------
echo "创建 containerd 配置目录"
mkdir -p /etc/containerd

echo "生成默认配置文件"
containerd config default > /etc/containerd/config.toml

echo "修改 SystemdCgroup 为 true"
sed -i.bak$(date +%Y%m%d%H%M) 's/^\(\s*SystemdCgroup\s*=\s*\).*$/\1true/' /etc/containerd/config.toml

echo "修改 sandbox_image"
sed -i.bak$(date +%Y%m%d%H%M) \
    's|^\(\s*sandbox_image\s*=\s*\).*|\1"registry.aliyuncs.com/google_containers/pause:3.9"|' \
    /etc/containerd/config.toml

# ---------------------------------------------
# 9. 设置开机自启并启动服务
# ---------------------------------------------
echo "重载 systemd 并启动 containerd 和 kubelet"
systemctl daemon-reexec
systemctl enable --now containerd kubelet
systemctl restart containerd kubelet

# ---------------------------------------------
# 10. kubeadm 初始化
# ---------------------------------------------
echo "初始化 Kubernetes 集群"
kubeadm init \
  --kubernetes-version=$(kubeadm version -o short) \
  --apiserver-advertise-address=192.168.125.100 \
  --image-repository=registry.aliyuncs.com/google_containers \
  --service-cidr=192.168.1.0/24

echo "完成 kubeadm 初始化，如需重置可用： kubeadm reset -f"

# ---------------------------------------------
# 11. 配置 crictl
# ---------------------------------------------
echo "配置 crictl 使用 containerd"
crictl config runtime-endpoint unix:///var/run/containerd/containerd.sock
crictl config image-endpoint unix:///var/run/containerd/containerd.sock

echo "脚本执行完成 ✅"
