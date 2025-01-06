# TO DO

- Create ecsTaskExecutionRole

# AMI Image

Download and install packer to build a new AMI image based off Ubuntu 24.04.

https://developer.hashicorp.com/packer/install

You will need to update the AWS profile to match your credentials file. Packer should be run from your workstation/laptop. You will also need to update the VPC and Subnet in the variables section.

```
cd packer
packer build ubuntu-24.04 
```

Update terraform.tfvars with the AMI you created.

# Installation

Update the settings in terraform.tfvars including the cluster name and VPC CIDRs.

```
terraform init
terraform validate
terraform plan -out plan.txt
terraform apply "plan.txt"
```

### Credits
Credits: https://spacelift.io/blog/terraform-ecs (Sumeet Ninawe)

- The code from the source site was re-formatted to work as a Terraform module.

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

To create the image change to the Docker directory then run the following:

Note: you must first have docker installed. (https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-20-04)

```
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin <account-id>.dkr.ecr.<region>.amazonaws.com
docker build -t ecs-demo-image .
docker tag ecs-demo-image:latest <account-id>.dkr.ecr.<region>.amazonaws.com/ecs-demo-image:latest
docker push <account-id>.dkr.ecr.<region>.amazonaws.com/ecs-demo-image:latest
```

### Destroy Cluster

Note: If you created an EC2 to create the ECR image under the same VPC as the cluster you must 
manually terminate that EC2 first or the VPC will fail to delete.

```
terraform plan -destroy
terraform apply -destroy
```
