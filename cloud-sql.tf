resource "google_sql_database_instance" "default" {
  name             = var.instance_name
  database_version = var.database_version
  region           = var.region

  settings {
    tier = var.tier

    backup_configuration {
      enabled                        = var.backup_enabled
      start_time                     = var.backup_start_time
    }

    ip_configuration {
      ipv4_enabled = var.ipv4_enabled
    }

    disk_autoresize      = var.disk_autoresize
    disk_size            = var.disk_size
    disk_type            = var.disk_type
  }
}

resource "google_sql_database" "default" {
  name     = var.database_name
  instance = google_sql_database_instance.default.name
}

resource "google_sql_user" "default" {
  name     = var.database_user
  instance = google_sql_database_instance.default.name
  password = var.database_password
}