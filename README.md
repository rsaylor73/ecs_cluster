# Installation

Update the settings in terraform.tfvars including the cluster name and VPC CIDRs.

```
terraform init
terraform validate
terraform plan -out plan.txt
terraform apply "plan.txt"
```

### Destroy Cluster

Note: If you created an EC2 to create the ECR image under the same VPC as the cluster you must 
manually terminate that EC2 first or the VPC will fail to delete.

```
terraform plan -destroy
terraform apply -destroy
```
