# Istio Kubernetes Gateway



## Flow
```mermaid
graph TD
    A["Kubernetes Gateway"] --> B["HttpRoute"] --> C["Service"] --> D["Deployment"]
```