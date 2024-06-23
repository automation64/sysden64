function sysden64_lnav_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local target="${home}/.config/lnav"
  local model="${SYSDEN64_PATH_ETC}/lnav"

  bl64_msg_show_phase 'prepare LNAV'
  ! bl64_bsh_command_is_executable 'lnav' &&
    bl64_msg_show_warning 'tool not detected. No further action taken' && return 0

  bl64_msg_show_task "setup LNAV (${target})"
  [[ -d "$target" ]] && bl64_msg_show_warning 'already configured. No further action taken' && return 0
  bl64_fs_path_copy \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "${home}/.config" \
    "${model}/.config/lnav"
}
