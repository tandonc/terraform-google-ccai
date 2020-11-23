/******************************************
FC_FLASK_SESSION_KEY
******************************************/
resource "random_password" "FC_FLASK_SESSION_KEY" {
  length = 64
  special = true
  keepers = {
    "version" = 1
  }
}

resource "google_secret_manager_secret" "flask_session_key" {
  secret_id = "FC_FLASK_SESSION_KEY"
  replication {
    automatic = true
  }
}

resource "google_secret_manager_secret_version" "flask_session_key_v1" {
  secret = google_secret_manager_secret.flask_session_key.id
  secret_data = random_password.FC_FLASK_SESSION_KEY.result
}

/******************************************
FC_BASIC_AUTH_PASS
******************************************/
resource "random_password" "FC_BASIC_AUTH_PASS" {
  length = 64
  special = true
  keepers = {
    "version" = 1
  }
}

resource "google_secret_manager_secret" "basic_auth_pass" {
  secret_id = "FC_BASIC_AUTH_PASS"
  replication {
    automatic = true
  }
}

resource "google_secret_manager_secret_version" "basic_auth_pass_v1" {
  secret = google_secret_manager_secret.basic_auth_pass.id
  secret_data = random_password.FC_BASIC_AUTH_PASS.result
}

/******************************************
FC_CLIENT_API_KEY
******************************************/
resource "random_password" "FC_CLIENT_API_KEY" {
  length = 64
  special = true
  keepers = {
    "version" = 1
  }
}

resource "google_secret_manager_secret" "client_api_key" {
  secret_id = "FC_CLIENT_API_KEY"
  replication {
    automatic = true
  }
}

resource "google_secret_manager_secret_version" "client_api_key_v1" {
  secret = google_secret_manager_secret.client_api_key.id
  secret_data = random_password.FC_CLIENT_API_KEY.result
}
