# compulsory2

## How to run
- Set up a terraform backend for tfstatefiles. Either run your own or download this: https://github.com/Endroma1/tf-backend.
- If running own backend, change the parameters of the backend in the root main so that it fits your resource group and its contents
- Change the rg-name to whatever fits your needs.
- Add the enviroment variables for azure authentication to either git or the terminal depending on your use.
- Run by commiting to a repo or in terminal.

## How it works
When a branch is created and committed, it is sent through the validate workflow which further sends it thriugh tfsec and tflint tests. If merged to main, it is sent to devstageprod.yml which deploys it to dev, then stage then for a final approval in prod. The modules are coded so that they can easily be changed in the modules folder. The root main binds them together and is responsible for sending variables from the tfvar files.

## Report
```
azure-terraform-project/
│
├── modules/
│   ├── networking/
│   ├── app_service/
│   ├── database/
│   ├── storage/
│   └── nn/
│
├── deployments/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   │
│   ├── terraform.tfvars.dev
│   ├── terraform.tfvars.staging
│   └── terraform.tfvars.prod
│
├── global/
│   └── main.tf
│
└── README.md
```
The folder structure were chosen because it is compact and lessen the chance of the different enviroments going out of sync as all modules are shared between them. This makes it less flexible but easier to modify and append. Given the size of the task, it wouldn't make sense to completely partition the main files or the workspaces. This makes it more agile.

## Challenges
There were a few minor challenges setting up github. If the configuration is ran before the first commit, the exe files for the providers would be too large. This was easily fixed by simply excluding them in the .gitignore file.

## Potential improvements
There is currently no variables set for different parameters such as os_type, networks, etc. This makes the relevance for tfvars.X files lessen but not deemed too much of a problem because the scale and size of the project was small. There are already given names for each workspace automatically but variables can be appended to tfvars as needed through outputs.
Another improvement would be the the stage workflow which does not differ much from the dev. Perhaps some tests and approvals before it is sent to prod testing and approval
