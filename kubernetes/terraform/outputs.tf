output "gcloud_connect_command" {
  value = "gcloud container clusters get-credentials ${var.cluster_name} --zone ${var.zone} --project ${var.project}"
}

