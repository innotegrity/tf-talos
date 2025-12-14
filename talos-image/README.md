# Talos Linux ISO Image Module

This module downloads a factory-generated ISO image for Talos Linux.

## Required Providers

- `bpg/proxmox` ~> 0.89
- `siderolabs/talos` ~> 0.9

## Inputs

**Required Values**

| Variable | Type | Description |
| --- | --- | --- |
| `proxmox_node` | `string` | The name of the Proxmox node to use when downloading the ISO image |
| `storage_pool` | `string` | The name/ID of the storage device/pool in which to place the ISO image |
| `talos_version` | `string` | The version of the Talos ISO image to download |

**Optional Values**

| Variable | Type | Description | Default |
| --- | --- | --- | --- |
| `arch` | `string` | The CPU architecture to use for the ISO image; must be one of: `amd64` or `arm64` | `amd64` |
| `extra_extensions` | `list(string)` | A list of extra extensions to include in the image file ; by default `qemu-guest-agent`, `iscsi-tools` and `util-linux-tools` are included | `[]` |
| `extra_kernel_args` | `list(string)` | A list of extra kernel extensions to use when booting the image file ; by default `net.ifnames=0` and `bisodevname=0` are included | `[]` |

## Outputs

| Variable | Type | Description |
| --- | --- | --- |
| `file_id` | `string` | The ID of the Talos ISO image file |
| `file_name` | `string` | The name of the Talos ISO image file on the Proxmox server |
| `file_size` | `number` | The size of the Talos ISO image file in bytes on the Proxmox server |
| `schematic_id` | `string` | The generated factory schematic hash for the Talos ISO image file |
| `storage_pool` | `string` | The storage pool in which the downloaded ISO image is stored |
| `source_urls` | [URLObject](#urlobject-type) | The source URLs for the corresponding Talos factory images |

## Object Definitions

### URLObject Type

This object is used only for output.

| Variable | Type | Description |
| --- | --- | --- |
| `disk_image` | `string` | The URL for the disk image |
| `disk_image_secureboot` | `string` | The URL for the disk image with secure booting enabled |
| `initramfs` | `string` | The URL for the initramfs image |
| `installer` | `string` | The URL for the installer image |
| `installer_secureboot` | `string` | The URL for the installer image with secure booting enabled |
| `iso` | `string` | The URL for the ISO image |
| `iso_secureboot` | `string` | The URL for the ISO image with secure booting enabled |
| `kernel` | `string` | The URL for the kernel image |
| `kernel_command_line` | `string` | The URL for the kernel command line |
| `pxe` | `string` | The URL for the PXE image |
| `uki` | `string` | The URL for the UKI image |
