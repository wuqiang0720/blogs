```bash
#1、设置内核参数：
echo "ubuntu ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
cat > /etc/sysctl.d/k8s.conf << EOF
net.ipv4.ip_forward = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
vm.swappiness = 0
EOF
echo br_netfilter >> /etc/modules && modprobe br_netfilter
sysctl --system
#2、关闭交换内存：
swapoff -a
sed -ir 's/.*swap/#&/g' /etc/fstab
rm -Rf /swap.img
free -m
#3、装必要的一些系统工具
apt-get update && apt-get -y install apt-transport-https ca-certificates curl software-properties-common apt-transport-https
#4、安装GPG证书
version=v1.28
curl -fsSL https://mirrors.aliyun.com/kubernetes-new/core/stable/$(version)/deb/Release.key |gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
#5、写入软件源信息
echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://mirrors.aliyun.com/kubernetes-new/core/stable/$(version)/deb/ /"| tee /etc/apt/sources.list.d/kubernetes.list
#6、安装containerd
# curl -LO https://github.com/containerd/containerd/releases/download/v1.6.28/cri-containerd-cni-1.6.28-linux-amd64.tar.gz
tar -xzf /home/ubuntu/cri-containerd-cni-1.6.28-linux-amd64.tar.gz -C /
apt-get update&& apt-get install -y kubelet kubeadm kubectl
#6.1、修改配置问并备份
mkdir /etc/containerd
containerd config default > /etc/containerd/config.toml
sed -i.bak$(date +%Y%m%d%H%M) 's/^\(\s*SystemdCgroup\s*=\s*\).*$/\1true/' /etc/containerd/config.toml
sed -i.bak$(date +%Y%m%d%H%M) \
    's|^\(\s*sandbox_image\s*=\s*\).*|\1"registry.aliyuncs.com/google_containers/pause:3.10"|' \
    /etc/containerd/config.toml
# sed -i.bak$(date +%Y%m%d%H%M) 's/^\(\s*systemd_cgroup\s*=\s*\).*$/\1true/' /etc/containerd/config.toml
#6.2、设置开机自启并启动
systemctl daemon-reexec
systemctl enable --now kubelet containerd
systemctl restart kubelet containerd
#7、kubeadm Initation
kubeadm init --kubernetes-version=$(kubeadm version -o short) --apiserver-advertise-address=192.168.125.100 \
--image-repository=registry.aliyuncs.com/google_containers --service-cidr=192.168.1.0/24
######################## 
##  kubeadm reset -f  ##
######################## 
#8、crictl env
# crictl config runtime-endpoint unix:///var/run/containerd/containerd.sock
# crictl config image-endpoint unix:///var/run/containerd/containerd.sock
#9、Install the below pod
kubectl taint nodes $(hostname) node-role.kubernetes.io/control-plane:NoSchedule-     ##因为只有一个master所以需要接触这个node的taint
kubectl apply -f https://raw.githubusercontent.com/wuqiang0720/blogs/refs/heads/main/k8s/yaml/calico.yaml
kubectl apply -f https://raw.githubusercontent.com/wuqiang0720/blogs/refs/heads/main/k8s/yaml/metrics-server.yaml
kubectl apply -f https://raw.githubusercontent.com/wuqiang0720/blogs/refs/heads/main/k8s/yaml/local-path-storage.yaml
kubectl apply -f https://raw.githubusercontent.com/wuqiang0720/blogs/refs/heads/main/k8s/yaml/metallb-native.yaml
kubectl apply -f https://raw.githubusercontent.com/wuqiang0720/blogs/refs/heads/main/k8s/yaml/metallb-ipconfig.yaml
kubectl apply -f https://raw.githubusercontent.com/wuqiang0720/blogs/refs/heads/main/k8s/yaml/openldap.yaml
kubectl apply -f https://raw.githubusercontent.com/wuqiang0720/blogs/refs/heads/main/k8s/yaml/mariadb-galera.yaml
kubectl apply -f https://raw.githubusercontent.com/wuqiang0720/blogs/refs/heads/main/k8s/yaml/dashboard.yaml
kubectl apply -f https://raw.githubusercontent.com/metal3-io/baremetal-operator/refs/heads/main/config/base/crds/bases/metal3.io_baremetalhosts.yaml

#11、Install helm
wget https://get.helm.sh/helm-v3.12.1-linux-amd64.tar.gz
tar -zxvf helm-v3.12.1-linux-amd64.tar.gz
mv linux-amd64/helm /usr/local/bin/helm
helm version

```
