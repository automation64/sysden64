function sysden64_bash_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local model="${SYSDEN64_PATH_ETC}/bash"

  bl64_msg_show_phase 'prepare Bash'
  ! bl64_bsh_command_is_executable 'bash' &&
    bl64_msg_show_warning 'tool not detected. No further action taken' && return 0

  bl64_msg_show_task "Setup user's bash profile (${home})"
  bl64_fs_path_copy \
    '0700' \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$home" \
    "${model}/.bashrc" \
    "${model}/.bash_profile"
}
