terraform {
  required_providers {
  }
  required_version = ">= 1.2.0"
}

variable "N1" {
  default     = 100
  type        = number
  description = "First Number"
}

variable "N2" {
  default     = 200
  type        = number
  description = "First Number"
}

locals {
  Sum = var.N1 + var.N2
}

output "Sum" {
  value = local.Sum
}
