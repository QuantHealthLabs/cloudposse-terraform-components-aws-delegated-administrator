variable "region" {
  type        = string
  description = "AWS Region"
}

variable "delegated_administrators" {
  description = <<-EOT
    Map defining which AWS service principals should be delegated to which accounts.

    Each key represents an AWS account identifier (ID or name), and each value is a list of AWS service principals
    that will be **delegated administrator services** for that account.

    Example:
      {
        "123456789012" = ["config.amazonaws.com", "guardduty.amazonaws.com"]
        "network"      = ["securitylake.amazonaws.com", "macie.amazonaws.com"]
      }

    This variable allows defining multiple delegated admin configurations across accounts.
    The module will delegate each listed service principal to the corresponding account.
  EOT

  type    = map(list(string))
  default = {}
}

variable "account_map_tenant_name" {
  type        = string
  description = "The name of the tenant where `account_map` is provisioned"
  default     = "core"
}

variable "account_map_environment_name" {
  type        = string
  description = "The name of the environment where `account_map` is provisioned"
  default     = "gbl"
}

variable "account_map_stage_name" {
  type        = string
  description = "The name of the stage where `account_map` is provisioned"
  default     = "root"
}

variable "account_map_component_name" {
  type        = string
  description = "The name of the account-map component"
  default     = "account-map"
}
