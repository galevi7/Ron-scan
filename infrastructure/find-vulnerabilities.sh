#!/bin/bash
echo "==================================="
echo "  RON-SCAN: Vulnerability Scanner"
echo "==================================="
echo ""
echo "Scanning all organs for exposed nerve-receptor ports..."
echo ""

# Find services that are NodePort (exposed) vs ClusterIP (internal)
echo "--- EXPOSED ORGANS (NodePort) ---"
kubectl get svc -A -o custom-columns=\
'NAMESPACE:.metadata.namespace,SERVICE:.metadata.name,TYPE:.spec.type,PORTS:.spec.ports[*].nodePort' \
| grep NodePort

echo ""
echo "--- ALL ORGANS COMPARISON ---"
kubectl get svc -A --no-headers | grep -v kube-system | grep -v default | \
  awk '{printf "%-15s %-20s %s\n", $1, $2, $3}'

echo ""
echo "==================================="
echo "  Organs with NodePort are reachable"
echo "  from OUTSIDE the cluster."
echo "  Cross-reference with os/ folder"
echo "  for the nerve impulse protocol."
echo "==================================="
