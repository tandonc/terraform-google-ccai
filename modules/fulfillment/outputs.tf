output "serverless_neg_ids" {
  value = [
    for neg in google_compute_region_network_endpoint_group.serverless_neg:
    neg.id
  ]
}
