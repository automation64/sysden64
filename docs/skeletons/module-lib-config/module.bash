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
    module_X_MODULE_ID_X_setup_config "$home" "$source" "$model"
}

function module_X_MODULE_ID_X_setup_config() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local source="$2"
  local model="$3"
  # local target_base="${home}/X_BASE_TARGET_X"
  # local config='X_CONFIG_X'
  # local target="${target_base}/${config}"

  # local target_base="${home}/X_BASE_TARGET_X"
  # local config='X_CONFIG_X'
  # local config_file='X_CONFIG_FILE_X'
  # local target="${target_base}/${config_file}"

  # local target_base=''
  # local target=''
  # if [[ "$BL64_OS_TYPE" == "$BL64_OS_TYPE_MACOS" ]]; then
  #   target_base="${home}/Library/Application Support/X_APP_X"
  # elif [[ "$BL64_OS_TYPE" == "$BL64_OS_TYPE_LINUX" ]]; then
  #   target_base="${home}/X_BASE_TARGET_X"
  # fi
  # target="${target_base}/${config}"

  module_config_backup "$model" "$target" ||
    return $?

  bl64_msg_show_task "promote configuration from model (${model}/${config})"
  # bl64_fs_dir_create \
  #   "$BL64_VAR_DEFAULT" "$BL64_VAR_DEFAULT" "$BL64_VAR_DEFAULT" \
  #   "$target_base" &&
  bl64_fs_path_copy \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$target_base" \
    "${source}/${config}"
    # "${source}/${config}/${config_file}"
}
