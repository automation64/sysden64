# Version: 1.0.0
function module_bash_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local path_bash_profile="${home}/.bash_profile"
  local path_bash_rc="${home}/.bashrc"

  bl64_lib_flag_is_enabled "$SYSDEN64_FLAG_PROFILE_SWITCH" && return 0

  ! bl64_bsh_command_is_executable 'bash' &&
    bl64_dbg_app_show_info "$SYSDEN64_TXT_NOT_DETECTED" && return 0
  bl64_msg_show_phase 'prepare Bash'

  config_backup "${path_bash_profile}" "${path_bash_rc}" || return $?
  bl64_msg_show_task "Setup user's bash profile (${home})"
  echo "$SYSDEN64_TXT_WATERMARK" >"$path_bash_profile" &&
    echo "$SYSDEN64_TXT_WATERMARK" >"$path_bash_rc" &&
    bl64_bsh_profile_bash_generate >>"$path_bash_profile" &&
    bl64_bsh_profile_rc_generate >>"$path_bash_rc" &&
    bl64_bsh_env_store_generate >>"$path_bash_rc" &&
    bl64_fs_path_permission_set \
      '0700' "$BL64_VAR_DEFAULT" "$BL64_VAR_DEFAULT" "$BL64_VAR_DEFAULT" "$BL64_VAR_DEFAULT" \
      "$path_bash_profile" \
      "$path_bash_rc"
}
