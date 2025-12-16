
variable "control_plane_nodes" {
  type        = list(string)
  description = "List of control plane nodes for the Talos cluster. Only when these nodes and the worker nodes return healthy will the module complete."
}

variable "endpoints" {
  type        = list(string)
  description = "List of endpoints to use to check the cluster health."
}

variable "worker_nodes" {
  type        = list(string)
  description = "List of worker nodes for the Talos cluster. Only when these nodes and the control plane nodes return healthy will the module complete."
}
