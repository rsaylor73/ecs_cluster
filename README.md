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

## CI/CD

Create a separate ECR repo that is not in this terraform and build a basic nginx image.
You will want to use this instead of pulling from DockerHub to limit rate limit errors.

Dockerfile

```
FROM nginx
```

Then update the Dockerfile in your CI/CD repo with the ECR image:

Dockerfile in your CI/CD repo:

```
FROM <ACCOUNT_ID>.dkr.ecr.<REGION>.amazonaws.com/nginx:latest
COPY . /usr/share/nginx/html
```

Replace <ACCOUNT_ID> and <REGION> with its correct value for your AWS account.

Force the pipeline to run and the container will be updated with your web files from the CI/CD repo.

### Destroy Cluster

Note: you must delete all images in the ECR repository first.

```
terraform plan -destroy
terraform apply -destroy
```
