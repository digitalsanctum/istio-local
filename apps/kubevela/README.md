# kubevela apps

## App lifecycle example with Kubevela

First setup env:

```shell
vela env init test --namespace test
```

Next, create the app:

```shell
vela up -e test -f apps/kubevela/webservice-nginx.yaml
```

Check the status:

```shell
vela status test1
```

Delete the app:

```shell
vela delete -e test -n test test1 -y
```
