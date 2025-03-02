function module_starship_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local model='starship'
  local profile="${home}/.bash_profile"
  local config='starship.toml'

  bl64_lib_flag_is_enabled "$SYSDEN64_PROFILE_SWITCH" && return 0

  ! bl64_bsh_command_is_executable 'starship' &&
    bl64_dbg_app_show_info "$SYSDEN64_TXT_NOT_DETECTED" && return 0
  bl64_msg_show_phase 'prepare Starship'

  module_create_shared "$model" || return $?
  model="$(module_set_model "$model")"

  bl64_msg_show_task "Enable Starship (${profile})"
  if ! bl64_txt_run_egrep "$BL64_TXT_SET_GREP_QUIET" 'starship init bash' "$profile"; then
    printf \
      '\neval "$(starship init bash)"\n' \
      >>"$profile"
  fi

  bl64_msg_show_task "promote configuration from model (${model}/.config/${config})"
  bl64_fs_path_copy \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "${home}/.config" \
    "${model}/.config/${config}"
}
