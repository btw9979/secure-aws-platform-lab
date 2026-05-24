# Local Terraform Setup

## Optional Provider Plugin Cache

On my Chromebook Linux VM, I configured Terraform to cache provider plugins locally.

Example `~/.terraformrc`:

```hcl
plugin_cache_dir = "$HOME/.terraform.d/plugin-cache"
