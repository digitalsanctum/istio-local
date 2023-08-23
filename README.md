# istio-local

This is a POC to setup Istio infrastructure locally.


## Usage

### Create a new kind cluster and install tools

```shell
./up.sh
```

Once completed, your current kubectl context should automatically be pointed to the new cluster.

### Delete cluster

```shell
./down.sh
```
