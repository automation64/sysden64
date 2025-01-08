function sysden64_starship_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local profile="${home}/.bash_profile"
  local config="${home}/.config"

  bl64_lib_flag_is_enabled "$SYSDEN64_PROFILE_SWITCH" && return 0

  ! bl64_bsh_command_is_executable 'starship' &&
    bl64_dbg_app_show_info "$SYSDEN64_TXT_NOT_DETECTED" && return 0
  bl64_msg_show_phase 'prepare Starship'

  bl64_msg_show_task "Enable Starship (${profile})"
  if ! bl64_txt_run_egrep "$BL64_TXT_SET_GREP_QUIET" 'starship init bash' "$profile"; then
    printf \
      '\neval "$(starship init bash)"\n' \
      >>"$profile"
  fi

  bl64_msg_show_task "Setup Starship (${config})"
  bl64_fs_path_copy \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "${config}" \
    "${SYSDEN64_PATH_ETC}/starship/.config/starship.toml"
}
