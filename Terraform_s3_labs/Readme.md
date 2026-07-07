# AWS S3 Bucket Provisioning with Terraform



A hands-on Infrastructure as Code project that provisions an AWS S3 bucket using Terraform, with versioning enabled to protect against accidental overwrites and deletions. Built to practice core Terraform workflow fundamentals: provider configuration, variables, state management, and the plan/apply lifecycle.

## Architecture
![Architecture](/Terraform_s3_labs/Images/terraform_s3_architecture.png)
`[Terraform CLI] → [AWS Provider] → [S3 Bucket (versioning enabled)]`

## Repo Structure

```
.
├── main.tf              # Resource definitions (S3 bucket)
├── providers.tf         # AWS provider configuration
├── variables.tf         # Input variable declarations
├── terraform.tfvars     # Variable values (not committed if sensitive)
├── outputs.tf           # Output values (e.g. bucket ARN, name)
└── README.md
```

## Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/downloads) installed
- An AWS account with configured credentials (`aws configure`)
- AWS CLI installed

## Usage

**1. Verify your tooling and credentials:**
```bash
terraform version
aws sts get-caller-identity
```
![Verification](/Terraform_s3_labs/Images/validation.png)

**2. Initialize the working directory:**
```bash
terraform init
```
> `init` downloads the required provider plugins and sets up the backend. You only need to re-run this when starting a new project or changing providers.

**3. Validate the configuration:**
```bash
terraform validate
```

**4. Preview the changes:**
```bash
terraform plan
```

**5. Apply the configuration:**
```bash
terraform apply
```

**6. Verify in the AWS Console** that the S3 bucket was created with versioning enabled.

## Key Concepts Demonstrated

- **Provider configuration** — declaring and configuring the AWS provider
- **Input variables** — parameterizing region, bucket name, and tags via `variables.tf` and `terraform.tfvars`
- **Resource blocks** — defining an `aws_s3_bucket` resource
- **S3 versioning** — enabling versioning on the bucket (note: once enabled, versioning can only be suspended, not fully disabled)
- **Terraform workflow** — `init` → `validate` → `plan` → `apply`
- **State awareness** — understanding why a fresh `plan` shows all resources as "to be created" when no state exists yet

## What I Learned

Working through this project reinforced how Terraform's plan/apply cycle protects against unintended changes, and how something as small as enabling S3 versioning is actually a one-way door (you can suspend it, but never fully turn it back off). It also gave me a much better feel for how variables, provider blocks, and resource blocks work together instead of just reading about them.

## Future Improvements

- [ ] Move state to a remote backend (S3 + DynamoDB for locking)
- [ ] Break the bucket config into a reusable module
- [ ] Add bucket policies and encryption (SSE-KMS)
- [ ] Add a GitHub Actions workflow for `terraform fmt`, `validate`, and `plan` on PRs
- [ ] Parameterize for multiple environments (dev/staging/prod)

## Tech Stack

`Terraform` `AWS S3` `AWS CLI` `IAM`
