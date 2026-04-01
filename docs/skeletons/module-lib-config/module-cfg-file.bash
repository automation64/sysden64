# template: lib-config-1.0.0
# template: lib-base-1.0.0
function module_X_MODULE_ID_X_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local module_type="$SYSDEN64_MODULE_TYPE_SHARED"
  local module='X_MODULE_ID_X'
  local extra_locations='X_EXTRA_LOCATIONS_PLACEHOLDER_X'

  module_detect "$module" 'X_MODULE_ID_X' 'X_MODULE_NAME_X' "$extra_locations" || return 0

  source="$(module_config_get_source "$module_type" "$module")" &&
    module_X_MODULE_ID_X_setup_config "$home" "$source" "$module" "$module_type"
}

function module_X_MODULE_ID_X_setup_config() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local source="$2"
  local module="$3"
  local module_type="$4"
  local base="${home}/X_BASE_TARGET_X"
  local config='X_CONFIG_X'
  local config_file='X_CONFIG_FILE_X'
  local target="${base}/${config_file}"

  module_shared_setup_config "$source" "$module" "$module_type" "$base" "$config" "$target" "${source}/${config}/${config_file}"
}
