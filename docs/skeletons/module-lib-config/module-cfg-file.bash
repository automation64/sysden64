# version: 1.0.0
# template: lib-config-2.0.0
# template: lib-base-1.0.1
function module_X_MODULE_ID_X_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local module_type="$SYSDEN64_MODULE_TYPE_SHARED"
  local module_name='X_MODULE_ID_X'
  local extra_locations='X_EXTRA_LOCATIONS_PLACEHOLDER_X'

  module_detect "$module_name" 'X_MODULE_ID_X' 'X_MODULE_NAME_X' "$extra_locations" || return 0

  module_etc="$(module_config_get_source "$module_type" "$module_name")" &&
    module_X_MODULE_ID_X_setup_config "$home" "$module_etc" "$module_name" "$module_type"
}

function module_X_MODULE_ID_X_setup_config() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local module_etc="$2"
  local module_name="$3"
  local module_type="$4"
  local config_destination="${home}/X_BASE_TARGET_X"
  local module_config='X_CONFIG_X'
  local config_file='X_CONFIG_FILE_X'
  local config_backup="${config_destination}/${config_file}"

  module_shared_setup_config "$module_etc" "$module_name" "$module_type" "$config_destination" "$config_backup" "${module_etc}/${module_config}/${config_file}"
}
