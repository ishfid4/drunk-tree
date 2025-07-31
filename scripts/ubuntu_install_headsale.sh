#!/bin/bash

#https://headscale.net/0.26.1/setup/install/official/
HEADSCALE_VERSION="0.26.1" # See above URL for latest version, e.g. "X.Y.Z" (NOTE: do not add the "v" prefix!)
HEADSCALE_ARCH="amd64" # Your system architecture, e.g. "amd64"
wget --output-document=/tmp/headscale.deb "https://github.com/juanfont/headscale/releases/download/v${HEADSCALE_VERSION}/headscale_${HEADSCALE_VERSION}_linux_${HEADSCALE_ARCH}.deb"
apt install /tmp/headscale.deb

# Edit config
echo $SERVER_URL
sed -i \
  -e "s|server_url: http://127.0.0.1:8080|server_url: $SERVER_URL|" \
  -e "s|listen_addr: 127.0.0.1:8080|listen_addr: 0.0.0.0:8080|" \
  -e "s|grpc_listen_addr: 127.0.0.1:50443|grpc_listen_addr: 0.0.0.0:50443|" \
  -e "s|base_domain: example.com|base_domain: local|" \
  -e "/- 1\.1\.1\.1/{N;N;N;s/- 1\.1\.1\.1\n[[:space:]]*- 1\.0\.0\.1\n[[:space:]]*- 2606:4700:4700::1111\n[[:space:]]*- 2606:4700:4700::1001/[]/;}" \
  /etc/headscale/config.yaml

systemctl enable --now headscale
systemctl status headscale
