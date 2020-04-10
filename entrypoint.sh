#!/bin/sh

echo "ssh keygen..."
yes n | ssh-keygen -t rsa -b 4096 -C "$GITHUB_EMAIL" -N "" -f /root/.ssh/id_rsa

echo "start hook..."
/go/bin/webhook -hooks /app/hooks.json -verbose



