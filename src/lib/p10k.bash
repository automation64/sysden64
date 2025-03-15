# Version: 1.0.0
function module_p10k_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local module_type="$SYSDEN64_MODULE_TYPE_SHARED"
  local model='p10k'
  local source=''
  local config='.p10k.zsh'
  local target="${home}/${config}"
  local profile="${home}/.zshrc"

  [[ -z "$(bl64_bsh_command_locate 'zsh')" ]] &&
    bl64_dbg_app_show_info "$SYSDEN64_TXT_NOT_DETECTED" && return 0
  bl64_msg_show_phase 'prepare PowerLevel10K'

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
  if ! bl64_txt_search_line '# PowerLevel10K' "$profile"; then
    "$bl64_os_run_cat" \
      "${source}/p10k.snippet" >>"$profile"
  fi
}
