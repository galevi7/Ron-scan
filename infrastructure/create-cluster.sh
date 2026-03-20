#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"

echo "==================================="
echo "  RON-SCAN: Deploying Ron's Body"
echo "==================================="
echo ""

echo "[1/3] Creating kind cluster..."
kind create cluster --config kind-config.yaml

echo ""
echo "[2/3] Deploying organs..."
kubectl apply -f namespace.yaml
kubectl apply -f configmap.yaml
kubectl apply -f secret.yaml
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml

echo ""
echo "[3/3] Waiting for pods to start..."
sleep 10
kubectl get pods -A --no-headers | grep -v kube-system | grep -v local-path

echo ""
echo "==================================="
echo "  Ron's body is online."
echo "  Run ./find-vulnerabilities.sh"
echo "  to start the investigation."
echo "==================================="
