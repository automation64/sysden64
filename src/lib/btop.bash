function sysden64_btop_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local target="${home}/.config/btop"
  local model="${SYSDEN64_PATH_ETC}/btop"

  bl64_lib_flag_is_enabled "$SYSDEN64_PROFILE_SWITCH" && return 0

  ! bl64_bsh_command_is_executable 'btop' &&
    bl64_dbg_app_show_info "$SYSDEN64_TXT_NOT_DETECTED" && return 0
  bl64_msg_show_phase 'prepare BTop'

  bl64_msg_show_task "setup BTop (${target})"
  # shellcheck disable=SC2086
  bl64_fs_path_copy \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "${home}/.config" \
    "${model}/.config/btop"
}
