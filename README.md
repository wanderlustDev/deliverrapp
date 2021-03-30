# Deliverr Application Infrastructure

## Web Application
The sample Web App was built using Java and SpringBoot. The application connects to the AWS RDS database and uses 
Hibernate to access the DB. The DB used is PostgreSQL, this was added to verify that the Elastic Beanstalk Application
could get past the security and connect to the RDS Instance. If the application cannot connect to the RDS instance, the
EC2 instance will get terminated and the URL won't be accessible. The terraform configuration was first deployed to 
provide the rds config, and then the web app was deployed.

## AWS Infrastructure & Terraform
An IAM user was manually created in the AWS console to provide access to terraform. The Terraform configuration is setup
so as to allows for the customization of variables based on the environment. This thus allows you to run terraform 
commands by passing the environment-specific file e.g. `terraform plan -var-file=env/dev/dev.auto.tfvars`. This allows 
you to specify various variable values for the different environments.
Main resources have been created in a separate modules to allow for reuse in creating new resources and little or no 
duplication of code. The following resources have been created:
1. Elastic Beanstalk Application
   - Java Application JAR file is zipped and published to S3.
   - Zipped file is then accessed in S3 to pull the app in EB.
   - A Security group was defined which allows TCP inbound and All outbound traffic. Ideally this will only allow 
   traffic to resources that communicate with it.
2. RDS Instance
   - An RDS Instance was created using PostgreSQL.
   - A security group was added which only allows inbound traffic from the Elastic Beanstalk application.
3. IAM Instance profile and role are created to give a user console access and EB application access to all 
resources needed respectively. The ideal approach for the IAM policy will be to limit the access to only specific 
resources and actions.
4. VPC: Using AWS Default VPC
   - An Elastic IP Address was created for the VPC.
   - A public subnet was created and 2 private subnets were created for the RDS instance.
   - 2 Route tables were created, each for the public and private subnets to be associated with.
5. S3 Bucket: An S3 bucket was created to hold the web app jar and use for deploying the app to Elastic Beanstalk.

### Environment Variables
The following environment variables (`access_key`, `secret_key` and `rds_password`) were defined for the AWS Access Key,
AWS Secret Key and RDS Password respectively. These values are not provided in the repo and can be supplied by 
exporting the specific values to TF_VARS_<variable_name> (`export TF_VARS_access_key=*******`) before the execution 
of a terraform command. This ensures that the secrets aren't stored in any version control files and thus more secure. 
Another best practice will be to store these variables in a secure password manager like Harshicorp Vault or 1Password. 
They can then be retrieved and updated before the execution of every terraform command.

### Jenkinsfile
Please note that this was a rough sketch. It was not deployed or tested. This rough sketch of a Jenkins file was added. 
The idea here is to create a Jenkins pipeline which points to this Jenkinsfile in GitHub. The configuration and application 
deployments can then be managed in one run. Other things to add will be:
1. Error handling - to allow graceful exit with readable error messages
2. Add user prompt for `terraform apply` so that user can verify output of terraform plan before applying.

## Test Application & Configuration
This simple app was deployed and is currently available on this endpoint: 
To test, enter this URL in a browser http://deliverr-dev-eb-env.eba-x8ftyavc.us-west-2.elasticbeanstalk.com/sayhello 
or replace <your_name> in http://deliverr-dev-eb-env.eba-x8ftyavc.us-west-2.elasticbeanstalk.com/sayhello?name=<your_name> 
with your name for a fun message. When asked for password, enter usename="username" and password="password" and you 
should get a cool fun response :D.
