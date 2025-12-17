locals {
  endpoints           = var.endpoints
  control_plane_nodes = [for node in var.control_plane_nodes : split(".", node)[0]]
  worker_nodes        = [for node in var.worker_nodes : split(".", node)[0]]
}
