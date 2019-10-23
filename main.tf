resource "rancher2_cluster" "cluster" {
  name = "${var.cluster_name}"
  cluster_auth_endpoint {
    enabled = true
  }

  rke_config {
    network {
      plugin = "canal"
      canal_network_provider {
        iface = var.private_network_interface
      }
    }

    ingress {
      provider = var.ingress_provider
    }

    services {
      etcd {
        backup_config {
          enabled        = var.etcd_backup_enabled
          interval_hours = var.etcd_backup_interval_hours
          retention      = var.etcd_backup_retention
          s3_backup_config {
            access_key  = var.etcd_s3_access_key
            secret_key  = var.etcd_s3_secret_key
            bucket_name = var.etcd_s3_bucket_name
            endpoint    = var.etcd_s3_endpoint
            region      = var.etcd_s3_region
            folder      = var.etcd_s3_folder
          }
        }
      }

      kubelet {
        extra_args = {
          cloud-provider = "external"
        }
      }
    }
  }

  enable_cluster_alerting = var.enable_cluster_alerting

  enable_cluster_monitoring = var.enable_cluster_monitoring
  cluster_monitoring_input {
    answers = {
      "exporter-kubelets.https"                   = true
      "exporter-node.enabled"                     = true
      "exporter-node.ports.metrics.port"          = 9796
      "exporter-node.resources.limits.cpu"        = "200m"
      "exporter-node.resources.limits.memory"     = "200Mi"
      "grafana.persistence.enabled"               = false
      "operator.resources.limits.memory"          = "500Mi"
      "prometheus.persistence.enabled"            = false
      "prometheus.persistent.useReleaseName"      = "true"
      "prometheus.resources.core.limits.cpu"      = "1000m",
      "prometheus.resources.core.limits.memory"   = "1500Mi"
      "prometheus.resources.core.requests.cpu"    = "750m"
      "prometheus.resources.core.requests.memory" = "750Mi"
      "prometheus.retention"                      = "12h"
    }
  }
}


