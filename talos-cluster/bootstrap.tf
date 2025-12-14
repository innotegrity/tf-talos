resource "talos_machine_bootstrap" "this" {
  depends_on = [
    talos_machine_configuration_apply.control_plane,
    talos_machine_configuration_apply.worker
  ]

  node                 = local.endpoint_ips[0]
  client_configuration = talos_machine_secrets.this.client_configuration
}

resource "talos_cluster_kubeconfig" "kubeconfig" {
  depends_on = [
    talos_machine_bootstrap.this
  ]

  client_configuration = talos_machine_secrets.this.client_configuration
  node                 = local.endpoint_ips[0]
}

resource "null_resource" "wait_for_k8s_api" {
  depends_on = [
    talos_cluster_kubeconfig.kubeconfig
  ]
  triggers = {
    kubeconfig_content_hash = md5(talos_cluster_kubeconfig.kubeconfig.kubeconfig_raw)
  }

  provisioner "local-exec" {
    command = <<-EOT
      filename=$(mktemp)
      echo "${talos_cluster_kubeconfig.kubeconfig.kubeconfig_raw}" > $filename
      export KUBECONFIG=$filename
      until kubectl get nodes > /dev/null 2>&1; do
        echo "Waiting for Kubernetes API to be ready..."
        sleep 5
      done
      echo "Kubernetes API is ready."
      rm -f $filename
    EOT
  }
}

resource "helm_release" "cilium_cni" {
  depends_on = [
    null_resource.wait_for_k8s_api
  ]

  repository = "https://helm.cilium.io"
  chart      = "cilium"
  name       = "cilium-cni"

  atomic           = true
  cleanup_on_fail  = true
  create_namespace = true
  namespace        = "kube-system"
  version          = "1.18.4"

  set = [
    {
      name  = "ipam.mode"
      value = "kubernetes"
    },
    {
      name  = "kubeProxyReplacement"
      value = true
    },
    {
      name  = "securityContext.capabilities.ciliumAgent"
      value = "{CHOWN,KILL,NET_ADMIN,NET_RAW,IPC_LOCK,SYS_ADMIN,SYS_RESOURCE,DAC_OVERRIDE,FOWNER,SETGID,SETUID}"
    },
    {
      name  = "securityContext.capabilities.cleanCiliumState"
      value = "{NET_ADMIN,SYS_ADMIN,SYS_RESOURCE}"
    },
    {
      name  = "cgroup.autoMount.enabled"
      value = false
    },
    {
      name  = "cgroup.hostRoot"
      value = "/sys/fs/cgroup"
    },
    {
      name  = "k8sServiceHost"
      value = "localhost"
    },
    {
      name  = "k8sServicePort"
      value = 7445
    },
    {
      name  = "gatewayAPI.enabled"
      value = true
    },
    {
      name  = "gatewayAPI.enableAlpn"
      value = true
    },
    {
      name  = "gatewayAPI.enableAppProtocol"
      value = true
    }
  ]
}

data "talos_cluster_health" "this" {
  depends_on = [
    helm_release.cilium_cni
  ]

  client_configuration   = data.talos_client_configuration.this.client_configuration
  control_plane_nodes    = local.endpoint_ips
  worker_nodes           = local.worker_ips
  endpoints              = local.endpoint_ips
  skip_kubernetes_checks = true
  timeouts = {
    read = "5m"
  }
}
