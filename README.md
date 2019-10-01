# Kubectl with Plugins
Kubectl bundled with some plugins

## Run
```powershell
docker build -t krew .
```
```powershell
docker run -it --rm -v $env:USERPROFILE\.kube:/kube -e KUBECONFIG="/kube/config:/kube/config" krew
```

## Tools

### [Kubectl Krew](https://github.com/kubernetes-sigs/krew)
Package manager for kubectl plugins

### [Kubectl Capture](https://github.com/sysdiglabs/kubectl-capture)
A kubectl plugin which triggers a Sysdig capture

### [Kubectl Dig](https://github.com/sysdiglabs/kubectl-dig)
Deep kubernetes visibility from the kubectl