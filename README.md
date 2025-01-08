# Installation

Update the settings in terraform.tfvars including the cluster name and VPC CIDRs.

```
terraform init
terraform validate
terraform plan -out plan.txt
terraform apply "plan.txt"
```

### Destroy Cluster

```
terraform plan -destroy
terraform apply -destroy
```
