# azure-cloud-foundation

## Setting up the service principle
Follow this guide. https://learn.microsoft.com/en-us/azure/developer/github/connect-from-azure?tabs=azure-portal%2Clinux

## Migrating the state file
Follow the migrating state file section of this guide: https://dev.azure.com/ostusa/Digital%20Operations/_wiki/wikis/Modern-IT.wiki/1257/Deployment

## YAML
Use the template from https://dev.azure.com/ostusa/Digital%20Operations/_git/DevOps-Azure-GithubActions-TF-Cloud-Foundation-5-Subscription

Before the terraform plan job, create an artifact directory using mkdir. 

After the terraform plan job, use actions/upload-artifact to upload the artifact. https://github.com/actions/upload-artifact

After the terraform plan status job, use dawidd6/action-download-artifact to download the artifact. https://github.com/dawidd6/action-download-artifact

