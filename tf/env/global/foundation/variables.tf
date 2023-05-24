//variable "environment_name" { default = "All Environments" }
variable "environment_prefix" {}
variable "primary_location" {}
//variable "subscription_id" { default = "xxx"}
variable "cust_management_group" {}
variable "ost_admins_group" {}
variable "environments" {}
variable "tags" {}
variable "role_assignments" {}
variable "policies" {}
variable "epic_envs" {}
variable "contact_emails" {}

# Used during initial deployment when run locally outside of ADO
#variable "client_id" { default = "" } # Uncomment to run local, comment out for Azure DevOps
#variable "tenant_id" { default = "" } # Uncomment to run local, comment out for Azure DevOps
#variable "client_secret" { }                                               # Uncomment to run local, comment out for Azure DevOps