<!-- omit in toc -->
# Talos Linux Cluster CNI Module

<!-- omit in toc -->
## Table of Contents

- [👁️ Overview](#️-overview)
- [✅ Provider Requirements](#-provider-requirements)
- [➡️ Inputs](#️-inputs)
- [⬅️ Outputs](#️-outputs)

## 👁️ Overview

This module installs and configures Cilium as the Talos Cluster CNI provider.

## ✅ Provider Requirements

The following Terraform providers are required for this module:

- `hashicorp/helm` ~> 3.1
- `siderolabs/talos` ~> 0.9

## ➡️ Inputs

The input variables for this module are defined below.

**<u>Required Values</u>**

| Variable | Type | Description |
| --- | --- | --- |
| `cluster_name` | `string` | The name used for the Talos cluster |
| `control_plane_nodes` | `list(string)` | List of control plane nodes for the Talos cluster. Only when these nodes and the worker nodes return healthy will the module complete. |
| `endpoints` | `list(string)` | List of endpoints to use to check the cluster health. |
| `worker_nodes` | `list(string)` | List of worker nodes for the Talos cluster. Only when these nodes and the control plane nodes return healthy will the module complete. |

## ⬅️ Outputs

This module produces no outputs.
