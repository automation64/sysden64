# Version: 1.0.0
function module_p10k_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local module_type="$SYSDEN64_MODULE_TYPE_SHARED"
  local model='powerlevel10k'
  local source=''
  local config='.p10k.zsh'
  local target="${home}/${config}"
  local profile="${home}/.zshrc"

  module_profile_switch_allow "$module_type" && return 0

  [[ -z "$(bl64_bsh_command_locate 'zsh')" ]] &&
    bl64_dbg_app_show_info "$SYSDEN64_TXT_NOT_DETECTED" && return 0
  bl64_msg_show_phase 'prepare PowerLevel10K'

  module_create_shared "$module_type" "$model" &&
  source="$(module_set_model "$module_type" "$model")" ||
  return $?

  module_config_backup "$model" "$target" || return $?
  bl64_msg_show_task 'setup PowerLevel10K'
  # shellcheck disable=SC2086
  bl64_fs_path_copy \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$home" \
    "${source}/${config}" ||
    return $?

  bl64_msg_show_task "enable PowerLevel10K (${profile})"
  if ! bl64_txt_run_egrep "$BL64_TXT_SET_GREP_QUIET" '# PowerLevel10K' "$profile"; then
    "$BL64_OS_CMD_CAT" \
      "${source}/p10k.snippet" >>"$profile"
  fi
}
