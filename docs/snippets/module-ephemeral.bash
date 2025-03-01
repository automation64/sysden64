function sysden64_X_MODULE_ID_X_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local model="${SYSDEN64_PATH_ETC_SYSTEM}/X_MODULE_ID_X"

  bl64_msg_show_phase 'prepare X_MODULE_ID_X'
  bl64_fs_path_copy \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "${home}/${SYSDEN64_PATH_SHELLENV}" \
    # example # "${model}/${SYSDEN64_PATH_SHELLENV}"/*.env
}
