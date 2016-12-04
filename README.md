## Deploy single node kubernetes on the quick

This tool can be used to deploy single node kubernetes cluster on
aws/gce or bare metal pretty quickly. Few major differences from kube-up.sh

* It doesn't require extensive permissions on aws or gce account
* It deploys everything as blowed up executables and runs them using Invoker(http://invoker.codemancers.com/)
* Assumes a running instance accessible via ssh key. In case of GCE - instance should have Compute and storage
  permissions at minimum (You can set these permissions when you boot an instance.)

![GCE Perm](https://raw.githubusercontent.com/gnufied/k8s_playbook/master/images/gce_perm.png "GCE perm")

### Getting started

Here are the steps to getting started quickly(all done on your personal computer).

* Clone the project via:

```
~> git clone git@github.com:gnufied/k8s_playbook
```
* Create a `cloud.fact` file in root of your cloned repo. Example fact files for gce and aws are
   included in `example_facts` directory of this project. Modify `cloud.fact` as needed.
* Launch kubernetes cluster:

```
~> ./create_cluster <ip_address> -u <user> -k <ssh_private_key> -l <location_of_compiled_k8s_binaries>
```

Some things to keep in mind, do not foget *trailing /* when giving path to compiled binaries. Without `-l`
option, kubernetes will be compiled on the cloud vm. Compiled directory is rsynced to cloud vm, do not use
symbolic links to path. A sample invocation could be:
```
~> ./create_cluster 128.0.0.1 -u ubuntu -k ~/.ssh/awskey.pem -l /home/gnufied/goal/src/k8s.io/kubernetes/_output/local/bin/linux/amd64/
```
* SSH to your cluster:

```
~> kubectl get nodes
```
* Kubernetes and etcd are running using `invoker` on cloud vm. Invoker(http://invoker.codemancers.com/) is kind of a process supervisor.
   Use following commands to interact with your instance on Cloud VM:

```
# list running processes using invoker
~> sudo invoker list
# View log of controller and kubelet
~> sudo invoker tail controller kubelet
# Stop controller
~> sudo invoker remove controller
```
