# Handle Database
resource "google_sql_database_instance" "main" {
  name             = "genai-rag-db-${var.sa_teamname}"
  database_version = var.database_version
  region           = var.region
  project          = module.project-services.project_id

  settings {
    tier                         = var.tier
    disk_autoresize              = true
    disk_autoresize_limit        = 0
    disk_size                    = 10
    disk_type                    = "PD_SSD"
    user_labels                  = var.labels
    enable_google_ml_integration = true
    ip_configuration {
      ipv4_enabled = true
    }
    database_flags {
      name  = "cloudsql.iam_authentication"
      value = "on"
    }
    database_flags {
      name  = "cloudsql.enable_google_ml_integration"
      value = "on"
    }
  }
  deletion_protection = var.deletion_protection

}

# # Create Database
resource "google_sql_database" "database" {
  project         = var.project_id
  name            = "assistantdemo"
  instance        = google_sql_database_instance.main.name
  deletion_policy = "ABANDON"
}

# # Create Cloud SQL User
resource "google_sql_user" "service" {
  name            = "retrieval-service"
  project         = module.project-services.project_id
  instance        = google_sql_database_instance.main.name
  type            = "BUILT_IN"
  password        = var.database_password
  deletion_policy = "ABANDON"
}

# # Create SQL integration to vertex
resource "google_project_iam_member" "vertex_integration" {
  project = module.project-services.project_id
  role    = "roles/aiplatform.user"
  member  = "serviceAccount:${google_sql_database_instance.main.service_account_email_address}"
}
