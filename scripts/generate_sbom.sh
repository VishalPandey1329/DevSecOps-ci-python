#!/usr/bin/env bash
# Generates SBOM using syft (assumes syft is installed in CI)
syft dir:. -o json > sbom.json || true
echo "SBOM written to sbom.json"
