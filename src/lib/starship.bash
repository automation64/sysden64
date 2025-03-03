function module_starship_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local module_type="$SYSDEN64_MODULE_TYPE_SHARED"
  local model='starship'
  local source=''
  local config='.config/starship.toml'
  local target="${home}/${config}"
  local profile="${home}/.bash_profile"

  module_profile_switch_allow "$module_type" && return 0

  ! bl64_bsh_command_is_executable 'starship' &&
    bl64_dbg_app_show_info "$SYSDEN64_TXT_NOT_DETECTED" && return 0
  bl64_msg_show_phase 'prepare Starship'

  module_create_shared "$module_type" "$model" &&
  source="$(module_set_model "$module_type" "$model")" ||
  return $?

  module_sync_allow "$module_type" && return 0
  module_config_backup "$model" "$target" || return $?
  bl64_msg_show_task "promote configuration from model (${model}/${config})"
  bl64_fs_path_copy \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "${home}/.config" \
    "${source}/${config}" ||
  return $?

  bl64_msg_show_task "Enable Starship (${profile})"
  if ! bl64_txt_run_egrep "$BL64_TXT_SET_GREP_QUIET" 'starship init bash' "$profile"; then
    printf \
      '\neval "$(starship init bash)"\n' \
      >>"$profile"
  fi
}
