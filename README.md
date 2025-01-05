Credits: https://spacelift.io/blog/terraform-ecs (Sumeet Ninawe)

- The code from the source site was re-formatted to work as a Terraform module.

# Installation

Update the settings in terraform.tfvars including the cluster name and VPC CIDRs.

```
terraform init
terraform validate
terraform plan -out plan.txt
terraform apply "plan.txt"
```

### RSA Key

Create a key in EC2 and name it 'ecs-key'

### ECR Image

Note: You must create a docker image and push that image to ECR. In order
to do that you must first run the terraform code. At some point the code
will fail because the image is missing. Once the ECR is created you can 
then launch an EC2 image to create a docker image and push it to the ECR.

Attach the ec2-role to the EC2 so the EC2 will have proper permissions
to push to the ECR repository.

Re-run terraform plan and apply once the image is pushed to ECR.

### Destroy Cluster

Note: If you created an EC2 to create the ECR image under the same VPC as the cluster you must 
manually terminate that EC2 first or the VPC will fail to delete.

```
terraform plan -destroy
terraform apply -destroy
```
