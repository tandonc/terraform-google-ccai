module "project_iam_bindings" {
  source  = "terraform-google-modules/iam/google//modules/projects_iam"
  version = "~> 6.4"

  projects = [var.project_id]

  bindings = {
    "roles/cloudbuild.builds.builder" = [
      "serviceAccount:${data.google_project.project.number}@cloudbuild.gserviceaccount.com"
    ]
    "roles/run.admin" = [
      "serviceAccount:${data.google_project.project.number}@cloudbuild.gserviceaccount.com"
    ]
    "roles/iam.serviceAccountUser" = [
      "serviceAccount:${data.google_project.project.number}@cloudbuild.gserviceaccount.com"
    ]
  }
}

module "fulfillment_service_account" {
  source        = "terraform-google-modules/service-accounts/google"
  version       = "~> 2.0"
  project_id    = var.project_id
  names         = ["fulfillment-controller"]
}
