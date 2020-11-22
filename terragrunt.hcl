locals {
  account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))
  env_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
}

generate "versions" {
  path      = "versions.tf"
  if_exists = "overwrite"
  contents = <<EOF
terraform {
  required_version = "~> 0.13.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.48.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "3.48.0"
    }
  }
}
EOF
}

remote_state {
  backend = "gcs"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }
  config = {
    project                  = "ccai-df-mva-lab1"
    bucket                   = "terraform-state-ccai-df-mva-lab1"
    location                 = "US"
    prefix                   = path_relative_to_include()
    gcs_bucket_labels        = {
      "env"   = "dev",
      "app"   = "ccai-df-mva",
    }
  }
}

inputs = merge(
  local.account_vars.locals,
  local.env_vars.locals,
)
