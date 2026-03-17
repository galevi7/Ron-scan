# Infrastructure Sector - Ron's Brain Cluster

> **Agent 1 - Your Mission: Deploy Ron's brain to a local Kubernetes cluster
> and figure out why the Facial Expression Controller keeps crashing.**

## Background

Ron's facial control system runs as a Kubernetes deployment. The cluster was
exported directly from the CerebralGit scan, but something is wrong - the
pods keep crashing and the silly face override is locked behind a corrupted
secret.

## Prerequisites

- [kind](https://kind.sigs.k8s.io/) installed
- [kubectl](https://kubernetes.io/docs/tasks/tools/) installed
- Docker running

## Step 1: Create the Cluster

```bash
kind create cluster --config kind-config.yaml
```

## Step 2: Deploy Everything

```bash
kubectl apply -f namespace.yaml
kubectl apply -f configmap.yaml
kubectl apply -f secret.yaml
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
```

## Step 3: Watch It Break

```bash
kubectl get pods -n ron-brain -w
```

You should see the pod going into `CrashLoopBackOff`. That's your starting
point.

## Investigation Guide

Start debugging. Here are some useful commands:

```bash
# Check pod status
kubectl get pods -n ron-brain

# Check pod logs - why is it crashing?
kubectl logs -n ron-brain <pod-name>

# Describe the pod for events and config
kubectl describe pod -n ron-brain <pod-name>

# Look at the configmap - anything suspicious?
kubectl get configmap brain-config -n ron-brain -o yaml

# Look at the secrets - but can you REALLY read them?
kubectl get secret ron-brain-secrets -n ron-brain -o yaml
```

## Hints (read only if stuck)

<details>
<summary>Hint 1 - Where to look</summary>
The pod crashes because the init container fails. Check the init container
logs specifically.
</details>

<details>
<summary>Hint 2 - The secret problem</summary>
Kubernetes secrets are base64 encoded. But what if someone encoded the value
BEFORE putting it in the secret YAML? That means Kubernetes decodes it once,
but you still get... another base64 string. Try decoding the secret values
TWICE.
</details>

<details>
<summary>Hint 3 - The configmap clue</summary>
Read the configmap carefully. There are commented-out lines that were
"deprecated" but they contain breadcrumbs. Cross-reference with the secret.
</details>

<details>
<summary>Hint 4 - The smoking gun</summary>

```bash
kubectl get secret ron-brain-secrets -n ron-brain -o jsonpath='{.data.trigger-phrase}' | base64 -d | base64 -d
```

The trigger phrase was double-encoded. Decode it twice and you'll find
Ron's silly face trigger.
</details>

## What You're Looking For

1. Why the pod crashes (the init container validation fails)
2. The double-encoded secret and what it actually says
3. The commented-out override code in the configmap
4. The trigger phrase hidden in the secrets

Film yourself going through the debugging process. The moment of discovery
is what we want on camera.

---

*"His infrastructure is solid, but his secrets are not." - CerebralGit Report*
