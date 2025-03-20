# Version: 1.0.0
function module_vscode_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local module_type="$SYSDEN64_MODULE_TYPE_SHARED"
  local model='vscode'
  local source=''
  local config='vscode'
  local target="${home}/${config}"
  local extra_locations='/Applications/Visual Studio Code.app/Contents/Resources/app/bin'

  # shellcheck disable=SC2086
  [[ -z "$(bl64_bsh_command_locate 'code' $extra_locations)" ]] &&
    bl64_dbg_app_show_info "$SYSDEN64_TXT_NOT_DETECTED" && return 0
  bl64_msg_show_phase 'prepare VSCode'

  source="$(module_set_model "$module_type" "$model")" ||
    return $?

  bl64_msg_show_task "setup environment variables (${home}/${SYSDEN64_PATH_SHELLENV})"
  bl64_fs_path_copy \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "${home}/${SYSDEN64_PATH_SHELLENV}" \
    "${source}/${SYSDEN64_PATH_SHELLENV}-${BL64_OS_TYPE}"/*.env
}
