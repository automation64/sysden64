# Version: 2.0.0
function module_zsh_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local module_type="$SYSDEN64_MODULE_TYPE_SHARED"
  local config_env='.zshenv'
  local config_rc='.zshrc'
  local model='zsh'
  local target_env="${home}/${config_env}"
  local target_rc="${home}/${config_rc}"
  local source=''
  [[ -z "$(bl64_bsh_command_locate 'zsh')" ]] &&
    bl64_dbg_app_show_info "$SYSDEN64_TXT_NOT_DETECTED" && return 0
  bl64_msg_show_phase 'prepare ZSH'

  source="$(module_set_model "$module_type" "$model")" ||
  return $?

  module_sync_allow "$module_type" && return 0
  module_config_backup "$model" "$target_env" "$target_rc" || return $?
  bl64_msg_show_task "promote configuration from model (${model})"
  bl64_fs_path_copy \
    '0700' \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$home" \
    "${source}/${config_env}" \
    "${source}/${BL64_OS_TYPE}/${config_rc}"
}
