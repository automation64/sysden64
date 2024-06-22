function sysden64_zsh_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local model="${SYSDEN64_PATH_ETC}/zsh"

  bl64_msg_show_phase 'prepare ZSH'
  ! bl64_bsh_command_is_executable 'zsh' &&
    bl64_msg_show_warning 'tool not detected. No further action taken' && return 0

  bl64_fs_path_copy \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$home" \
    "${model}/.zshrc"
}
