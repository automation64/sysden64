function sysden64_mc_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local target="${home}/.config/mc"
  local model="${SYSDEN64_PATH_ETC}/mc"

  bl64_msg_show_phase 'prepare MC'
  ! bl64_bsh_command_is_executable 'mc' &&
    bl64_msg_show_warning "$SYSDEN64_TXT_NOT_DETECTED" && return 0

  bl64_msg_show_task "setup MC (${target})"
  # shellcheck disable=SC2086
  bl64_fs_run_cp \
    $BL64_FS_SET_CP_RECURSIVE \
    $BL64_FS_SET_CP_FORCE \
    "${model}/.config/mc" \
    "${home}/.config"
}
