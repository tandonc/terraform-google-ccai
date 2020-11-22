terraform {
  source = "../../../modules/shared/"
}

include {
  path = find_in_parent_folders()
}
