#!/usr/bin/env bash
set -e
IMAGE_NAME=$1
if [ -z "$IMAGE_NAME" ]; then
  echo "Usage: $0 <image-name>"
  exit 2
fi
trivy image --format json --output trivy-image.json --severity CRITICAL,HIGH $IMAGE_NAME || true
echo "Trivy image output saved to trivy-image.json"
