function module_homebrew_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local module_type="$SYSDEN64_MODULE_TYPE_SHARED"
  local model='homebrew'
  local source=''
  local location_darwin='/opt/homebrew'
  local location_linux='/home/linuxbrew/.linuxbrew'

  [[ ! -d "$location_darwin" && ! -d "$location_linux" ]] &&
    bl64_dbg_app_show_info "$SYSDEN64_TXT_NOT_DETECTED" && return 0
  bl64_msg_show_phase 'prepare HomeBrew'

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
