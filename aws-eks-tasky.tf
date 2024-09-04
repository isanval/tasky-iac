resource "kubernetes_deployment" "tasky" {
  metadata {
    name = "tasky"
    labels = {
      app = "tasky"
    }
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = "tasky"
      }
    }

    template {
      metadata {
        labels = {
          app = "tasky"
        }
      }

      spec {
#        service_account_name = "tasky-sa"  # ServiceAccount en el ClusterRoleBinding

        container {
          name  = "tasky"
          image = "ghcr.io/isanval/tasky-app:latest"

          port {
            container_port = 8080
          }

          env {
            name  = "MONGODB_URI"
            value = "mongodb://${var.mongodb_user}:${var.mongodb_pass}@${aws_instance.wiz-mongodb.0.private_ip}:27017"
          }
          env {
            name  = "SECRET_KEY"
            value = "${var.mongodb_secret}"
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "tasky" {
  metadata {
    name = "tasky-service"
  }
  spec {
    selector = {
      app = "tasky"
    }
    port {
      port        = 80
      target_port = 8080
    }
    type = "LoadBalancer"
  }
}