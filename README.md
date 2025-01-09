# Installation

Update the settings in terraform.tfvars including the cluster name and VPC CIDRs.

```
terraform init
terraform validate
terraform plan -out plan.txt
terraform apply "plan.txt"
```

Note: during Terraform apply you might have to run it again a few mins later if you
get an error with the autoscaling group.

### Destroy Cluster

```
terraform plan -destroy
terraform apply -destroy
```
