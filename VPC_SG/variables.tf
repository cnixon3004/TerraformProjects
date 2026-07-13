variable "vpc_cidr" {
  description = "CIDR block for the network"
  type        = string
  default     = "10.0.0.0/16"
}
variable "environment" {
  description = "Environment name"
  type        = string
  default     = "Testing"
}
variable "pub_sub_cidr" {
  description = "CIDR block for the Public network"
  type        = string
  default     = "10.0.1.0/24"
}

variable "priv_sub_cidr" {
  description = "CIDR block for the Private network"
  type        = string
  default     = "10.0.2.0/24"
}

variable "availability_zone" {
  description = "Availability zone for subnets"
  default     = "us-east-1a"
}