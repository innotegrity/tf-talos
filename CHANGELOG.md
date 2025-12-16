# Changelog

## Unreleased

No unreleased changes

## v0.2.0 (Released 2025-12-16)

* Fixed README for `talos-cluster` module as it had an error with the output fields
* Fixed the `mac_address` local variable for `talos-vm` as it was missing an index
* Fixed an incorrect reference to `ip_address` in the `talos-vm` module
* Fixed issue with condition check on `dns.provider` in the `talos-cluster` module
* Split CNI configuration into `talos-cluster-cni` module

## v0.1.0 (Released 2025-12-14)

* Initial release of the module
