# version: 3.0.2
# template: lib-dedicated-1.0.0
function module_kubectl_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local module_type="$SYSDEN64_MODULE_TYPE_DEDICATED"
  local module='kubectl'
  local source=''

  module_detect "$module" 'kubectl' 'KubeCTL' || return 0

  source="$(module_config_get_source "$module_type" "$module")" &&
    module_setup_env "$home" "$source" "$module_type" "$module" &&
    module_kubectl_setup_config "$home" "$source" "$module" "$module_type"
}

function module_kubectl_setup_config() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local source="$2"
  local module="$3"
  local module_type="$4"
  local base="${home}"
  local config='.kube'
  local target="${base}/${config}"

  module_dedicated_setup_config "$source" "$module" "$module_type" "$base" "$config" "$target"
}
