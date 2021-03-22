# Terraform_Example_AWS_Nginx
Utilizes Terraform to deploy Amazon Web Services (AWS) Virtual Private Cloud (VPC) &amp; Elastic Compute Cloud (EC2) instance, includes an nginx (HTTP) deployment

# Introduction
## Purpose
This purpose of this repository is to provide a sample Terraform template for deploying an Amazon Web Services (AWS) Virtual Private Cloud (VPC) &amp; Elastic Compute Cloud (EC2) instance, with an nginx (HTTP) deployment.

## Intended Audience
The intended audience for this manual is cloud administrators. Configuring the virtual private cloud (VPC) relies heavily on local area network (LAN) and wide area network (WAN) concepts (e.g. subnetting, routing, server configuration). Familiarity with these concepts aids in understanding each section of the template.

Important Note: This manual assumes users are familiar with navigating Amazon Web Services (AWS) services and Terraform. 

## Scope
As per the scope of this script, the template deploys: 
* a Virtual Private Cloud (VPC)
  * CIDR Block: 192.168.4.0/24
  * Enabled DNS Support
* a Subnet
  * CIDR Block: 192.168.4.0/26
* an Internet Gateway
* a Route Table & Route
  * Associates Route Table to Subnet
* a Security Group
  * Enables HTTP Access
  * Allows all outbound requests
* an EC2 Instance
  * Image: Ubuntu 20.04
  * Installs/Deploys Nginx server

This script does not allow SSH access, nor does it configure a key pair.

## Disclaimers
This script is intended for demonstation purposes only. It does not provide best security practices. 
* The image is not hardened. 
* A direct route to the instance is not configured.
* Security group contains open access. 
* The nginx software is not secured. 

# List of Materials and Equipment Needed
Users must configure these services prior to attempting to deploy the Terraform template: 
* Amazon Web Services (AWS) Account - An AWS account provides access to Amazon’s cloud services. NOTE: This account must have the appropriate permissions to deploy a VPC & EC2 instance. 
* Amazon Web Services (AWS) Command-Line Utility (CLI) - The AWS CLI is a command-line utility designed to provide terminal access to AWS services. 
* Terraform Command-Line Utility (CLI) - The Terraform CLI is a command-line utility designed to provide terminal access to Terraform features. 

WARNING: Both the AWS CLI & Terraform CLI must be configured prior to running the template. This includes configuring the AWS Access Key and Terraform Login. 

# Recommended Reading
* Amazon Web Services (AWS)
  * [AWS Command-Line Utility (CLI)](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-welcome.html)
* Terraform
  * [Terraform CLI](https://learn.hashicorp.com/tutorials/terraform/install-cli)
  * [Terraform AWS Synax](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
  * [Terraform Commands](https://www.terraform.io/docs/cli/commands/index.html)
