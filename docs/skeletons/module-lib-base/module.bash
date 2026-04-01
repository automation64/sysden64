# template: lib-base-1.0.0
function module_X_MODULE_ID_X_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local module_type="$SYSDEN64_MODULE_TYPE_SHARED"
  local module='X_MODULE_ID_X'
  local source=''
  local extra_locations='X_EXTRA_LOCATIONS_PLACEHOLDER_X'

  module_detect "$module" 'X_MODULE_ID_X' 'X_MODULE_NAME_X' "$extra_locations" || return 0

  source="$(module_config_get_source "$module_type" "$module")"
}
