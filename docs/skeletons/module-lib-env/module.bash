# version: 1.0.0
# template: lib-env-1.0.1
# template: lib-base-1.0.1
function module_X_MODULE_ID_X_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local module_type="$SYSDEN64_MODULE_TYPE_SHARED"
  local module_name='X_MODULE_ID_X'
  local extra_locations='X_EXTRA_LOCATIONS_PLACEHOLDER_X'
  local module_etc=''

  module_detect "$module_name" 'X_MODULE_ID_X' 'X_MODULE_NAME_X' "$extra_locations" || return 0

  module_etc="$(module_config_get_source "$module_type" "$module_name")" &&
    module_setup_env "$home" "$module_etc" "$module_type" "$module_name"
}
