//variable "environment_name" { default = "All Environments" }
variable "environment_prefix" {}
variable "primary_location" {}
//variable "subscription_id" { default = "xxx"}
variable "tags" {}
variable "environments" {
  
}
variable "cust_management_group" {}

# Used during initial deployment when run locally outside of ADO
#variable "client_id" { default = "" } # Uncomment to run local, comment out for Azure DevOps
#variable "tenant_id" { default = "" } # Uncomment to run local, comment out for Azure DevOps
#variable "client_secret" { }                                               # Uncomment to run local, comment out for Azure DevOps