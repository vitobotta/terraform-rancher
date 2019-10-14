# Required configuration
variable "etcd_s3_access_key" {}
variable "etcd_s3_secret_key" {}
variable "etcd_s3_bucket_name" {}
variable "etcd_s3_endpoint" {}
variable "etcd_s3_region" {}
variable "cluster_name" {}

# Optional configuration
variable "private_network_interface" {
  default = "eth1"
}
variable "etcd_backup_enabled" {
  default = true
}
variable "etcd_s3_folder" {
  default = "etcd"
}
variable "etcd_backup_interval_hours" {
  default = 6
}
variable "etcd_backup_retention" {
  default = 28
}
variable "ingress_provider" {
  default = "none"
}
variable "enable_cluster_alerting" {
  default = true
}
variable "enable_cluster_monitoring" {
  default = true
}
