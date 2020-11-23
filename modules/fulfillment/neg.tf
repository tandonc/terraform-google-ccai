resource "google_compute_region_network_endpoint_group" "serverless_neg" {
  provider              = google-beta
  for_each              = toset(var.regions)
  name                  = "fulfillment-${each.value}-neg"
  network_endpoint_type = "SERVERLESS"
  region                = each.value
  cloud_run {
    service = var.service_name
  }
}
