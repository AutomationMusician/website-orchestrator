
#!/usr/bin/env bash

set -euo pipefail

echo "=== Updating system packages ==="
apt update
apt -y upgrade

echo "=== Installing Additional Packages ==="
apt install -y curl git

echo "=== Installing Tailscale ==="
curl -fsSL https://tailscale.com/install.sh | sh
tailscale set --operator=jfishman --ssh --advertise-exit-node

# Set exit node properties
echo 'net.ipv4.ip_forward = 1' | tee -a /etc/sysctl.d/99-tailscale.conf
echo 'net.ipv6.conf.all.forwarding = 1' | tee -a /etc/sysctl.d/99-tailscale.conf
sysctl -p /etc/sysctl.d/99-tailscale.conf

echo "=== Installing Docker ==="
apt install ca-certificates curl
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/debian
Suites: $(. /etc/os-release && echo "$VERSION_CODENAME")
Components: stable
Architectures: $(dpkg --print-architecture)
Signed-By: /etc/apt/keyrings/docker.asc
EOF

apt update

apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

usermod -aG docker jfishman

echo "=== Setup complete! ==="
