# version: 1.1.1
# template: lib-env-1.0.0
# template: lib-config-1.0.0
function module_ripgrep_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local module_type="$SYSDEN64_MODULE_TYPE_SHARED"
  local module='ripgrep'
  local source=''

  module_detect "$module" 'rg' 'RipGrep - Enhanced Grep' || return 0

  source="$(module_config_get_source "$module_type" "$module")" &&
    module_setup_env "$home" "$source" "$module_type" "$module" &&
    module_ripgrep_setup_config "$home" "$source" "$module" "$module_type"
}

function module_ripgrep_setup_config() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local source="$2"
  local module="$3"
  local module_type="$4"
  local base="${home}"
  local config='.ripgrep.cfg'
  local target="${base}/${config}"

  module_shared_setup_config "$source" "$module" "$module_type" "$base" "$config" "$target" "${source}/${config}"
}
