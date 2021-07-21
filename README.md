# Istio Helm Charts

Istio can be [installed through Helm][istio-helm], but Istio’s maintainers [don’t publish a repository][istio-issue] of the Istio charts.

This repository fills that gap.

[istio-helm]: https://istio.io/latest/docs/setup/install/helm/
[istio-issue]: https://github.com/istio/istio/issues/31275

## How to deploy Helm Chart

- Install [chart-releaser](https://github.com/helm/chart-releaser)
- Export variable `CR_TOKEN` with github token
- Run `make`
- Push to github which will trigger Environment deploy

## Install Istio from Chart

First, add this Helm repository:

```sh
helm repo add istio https://comocomo.github.io/istio-charts/
```

Then, follow the [Istio Helm installation instructions][istio-install], using the charts in this repository for instead of the `manifests/` paths:

```sh
kubectl create namespace istio-system
```

```sh
helm install istio-base istio/base -n istio-system
```

```sh
helm install istiod istio/discovery -n istio-system
```

Once those core components are installed, you can install Istio ingress and egress gateways:

```sh
helm install istio-ingress istio/ingress -n istio-system
```

```sh
helm install istio-egress istio/egress -n istio-system
```

[istio-install]: https://istio.io/latest/docs/setup/install/helm/#installation-steps
