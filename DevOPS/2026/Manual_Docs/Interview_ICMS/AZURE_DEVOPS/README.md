# Cloudnivara Azure Infrastructure and Reusable Pipeline Templates

This repository contains two main things:

1. Terraform infrastructure definitions for Azure resource provisioning.
2. A modular Azure DevOps YAML pipeline that executes Terraform validation, planning, approval, and deployment using reusable templates.

This README focuses on the pipeline structure and how to execute it in Azure DevOps.

---

## 1. What this pipeline is

This is not a single large pipeline file with everything embedded in one place.

Instead, it follows a modular Azure DevOps pattern:

- Stage → Job → Step

That means the pipeline is broken into reusable building blocks:

- Stage templates: orchestration and stage ordering
- Job templates: execution units inside each stage
- Step templates: the actual task definitions such as Terraform init/plan/apply or security scans

This is similar to Terraform module design, where the overall system is composed from smaller reusable pieces.

---

## 2. Why this structure is used

A pipeline like this becomes hard to maintain when everything is stored in one huge YAML file.

The reusable template approach gives several advantages:

- Easier to understand and troubleshoot
- Reuse across multiple environments
- Clear separation of responsibilities
- Safer release flow with approvals
- Cleaner Git-based version control and review process

In this project, the flow is organized like this:

- Security scan stage
- Terraform init + validate stage
- Terraform plan stage
- Manual approval stage
- Terraform apply stage

This pattern is used widely in real enterprise Azure DevOps pipelines.

---

## 3. Pipeline structure in this repository

The root pipeline file is:

- `azure-pipelines.yml`

The reusable template folders are:

```text
templates/
├── stages/
│   ├── checkov.yml
│   ├── manual-approval.yml
│   ├── terraform-apply.yml
│   ├── terraform-init-validate.yml
│   ├── terraform-plan.yml
│   ├── tflint.yml
│   └── tfsec.yml
├── jobs/
│   ├── checkov.yml
│   ├── manual-approval.yml
│   ├── terraform-apply.yml
│   ├── terraform-init-validate.yml
│   ├── terraform-plan.yml
│   ├── tflint.yml
│   └── tfsec.yml
└── steps/
    ├── checkov.yml
    ├── manual-validation.yml
    ├── terraform-apply.yml
    ├── terraform-init.yml
    ├── terraform-plan.yml
    ├── terraform-validate.yml
    ├── tflint.yml
    └── tfsec.yml
```

### Stage level
A stage is a logical phase of the pipeline.

Examples:

- `TflintScan`
- `CheckovScan`
- `TfsecScan`
- `TerraformInitAndValidate`
- `TerraformPlan`
- `ManualApproval`
- `TerraformApply`

Each stage is defined in a file under `templates/stages` and is then included from the main pipeline file.

When manually running the pipeline, enter the approver username(s) in the **Approver username(s), separated by semicolons** parameter. This value is passed to the manual approval task.

### Job level
A job is the execution unit inside a stage.

Example:

- `TerraformInit`
- `TerraformPlan`
- `ManualValidate`
- `TerraformApply`

The job templates live under `templates/jobs` and are invoked by stage templates.

### Step level
A step is the actual action inside a job.

Examples:

- `TerraformTask@5` for `init`
- `TerraformTask@5` for `validate`
- `TerraformTask@5` for `plan`
- `TerraformTask@5` for `apply`
- `PowerShell@2` for `tflint`, `checkov`, and `tfsec`
- `ManualValidation@1` for approval

The step templates live under `templates/steps`.

---

## 4. How the root pipeline connects all templates

The root file `azure-pipelines.yml` is the parent pipeline.

It defines:

- pipeline parameters
- variables
- trigger rules
- stage ordering

Then it calls template files like this:

```yaml
stages:
  - template: templates/stages/tflint.yml
  - template: templates/stages/checkov.yml
  - template: templates/stages/tfsec.yml
  - template: templates/stages/terraform-init-validate.yml
  - template: templates/stages/terraform-plan.yml
  - template: templates/stages/manual-approval.yml
  - template: templates/stages/terraform-apply.yml
```

This means the main pipeline is simply a composition of smaller reusable modules.

---

## 5. Parameters required to run the pipeline

The root pipeline expects these parameters:

| Parameter name | Type | Required | Default | Description |
|---|---|---:|---|---|
| `environment` | string | Yes | `dev` | Target environment to deploy (`dev` or `prod`) |
| `RunTflintScan` | boolean | Yes | false | Enables/disables TFLint scan |
| `RunCheckovScan` | boolean | Yes | false | Enables/disables Checkov scan |
| `RunTfsecScan` | boolean | Yes | false | Enables/disables tfsec scan |
| `RunTerraformInitAndValidate` | boolean | Yes | false | Enables/disables init + validation stage |
| `RunTerraformPlan` | boolean | Yes | false | Enables/disables plan stage |
| `RunTerraformApply` | boolean | Yes | false | Enables/disables apply stage |

### Total parameter count

This pipeline has 7 parameters at the root level.

This is a good pattern for a reusable pipeline because the executor can choose which parts of the pipeline to run without editing YAML.

---

## 6. Variables used by the pipeline

The pipeline also uses a variable group:

- `VG-CloudNivara-KeyVault`

This variable group usually contains backend-related configuration such as:

- `BACKEND-RESOURCE-GROUP-NAME`
- `BACKEND-STORAGE-ACCOUNT-NAME`
- `BACKEND-CONTAINER-NAME`
- `BACKEND-TFSTATE-FILE-NAME`

And the pipeline maps them into Terraform backend variables.

### Important note
The pipeline expects these backend values to exist in Azure DevOps variable group or environment variables before execution.

If they are missing, `terraform init` will fail.

---

## 7. Execution flow of this pipeline

The operational flow is as follows:

### Stage 1: Tflint Scan
- Runs `tflint --init`
- Runs `tflint --recursive --force`
- Validates Terraform code quality

### Stage 2: Checkov Scan
- Runs `checkov -d . --soft-fail`
- Checks Terraform security misconfigurations

### Stage 3: Tfsec Scan
- Runs `tfsec .`
- Performs static security scanning

### Stage 4: Terraform Init and Validate
- Runs `terraform init` using AzureRM backend settings
- Runs `terraform validate`
- Confirms Terraform configuration is syntactically valid

### Stage 5: Terraform Plan
- Executes `terraform init` again if needed
- Runs `terraform plan`
- Shows the exact Azure resources that will be created or modified

### Stage 6: Manual Approval
- Stops execution for a human approval gate
- Requires a configured approver
- This is a safety checkpoint before actual deployment

### Stage 7: Terraform Apply
- Executes `terraform init`
- Runs `terraform apply`
- Creates or updates Azure resources

> Apply is only intended for a controlled and approved deployment path.

---

## 8. How to execute this pipeline in Azure DevOps

### Step 1: Prepare the Azure DevOps project

Make sure the following already exist in your Azure DevOps project:

- A repository containing this code
- A service connection for Azure authentication
- A variable group `VG-CloudNivara-KeyVault`
- Correct Azure RBAC permissions for Terraform deployment

### Step 2: Check the backend configuration

The pipeline uses AzureRM backend values for Terraform state. Ensure the following exist:

- Azure resource group for backend storage
- Azure storage account
- Azure container for state files
- The correct state file name

These values should be stored as pipeline variables or variable group entries.

### Step 3: Open the pipeline in Azure DevOps

- Go to Pipelines
- Select the pipeline connected to this repository
- Click `Run Pipeline`

### Step 4: Provide required parameters

When prompted, provide values for:

- `environment` → `dev` or `prod`
- `RunTflintScan` → `true` or `false`
- `RunCheckovScan` → `true` or `false`
- `RunTfsecScan` → `true` or `false`
- `RunTerraformInitAndValidate` → `true` or `false`
- `RunTerraformPlan` → `true` or `false`
- `RunTerraformApply` → `true` or `false`

### Step 5: Start the run

After clicking run, Azure DevOps executes the pipeline in order.

### Step 6: Wait for manual approval

If the pipeline reaches the manual approval stage, a user must approve it before Terraform apply continues.

### Step 7: Review output

Check the job logs for each stage.

Validate:

- whether security scans passed
- whether Terraform init succeeded
- whether validate and plan are clean
- whether apply was approved

---

## 9. Typical execution examples

### Example A: Validate only

Run with:

- `environment=dev`
- `RunTflintScan=true`
- `RunCheckovScan=true`
- `RunTfsecScan=true`
- `RunTerraformInitAndValidate=true`
- `RunTerraformPlan=true`
- `RunTerraformApply=false`

This is useful for CI validation before a merge.

### Example B: Deployment pipeline

Run with:

- `environment=dev`
- `RunTflintScan=true`
- `RunCheckovScan=true`
- `RunTfsecScan=true`
- `RunTerraformInitAndValidate=true`
- `RunTerraformPlan=true`
- `RunTerraformApply=true`

This runs the full flow, including approval and apply.

### Example C: Quick test

Run with minimal checks:

- `RunTflintScan=false`
- `RunCheckovScan=false`
- `RunTfsecScan=false`
- `RunTerraformInitAndValidate=true`
- `RunTerraformPlan=true`
- `RunTerraformApply=false`

This is useful for debugging configuration issues without running full security scans.

---

## 10. Important warnings and precautions

> Warning: The pipeline is designed for controlled infrastructure changes.

### 1. Apply is a real deployment
Terraform apply creates or modifies Azure resources.

Do not run it casually.

### 2. Backend variables must be valid
If the AzureRM backend storage account or container is incorrect, Terraform init will fail.

### 3. Service connection must be configured correctly
The pipeline uses Azure authentication through the configured Azure service connection.

If the service connection is broken or lacks permissions, the pipeline will fail.

### 4. Do not change pipeline stage names without updating dependencies
The stage dependencies are defined in the templates.

If you rename a stage or a job without updating the dependent references, the pipeline may fail or skip stages unexpectedly.

### 5. Manual approval is a control gate
The approve step is intentionally placed before apply.

Do not bypass this step in production environments.

### 6. Use environment-specific values carefully
The root pipeline uses `environment` parameter to choose the directory.

For example:

- `environment=dev` → `environment/dev`
- `environment=prod` → `environment/prod`

Make sure the matching folder exists and is configured correctly.

### 7. Check execution branch logic
The apply stage is conditionally restricted to main-branch execution logic in many enterprise patterns.

This protects production from accidental changes from feature branches.

### 8. Validate before apply
Always check the plan output before approving the apply stage.

This is critical for infrastructure changes because Azure resource modifications can be expensive and irreversible.

---

## 11. Best practice for new pipeline executors

If you are new to this pipeline, use this mental model:

- The root YAML file decides what stages to run.
- Each stage is a reusable pipeline block.
- Each job contains one execution unit.
- Each step is one Azure DevOps task.

A simple mental flow is:

```text
azure-pipelines.yml
  -> stage template
      -> job template
          -> step template
              -> Terraform task / PowerShell task / ManualValidation task
```

This makes the pipeline easier to reason about than a giant single YAML file.

---

## 12. Repository-specific Terraform context

This repository also contains Terraform modules for Azure networking. The Azure pipeline is designed to work with those Terraform definitions:

- `environment/dev/`
- `environment/prod/`
- `modules/`

The pipeline is responsible for validating and applying the Terraform configuration, while the Terraform code itself defines the actual Azure resources.

This is a good example of a complete DevOps pattern:

- code stored in Git
- validation in CI/CD
- security scanning before deployment
- approval before production changes
- infrastructure applied through Azure DevOps

---

## 13. Summary

This pipeline is a generic, reusable Azure DevOps deployment pattern built using a stage → job → step structure.

It provides:

- modular pipeline logic
- clean execution flow
- reusable tasks and jobs
- approval gate before apply
- safer Azure infrastructure provisioning

For a new pipeline executor, the simplest way to understand it is:

- root pipeline = orchestration
- stage = phase
- job = unit of execution
- step = actual task

This makes the pipeline easier to scale, safer to operate, and more professional for repeatable Azure deployments.

---

## 14. Quick checklist before running

Before starting a run, confirm:

- [ ] Azure service connection exists and is valid
- [ ] Variable group `VG-CloudNivara-KeyVault` exists
- [ ] Backend storage values are correct
- [ ] Environment folder exists
- [ ] Terraform code is validated locally if needed
- [ ] Approvers are assigned for manual validation
- [ ] You understand the `environment` and `apply` flags before clicking run

---

## 15. Final note

This pipeline is intentionally designed to be generic and reusable. It can be extended with additional stages, jobs, or environments later without rewriting the whole pipeline from scratch.

That is the main benefit of this structure.

If you are new to Azure DevOps, think of it as:

"a reusable pipeline framework built by composing small modules, just like a Terraform architecture is built by composing reusable modules."
