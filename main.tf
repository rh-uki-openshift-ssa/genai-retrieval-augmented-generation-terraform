provider "google" {
  project = var.project_id
  region  = var.region
}

module "project-services" {
  source                      = "terraform-google-modules/project-factory/google//modules/project_services"
  version                     = "15.0.1"
  disable_services_on_destroy = false

  project_id  = var.project_id
  enable_apis = var.enable_apis

  activate_apis = [
    "iam.googleapis.com",
    "serviceusage.googleapis.com",
    "cloudapis.googleapis.com",
    "deploymentmanager.googleapis.com",
    "storage-api.googleapis.com",
    "storage-component.googleapis.com",
    "aiplatform.googleapis.com",
  ]
}
