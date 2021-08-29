         ___        ______     ____ _                 _  ___  
        / \ \      / / ___|   / ___| | ___  _   _  __| |/ _ \ 
       / _ \ \ /\ / /\___ \  | |   | |/ _ \| | | |/ _` | (_) |
      / ___ \ V  V /  ___) | | |___| | (_) | |_| | (_| |\__, |
     /_/   \_\_/\_/  |____/   \____|_|\___/ \__,_|\__,_|  /_/ 
 ----------------------------------------------------------------- 


Hi there! Welcome to AWS Cloud9!

To get started, create some files, play with the terminal,
or visit https://docs.aws.amazon.com/console/cloud9/ for our documentation.

Happy coding!



**README.md**:


- Terraform is very peculiar about the language you are using in error messages or notification messages. It should start with an uppercase letter and ends with a period (.) or ?.


**Variables and Output Files**:

- It is generally a good practice to keep our output piece and variables piece in separate files for better readability and code cleaning.
- In terraform any file that ends with `.tf` is basically considered for the `apply`.


**Security of the Variables Definition (Sensitive variables and .tfvars file)**:

- In order to avoid our variables value not getting exposed we used to put the values for the variables in a separate file known as variables definition file (terraform.tfvars) and should include this filename in our `.gitignore file`.


**Variable Definition Precedence**:

- `terraform.tfvars` files are created to generally be ignored by your repository. 
- You want them to be ignored by a repository and you never want them to commit anywhere.
- If you want to override any variable value from the `terraform.tfvars` file you need to run the command `terraform apply -var-file = <file_name>`
- Or you can override the value from any of the file using CLI command `terraform apply -var <var_name>=value`

> NOTE: variable precedence matters a lot in terraform. for e.g. if we combine the above two commands i.e.
`terraform apply -var-file = <file_name> -var <var_name>=value`, the result will take `-var` value and if we change the position of variables the other one wins.


**Hiding Sensitive Variables from CLI (v 0.14+ only)**:

- From terraform version 0.14 onwards, there is a new feature where you can hide the variables value from the CLI using a feature called `sensitive flag` or `attribute` that you can add to your variables
 and output files.
- The dependencies between output and variables will not allow you to override `sensitive=true` because those variables still needs to be passed between modules, outputs etc.


**Bind Mount and Local-Exec**:

- Terraform is meant to be idempotent in nature which means it can run multiple times and maintain the same state without errors.


**Utilizing Local Values**:

- `[count.index]` will allow to access all of the elements within the list based on the number of iterations we have been through in a given script.
- Function calls are not allowed within variables.
- The primary objective for a local value is to provide a single place to modify something that you will be using frequently.


**Min and Max Functions and Expand Expression**:


**Path Reference and String Interpolation**:


**Maps and Lookups**:

- One of the way to manage different requirements for more than one environment, we need to utilize `maps` and `lookups`.

The signature for lookup method is: lookup(map, key, default)

    *managing image variable*:


**Terraform Workspaces**:
- Terraform Workspaces are the isolated version of terraform state that allows you to deploy multiple versions of the same environment potentially with different configurations, count and variable definition. 
- This can be useful when you need to deploy multiple environments (Staging, Development and Production) simultaneously without affecting one another.
- Typically these workspaces will be tied to branch names and source control.
- Workspaces work really well for the smaller deployments if the deployment begins to grow to the point where multiple teams of engineers are involved and differences between prod and dev becomes difficult to manage.

==================================================================
   Distinct Environments vs Terraform Workspaces (To Be Checked)
==================================================================

command to create terraform workspace: `terraform workspace new <workspace_name>`
To check in which workspace you are do: `terraform workspace show`
To check the list of workspaces created: `terraform workspace list`

`terraform.tfstate` is the default workspace.
To switch to a specific workspace: `terraform workspace select <workspace_name>`


**Referencing your Workspaces**:
- `terraform.workspace` shows which workspace we are currently in.


**Utilizing Map keys and lookup defaults**:

Lookup defaults is a secondary backup to `variable defaults`.


**MODULES**:

Modules are used to configure once in the root and share the variables that we configure into the specific modules.

Always run `terraform init` whenever you create a new module.

`Module Variables`:

When creating modular infrastructure you want to ensure that anything within the module is immutable and doesn't change unless there's some giant change in organization
infrastructure.

In the module anything under the source is considered as a variable for our `main.tf`
