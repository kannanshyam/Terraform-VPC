# Terraform-VPC

A code that impliments a VPC with 3 Public and Private subnets that is being integrated with route table for both the subnets. The private route table is tegged with the internet gateway and public route table with the NAT gateway.

The code thus generates::

1. VPC
2. Public and Private Subnets
3. Public and Private Route table
4. Elastic IP for Route table
5. Route table
6. NAT Gateway
7. Internet Gateway
8. Bastion Server (SSH Access)
9. Webserver (HTTP/HTTPS and SSH access from bastion server)
10. Database Server (Access from webserver and bastion server)

### Prerequisite

- IAM user with administrator access
- [Terraform](https://www.terraform.io/downloads.html)

### Installation

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
### Variables

In accordance with our requirement the variables may be changed.

- region :: Assign the region for VPC
- access_key :: AWS_ACCESS_KEY_ID
- secret ket :: AWS_SECRET_ACCESS_KEY
- vpc_cidr :: The CIDR block for VPC
- project :: Assign a tag that can implies the project or env

### Execution

Initialize a working directory containing Terraform configuration.
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

## Result

A VPC with a set of 3 public and 3 private subnets will be implimented, which gets integaretd to respective servers. The traffic flow will take place in accordance to the security groups being attached.

The result will also shows the set of public and private ips assigned to each servers as taken up by output.tf
