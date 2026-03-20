# Infrastructure Sector - Ron's Body Cluster

> **Agent 1 - Your Mission: Deploy Ron's full body scan to a local Kubernetes
> cluster. Each organ is a namespace. Something isn't locked down the way
> it should be. Find it.**

## Background

Ron's body has been mapped to a Kubernetes cluster using CerebralGit. Each
organ runs in its own namespace with its own deployment and service. The
scan looks clean on the surface, but the scanner flagged something during
export — some body parts might be reachable from outside the cluster.

If you can figure out which ones, and how they accept input, you might be
able to trigger involuntary movement. Cross-reference with the Neural OS
in the `os/` folder — that's where the nerve impulse protocol lives.

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

## Step 3: Explore Ron

```bash
# See all of Ron's organs
kubectl get namespaces --show-labels

# What's running everywhere?
kubectl get svc --all-namespaces
```

## Investigation Guide

Start by getting a lay of the land. Look at what's deployed, how services
are configured, and whether everything is locked down the same way.

```bash
# Overview of all services
kubectl get svc -A -o wide

# Dig into a specific namespace
kubectl get all -n <namespace>

# Check namespace labels - anything stand out?
kubectl get ns --show-labels
```

Once you find something interesting, look at the `os/` folder. The nerve
system there speaks the same protocol as certain ports in this cluster.

## Hints (read only if stuck)

<details>
<summary>Hint 1 - Compare the services</summary>
Not all services are created equal. Compare the service types across
namespaces. Most are one type. A few are different.
</details>

<details>
<summary>Hint 2 - The port names matter</summary>
Every organ has a nerve-receptor port. But are they all protected the
same way? Check the service type for each.
</details>

<details>
<summary>Hint 3 - Connect the dots</summary>
The exposed ports accept nerve impulses. The os/ folder contains the
nerve system code that generates those impulses. If you can send the
right signal to the right port, you can make something move that Ron
didn't intend to move.
</details>

<details>
<summary>Hint 4 - The brain still has its own puzzle</summary>
The ron-brain namespace has a double-encoded secret. Decode it twice:

```bash
kubectl get secret ron-brain-secrets -n ron-brain -o jsonpath='{.data.trigger-phrase}' | base64 -d | base64 -d
```
</details>

## What You're Looking For

1. Which body parts are accessible from outside the cluster
2. What protocol those ports speak (check the os/ folder)
3. How to craft input that triggers involuntary movement
4. The double-encoded secret in ron-brain (bonus)

Film yourself going through the investigation. The discovery is the fun part.

---

*"Everything looked locked down. Almost everything." - CerebralGit Report*
