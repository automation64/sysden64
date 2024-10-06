function sysden64_env_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local model="${SYSDEN64_PATH_ETC}/env"

  bl64_msg_show_phase 'prepare shell-env'
  bl64_msg_show_task "Populate env store  (${SYSDEN64_PATH_SHELLENV})"
  # shellcheck disable=SC2086
  bl64_fs_path_copy \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$home" \
    "${model}/${SYSDEN64_PATH_SHELLENV}"
}
