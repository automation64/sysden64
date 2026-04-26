# version: 1.0.1
# template: lib-env-1.0.1
function module_eza_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local module_type="$SYSDEN64_MODULE_TYPE_SHARED"
  local module_name='eza'
  local module_etc=''

  module_detect "$module_name" 'eza' 'EZA - Modern LS' || return 0

  module_etc="$(module_config_get_source "$module_type" "$module_name")" &&
    module_setup_env "$home" "$module_etc" "$module_type" "$module_name"
}
