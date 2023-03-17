Create Two users from aws console and give both adminstrator permission
1. k8s-admin
2. developer

####################################################################################

Then we will be creating the role and role bindings
```
kind: Role
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  namespace: development
  name: development-manager
rules:
- apiGroups: ["", "extensions", "apps"]
  resources: ["deployments", "replicasets", "pods"]
  verbs: ["get", "list", "watch", "create", "update", "patch", "delete"]
```  
## kubectl apply -f role.yaml
####################################################################################
Then create rolebinding
```
kind: RoleBinding
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: development-manager-binding
  namespace: development
subjects:
- kind: User
  name: developer
  apiGroup: ""
roleRef:
  kind: Role
  name: development-manager
  apiGroup: ""
```
## kubectl apply -f rolebinding.yaml
####################################################################################
Then edit the below file

kubectl edit -n kube-system configmap/aws-auth

```
  mapRoles: |
    - groups:
      - system:bootstrappers
      - system:nodes
      rolearn: arn:aws:iam::609607905204:role/eksctl-mycluster123-nodegroup-ng-NodeInstanceRole-7P4P954GLGYW
      username: system:node:{{EC2PrivateDNSName}}
  mapUsers: |
    - userarn: arn:aws:iam:609607905204::user/k8sadmin
      username: k8sadmin
      groups:
        - system:masters
    - userarn: arn:aws:iam::609607905204:user/developer
      username: developer
      groups:
        - development-manager
        
```
Only add the mapUsers section where we have k8sadmin and developer users
####################################################################################


Now after this you will be exporting below command
```
export AWS_DEFAULT_PROFILE="k8sadmin"   -- for all the access
export AWS_DEFAULT_PROFILE="developer"  -- for the limited access which you have given in the role creation above.
```
```
kubectl get pods -n development -- will only for developer
kubectl get pods -- will not work for developer
```

referal links: 

1. https://towardsaws.com/controlling-aws-eks-access-using-aws-iam-and-kubernetes-rbac-9309d5ac4d11
2. https://github.com/aws/containers-roadmap/issues/1604
