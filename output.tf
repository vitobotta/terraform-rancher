output "kube_config" {
  value = rancher2_cluster.cluster.kube_config
}

output "node_command" {
  value = rancher2_cluster.cluster.cluster_registration_token.0.node_command
}
