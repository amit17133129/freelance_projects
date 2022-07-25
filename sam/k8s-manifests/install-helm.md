curl -L https://git.io/get_helm.sh | bash -s -- --version v3.8.2



# save your credentials to .kube folder.
aws eks --region region update-kubeconfig --name cluster_name
