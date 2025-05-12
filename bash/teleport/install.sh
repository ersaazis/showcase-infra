#!/bin/bash

TELEPORT_EDITION="oss"
TELEPORT_VERSION="17.4.8"

curl https://cdn.teleport.dev/install.sh | bash -s ${TELEPORT_VERSION?} ${TELEPORT_EDITION?}

sudo tee /etc/teleport.yaml > /dev/null <<EOF
teleport:
  nodename: bastion-server
  data_dir: /var/lib/teleport
  log:
    output: stderr
    severity: INFO

auth_service:
  enabled: true
  cluster_name: control-plane

ssh_service:
  enabled: true

proxy_service:
  enabled: true
  https_keypairs:
    - cert_file: /etc/teleport/ssl/teleport.crt
      key_file: /etc/teleport/ssl/teleport.key
  web_listen_addr: 0.0.0.0:443
  web_public_addr: bastion.demo.digitalisasidata.com:443
EOF

sudo systemctl enable teleport
sudo systemctl start teleport
