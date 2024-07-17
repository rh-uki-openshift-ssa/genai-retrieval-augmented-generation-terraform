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

resource "google_service_account_key" "mykey" {
  service_account_id = google_service_account.runsa.id
  public_key_type    = "TYPE_X509_PEM_FILE"
}