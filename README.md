# tasky-iac
Terraform IAC for tasky app

# Files structure

- Generic files
  - providers.tf : Defines AWS and Kubernetes Cluster config
  - variables.tf : Defines the needed variables for the terraform templates
  - outputs.tf : Not really needed, some output variables as an example

- S3 bucket configuration for MongoDB backups
	- aws-s3-mongodb-backup.tf : Creates the needed bucket and grants public access to it
	- aws-s3-mongodb-backup-iam.tf : Not needed, just a template for IAM users in case we need to define restricted access to the bucket

- Admin/Other stuff
	- backend.tf : Sets terraform backend to DynamoDB (lock) + S3 bucket (status sync)
	- aws-ssh-key.tf : Creates in AWS the public SSH key for EC2 instances access (EKS nodes and MongoDB EC2)
	- id_rsa.pub : Public SSH key
    