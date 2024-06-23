function sysden64_alacritty_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local model="${SYSDEN64_PATH_ETC}/alacritty"

  bl64_msg_show_phase 'prepare Alacritty'
  ! bl64_bsh_command_is_executable 'alacritty' &&
    bl64_msg_show_warning 'tool not detected. No further action taken' && return 0

  bl64_fs_path_copy \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$home" \
    "${model}/.alacritty.yml"
}
