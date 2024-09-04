resource "kubernetes_cluster_role_binding" "nginx_cluster_admin" {
  metadata {
    name = "tasky-cluster-admin"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }

  subject {
    kind      = "ServiceAccount"
    name      = "default"
    namespace = "default"
  }
}

/*
# ClusterRole con permisos de administrador
resource "kubernetes_cluster_role" "admin_role" {
  metadata {
    name = "tasky-admin"
  }

  rule {
    api_groups = [""]
    resources  = ["*"]
    verbs      = ["*"]
  }

  rule {
    api_groups = ["apps"]
    resources  = ["*"]
    verbs      = ["*"]
  }

  rule {
    api_groups = ["extensions"]
    resources  = ["*"]
    verbs      = ["*"]
  }

  rule {
    api_groups = ["rbac.authorization.k8s.io"]
    resources  = ["*"]
    verbs      = ["*"]
  }
}

# ClusterRoleBinding para vincular el rol con los pods de la aplicación
resource "kubernetes_cluster_role_binding" "admin_role_binding" {
  metadata {
    name = "tasky-admin-binding"
  }

  role_ref {
    kind = "ClusterRole"
    name = kubernetes_cluster_role.admin_role.metadata[0].name
    api_group = "rbac.authorization.k8s.io"
  }

  subject {
    kind      = "ServiceAccount"
    name      = "tasky-sa"
    namespace = "default"  # Asegúrate de que este namespace coincida con el de tu aplicación
  }
}
*/