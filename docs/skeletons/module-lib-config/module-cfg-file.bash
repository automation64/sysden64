# template: lib-config-1.0.0
# template: lib-base-1.0.0
function module_X_MODULE_ID_X_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local module_type="$SYSDEN64_MODULE_TYPE_SHARED"
  local model='X_MODULE_ID_X'
  local source=''

  [[ -z "$(bl64_bsh_command_locate 'X_COMMAND_X')" ]] &&
    bl64_dbg_app_show_info "$SYSDEN64_TXT_NOT_DETECTED" && return 0
  bl64_msg_show_phase 'prepare X_APP_X'

  source="$(module_set_model "$module_type" "$model")" &&
    module_X_MODULE_ID_X_setup_config "$home" "$source" "$model" "$module_type"
}

function module_X_MODULE_ID_X_setup_config() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local source="$2"
  local model="$3"
  local module_type="$4"
  local base="${home}/X_BASE_TARGET_X"
  local config='X_CONFIG_X'
  local config_file='X_CONFIG_FILE_X'
  local target="${base}/${config_file}"

  module_shared_setup_config "$source" "$model" "$module_type" "$base" "$config" "$target" "${source}/${config}/${config_file}"
}
