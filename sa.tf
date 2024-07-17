# Creates the Service Account 
resource "google_service_account" "runsa" {
  project      = module.project-services.project_id
  account_id   = "genai-rag-run-sa-${var.sa_teamname}"
  display_name = "Service Account for GenAI App"

}

# # Applies permissions to the SA
resource "google_project_iam_member" "allrun" {
  for_each = toset([
    "roles/cloudsql.instanceUser",
    "roles/cloudsql.client",
    "roles/aiplatform.user",
    "roles/iam.serviceAccountTokenCreator",
  ])

  project = module.project-services.project_id
  role    = each.key
  member  = "serviceAccount:${google_service_account.runsa.email}"
}