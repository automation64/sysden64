# version: 1.1.1
# template: lib-env-1.0.1
# template: lib-config-2.0.0
function module_ripgrep_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local module_type="$SYSDEN64_MODULE_TYPE_SHARED"
  local module_name='ripgrep'
  local module_etc=''

  module_detect "$module_name" 'rg' 'RipGrep - Enhanced Grep' || return 0

  module_etc="$(module_config_get_source "$module_type" "$module_name")" &&
    module_setup_env "$home" "$module_etc" "$module_type" "$module_name" &&
    module_ripgrep_setup_config "$home" "$module_etc" "$module_name" "$module_type"
}

function module_ripgrep_setup_config() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local module_etc="$2"
  local module_name="$3"
  local module_type="$4"
  local config_destination="${home}"
  local module_config='.ripgrep.cfg'
  local config_backup="${config_destination}/${module_config}"

  module_shared_setup_config "$module_etc" "$module_name" "$module_type" "$config_destination" "$config_backup" "${module_etc}/${module_config}"
}
