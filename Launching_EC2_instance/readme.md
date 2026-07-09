# Launching an EC2 Web Server with Terraform

## Overview
This lab provisions a fully functional AWS EC2 web server using Terraform — from writing the configuration files to validating, planning, applying, and tearing down the infrastructure. The goal was to reinforce a clean, modular file structure and practice the core Terraform workflow end to end.

## File Structure
Following the pattern established in the previous lab, the project was organized before any code was written:

```
├── main.tf
├── variables.tf
├── outputs.tf
├── provider.tf
├── userdata.sh
└── terraform.tfvars
```

Separating configuration this way keeps the project readable and mirrors how Terraform projects are structured in real-world, production environments.

## Configuration Walkthrough

### Variables & tfvars
Variables were defined in `variables.tf` and assigned values in `terraform.tfvars`, rather than hardcoding them directly into `main.tf`. This keeps sensitive or environment-specific values out of the core configuration and makes the project easier to reuse across environments.
![Variables](/Launching_EC2_instance/Images/variables_tfvar.png)
*tfvars passes the values for the variables*


### User Data Script
A bash script runs on the instance's first boot to install and configure a web server:

```bash
#!/bin/bash

yum update -y
yum install httpd -y
systemctl start httpd
systemctl enable httpd

echo "<h1> Hello from Terraform </h1>" > /var/www/html/index.html
```

| Command | Purpose |
|---|---|
| `yum update -y` | Checks for updates (`-y` removes the interactive prompt) |
| `yum install httpd -y` | Installs the Apache web server |
| `systemctl start httpd` | Starts the Apache service immediately |
| `systemctl enable httpd` | Ensures Apache starts automatically on any future reboot |

### Main Configuration
`main.tf` ties everything together:
- A **data block** queries AWS for the most recent Amazon Linux AMI, rather than hardcoding an AMI ID
- A **security group resource** defines inbound/outbound rules (intentionally permissive for lab purposes)
- The **EC2 instance resource** references the AMI data source, security group, and user data script
  ![Main.tf](/Launching_EC2_instance/Images/main.png)

### Outputs
`outputs.tf` was configured to surface key information — like the instance's public IP — needed for testing and validation once the server was live.
![Outputs](/Launching_EC2_instance/Images/outputs.png)

## Terraform Workflow
With the configuration complete, I ran through the standard Terraform workflow:

1. **`terraform init`** — initializes the working directory and providers

2. **`terraform validate`** — catches syntax and configuration errors before touching AWS
 <p float="left">
   <img src="/Launching_EC2_instance/Images/val-error.png" width "33%">
   <img src="/Launching_EC2_instance/Images/val-success.png" width "33%">
 </p>
 
3. **`terraform plan`** — previews the changes Terraform intends to make
 <p float="left">
   <img src="/Launching_EC2_instance/Images/plan_error.png" width "33%">
   <img src="/Launching_EC2_instance/Images/plan_success.png" width "33%">
 </p>
 
4. **`terraform apply --auto-approve`** — provisions the resources
   ![Terraform Apply](/Launching_EC2_instance/Images/apply_success.png)
   
5. **`terraform destroy`** — tears down all resources once testing was complete
   ![Terraform Destroy](/Launching_EC2_instance/Images/destroy.png)

`validate` and `plan` caught a configuration error before it ever reached AWS — a good reminder of why those steps aren't optional, even in a lab environment.

## Verification
After applying, I confirmed the web server was live by hitting the public IP/URL output by Terraform and loading the "Hello from Terraform" page in-browser.

![URL-validation](/Launching_EC2_instance/Images/url.png)
![Console](/Launching_EC2_instance/Images/console.png)

## Key Takeaways
- Structuring a project into separate files (`main`, `variables`, `outputs`, `provider`) makes configurations easier to read, maintain, and scale
- Using variables and `.tfvars` avoids hardcoding sensitive or environment-specific data
- `validate` and `plan` are essential guardrails — they surfaced and helped resolve an error before `apply`
- User data scripts allow infrastructure and initial server configuration to be provisioned together in a single workflow

## Tech Used
`Terraform` · `AWS EC2` · `AWS Security Groups` · `Bash` · `HTTPD (Apache)`
