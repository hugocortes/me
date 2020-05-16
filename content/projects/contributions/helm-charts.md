---
title: Helm Chart Fixes
description: >-
  I've provided fixes to various Helm charts that addresses issues or adds
  improvements to the manner that the application is managed.
featured: true
tags:
- helm
- kubernetes
- yaml
sitemap:
  priority: 0.8
---

I've grouped all Helm chart related fixes into this list as they're all pretty small changes:
* [helm/charts #17271](https://github.com/helm/charts/pull/17271)
  * After installing the PostgresQL helm chart, the Kubectl command had the incorrect secret if using an existing secret.
* [openfaas/faas-netes #505](https://github.com/openfaas/faas-netes/pull/505)  
  * Istio mTLS destination rules would only be applicable to the default Helm chart namespace installation target.
* [solo-io/squash #52](https://github.com/solo-io/squash/pull/52)
  * Cluster role bindings were rejected by Kubernetes api server as `namespace` is a required field.
* [pomerium/pomerium-helm #60](https://github.com/pomerium/pomerium-helm/pull/60) 
  * When providing an `existingSecret` to the helm chart, the helm `_helpers` was referencing the incorrect object.
* [influxdata/helm-charts #41](https://github.com/influxdata/helm-charts/pull/41)
  * Helm chart exposes influxdata which is configured with a mix of `Boolean` and `String` values and the values were all interpreted as a string.
* [codecentric/helm-charts #178](https://github.com/codecentric/helm-charts/pull/178)
  * When deploying Keycloak in a cluster with >1 nodes, it would lead to a split brain cluster as not all nodes are ready when the next when beings its deployment.
