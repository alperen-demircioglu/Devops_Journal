#!/usr/bin/env bash
# Interactive: asks for the fields and appends a row to mistakes.md
set -euo pipefail
file="$(dirname "$0")/mistakes.md"

read -rp "Source (Killer.sh / KK mock / lab): " source
read -rp "Topic (etcd, RBAC, kubeadm, ...): " topic
read -rp "Mistake → Fix: " text

# '|' would break the markdown table
source=${source//|/\\|}; topic=${topic//|/\\|}; text=${text//|/\\|}

row="| $(date +%F) | $source | $topic | $text |"
echo "$row" >> "$file"
echo "added: $row"
