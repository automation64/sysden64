function sysden64_bat_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local model="${SYSDEN64_PATH_ETC}/bat"

  bl64_msg_show_phase 'prepare bat'
  bl64_fs_path_copy \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "${home}/${SYSDEN64_PATH_SHELLENV}" \
    "${model}/${SYSDEN64_PATH_SHELLENV}"/*.env
}
