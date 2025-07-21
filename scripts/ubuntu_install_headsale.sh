#!/bin/bash

#https://headscale.net/0.26.1/setup/install/official/
HEADSCALE_VERSION="0.26.1" # See above URL for latest version, e.g. "X.Y.Z" (NOTE: do not add the "v" prefix!)
HEADSCALE_ARCH="amd64" # Your system architecture, e.g. "amd64"
wget --output-document=/tmp/headscale.deb "https://github.com/juanfont/headscale/releases/download/v${HEADSCALE_VERSION}/headscale_${HEADSCALE_VERSION}_linux_${HEADSCALE_ARCH}.deb"
apt install /tmp/headscale.deb

# Edit config
#nano /etc/headscale/config.yaml

systemctl enable --now headscale
sudo systemctl status headscale
