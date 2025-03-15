# Version: 1.0.0
function module_btop_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local module_type="$SYSDEN64_MODULE_TYPE_SHARED"
  local model='btop'
  local source=''
  local config='.config/btop'
  local target="${home}/${config}"

  [[ -z "$(bl64_bsh_command_locate 'btop')" ]] &&
    bl64_dbg_app_show_info "$SYSDEN64_TXT_NOT_DETECTED" && return 0
  bl64_msg_show_phase 'prepare BTop'

  source="$(module_set_model "$module_type" "$model")" ||
  return $?

  module_sync_allow "$module_type" && return 0
  module_config_backup "$model" "$target" || return $?
  bl64_msg_show_task "promote configuration from model (${model}/${config})"
  # shellcheck disable=SC2086
  bl64_fs_path_copy \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "${home}/.config" \
    "${source}/${config}"
}
