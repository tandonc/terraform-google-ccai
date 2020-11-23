resource "google_compute_global_address" "default" {
  name       = "${var.service_name}-address"
}

resource "google_compute_global_forwarding_rule" "http" {
  name       = "${var.service_name}-http"
  ip_address = google_compute_global_address.default.address
  target     = google_compute_target_http_proxy.default.id
  port_range = "80"
}

resource "google_compute_global_forwarding_rule" "https" {
  name       = "${var.service_name}-https"
  ip_address = google_compute_global_address.default.address
  target     = google_compute_target_https_proxy.default.id
  port_range = "443"
}

resource "google_compute_url_map" "default" {
  name            = "${var.service_name}-url-map"
  default_url_redirect {
    path_redirect = "/"
    strip_query = true
  }
  host_rule {
    hosts        = ["*"]
    path_matcher = "default"
  }
  path_matcher {
    name         = "default"
    route_rules {
      priority = 1
      service = google_compute_backend_service.default.id
      match_rules {
        prefix_match = "/webhook"
        header_matches {
          header_name = "df_auth"
          exact_match = "password"
        }
      }
    }
  }
}

resource "google_compute_url_map" "https_redirect" {
  name    = "${var.service_name}-https-redirect"
  default_url_redirect {
    https_redirect         = true
    redirect_response_code = "MOVED_PERMANENTLY_DEFAULT"
    strip_query            = false
  }
}

resource "google_compute_managed_ssl_certificate" "default" {
  provider = google-beta

  name = "${var.service_name}-cert"
  managed {
    domains = var.domains
  }
}

resource "google_compute_target_http_proxy" "default" {
  name    = "${var.service_name}-http-proxy"
  url_map = google_compute_url_map.https_redirect.id
}

resource "google_compute_target_https_proxy" "default" {
  name    = "${var.service_name}-https-proxy"
  url_map = google_compute_url_map.default.id
  ssl_certificates = google_compute_managed_ssl_certificate.default.*.id
}

resource "google_compute_backend_service" "default" {
  provider = google-beta

  name    = "${var.service_name}-backend"
  enable_cdn                      = false

  dynamic "backend" {
    for_each = google_compute_region_network_endpoint_group.serverless_neg
    content {
      group = backend.value.id
    }
  }
}
