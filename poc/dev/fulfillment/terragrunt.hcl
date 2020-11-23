terraform {
  source = "../../../modules/fulfillment/"
}

include {
  path = find_in_parent_folders()
}

dependency "shared" {
  config_path = "../shared"
}

inputs = {
  regions               = ["us-east1", "us-central1"]
  service_account_email = dependency.shared.outputs.fulfillment_service_account_email
  domains               = ["*.fulfillment.ccai.disrupttechlabs.com"]
  log                   = false
}
