# Terraform-VPC

### Prerequisite

- IAM user with administrator access
- [Terraform](https://www.terraform.io/downloads.html)

### Installation and Execution

1. To install terraform, run the following commands to download the package.

```
# wget https://releases.hashicorp.com/terraform/1.0.8/terraform_1.0.8_linux_amd64.zip
# unzip terraform_1.0.8_linux_amd64.zip
# mv terraform /usr/local/bin/
```
2. Verify the installation

```
# terraform version 
Terraform v1.0.8
on linux_amd64
```
3. Initialize a working directory containing Terraform configuration.

```
# terraform init 
```
4. Terraform Plan reads the current state of any already-existing remote objects to make sure that the Terraform state is up-to-date. 

```
# terraform plan 
```
5. The terraform apply command executes the actions proposed in a Terraform plan.

```
# terraform apply 
```

### Result

