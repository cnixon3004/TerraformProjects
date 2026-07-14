# Terraform AWS VPC & Security Group Lab

A hands-on Terraform project that builds a reusable base network — a custom VPC, public subnets, a route table, and a security group — designed to serve as the default networking foundation for future AWS experimentation and training labs.

## 📌 Overview

After building an S3 bucket and an EC2 instance in earlier labs, this project was the natural next step: instead of provisioning ad-hoc networking every time, I built a standalone VPC module that can act as the underlying infrastructure for future labs.

Think of it like this: the **VPC is the neighborhood**, and the **subnets are the roads** that let traffic move through it.

## 🏗️ Architecture

- 1 custom VPC (`us-east-1`)
- 1 public subnet and 1 private subnet, both within the same Availability Zone
- 1 route table, associated with both subnets
- 1 security group allowing inbound HTTP (80) and HTTPS (443) traffic
- Default resource tagging applied via the provider block

## 🗂️ Project Structure

```
.
├── main.tf          # Data + resource blocks (VPC, subnets, route table, SG)
├── variables.tf      # Input variable declarations
├── outputs.tf         # Output values (VPC ID, subnet IDs, etc.)
├── provider.tf        # Provider config, version constraints, default tags
└── terraform.tfvars   # Variable value assignments
```

## ⚙️ What I Did

1. **Scaffolded the project** with the standard file layout (`main.tf`, `variables.tf`, `outputs.tf`, `provider.tf`, `terraform.tfvars`).
   ![File Structure](/VPC_SG/Images/file_structure.png)
   
2. **Configured the provider** — pinned the required version close to the local Terraform install, set the target region (`us-east-1`), and applied default tags to all resources.
  ![Providers](/VPC_SG/Images/providers.png)

3. **Declared variables** in `variables.tf` and assigned real values in `terraform.tfvars`.
   ![Variable](/VPC_SG/Images/variables.png)
   
4. **Defined outputs** for values I'd want to reference later (VPC ID, subnet IDs, etc.).
   ![Outputs](/VPC_SG/Images/outputs.png)
   
5. **Built the network in `main.tf`:**
   - Added `data` blocks to pull region, caller identity, and availability zone info dynamically.
   - Created the VPC with one public subnet and one private subnet, both in the same Availability Zone.
   - Created a route table and associated both subnets with it.
   - Added a security group allowing only HTTP/HTTPS traffic as a basic security baseline.

6. **Validated the tfvars file** to confirm all values were correct before deploying.
   ![tfvars](/VPC_SG/Images/tfvars.png)
   
9. **Deployed the infrastructure:**
   ```bash
   terraform fmt        # Standardize formatting
   terraform validate   # Catch syntax/variable errors offline
   terraform plan       # Preview the changes
   terraform apply -auto-approve
   ```
   ![Apply](/VPC_SG/Images/apply.png)
10. **Verified the build** by logging into the AWS Console and confirming the VPC, subnets, route table, and security group were created as expected.
    ![Console](/VPC_SG/Images/console.png)

## 🎯 Key Takeaways

- Getting more comfortable reading and writing HCL syntax.
- Understanding how `data` blocks pull live account/region info into a configuration.
- Practicing the full Terraform workflow: `fmt` → `validate` → `plan` → `apply`.
- Thinking about infrastructure as *reusable building blocks* rather than one-off resources — this VPC is meant to be the foundation for future labs.

## 🚀 Next Steps

- Expand subnets across multiple Availability Zones for high availability.
- Add a NAT Gateway so the private subnet can reach the internet outbound.
- Parameterize the module so it can be reused across environments (dev/test/prod).
- Layer on additional security groups and NACLs for more granular traffic control.

---

📎 *Part of an ongoing series of hands-on AWS + Terraform labs.*
