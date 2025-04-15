# Version: 1.0.1
function module_vscode_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local module_type="$SYSDEN64_MODULE_TYPE_SHARED"
  local model='vscode'
  local source=''
  local extra_locations='/Applications/Visual Studio Code.app/Contents/Resources/app/bin'

  [[ -z "$(bl64_bsh_command_locate 'code' "$extra_locations")" ]] &&
    bl64_dbg_app_show_info "$SYSDEN64_TXT_NOT_DETECTED" && return 0
  bl64_msg_show_phase 'prepare VSCode'

  source="$(module_set_model "$module_type" "$model")" &&
    module_setup_env "$home" "$source" &&
    module_vscode_setup_config "$home" "$source" "$model"
}

function module_vscode_setup_config() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local source="$2"
  local model="$3"
  local target_base=''
  local config='settings'
  local config_file='settings.json'
  local target=''

  if [[ "$BL64_OS_TYPE" == "$BL64_OS_TYPE_MACOS" ]]; then
    target_base="${home}/Library/Application Support/Code/User"
    bl64_fs_dir_create \
      "$BL64_VAR_DEFAULT" "$BL64_VAR_DEFAULT" "$BL64_VAR_DEFAULT" \
      "${home}/Library/Application Support/Code" \
      "${home}/Library/Application Support/Code/User" || return $?
  elif [[ "$BL64_OS_TYPE" == "$BL64_OS_TYPE_LINUX" ]]; then
    target_base="${home}/.config/Code/User"
    bl64_fs_dir_create \
      "$BL64_VAR_DEFAULT" "$BL64_VAR_DEFAULT" "$BL64_VAR_DEFAULT" \
      "${home}/.config/Code" \
      "${home}/.config/Code/User" || return $?
  fi
  target="${target_base}/${config_file}"

  module_config_backup "$model" "$target" ||
    return $?

  bl64_msg_show_task "promote configuration from model (${model}/${config})"
  # shellcheck disable=SC2086
  bl64_fs_path_copy \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$target_base" \
    "${source}/${config}/${config_file}"
}
