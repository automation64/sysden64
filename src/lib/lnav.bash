# Version: 1.0.2
# template: legacy
function module_lnav_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local module_type="$SYSDEN64_MODULE_TYPE_SHARED"
  local model='lnav'
  local source=''
  local config='.config/lnav'
  local target="${home}/${config}"

  [[ -z "$(bl64_bsh_command_locate 'lnav')" ]] &&
    bl64_dbg_app_show_info "$SYSDEN64_TXT_NOT_DETECTED" && return 0
  bl64_msg_show_phase 'prepare LNAV'

  source="$(module_set_model "$module_type" "$model")" ||
  return $?

  module_sync_is_requested "$module_type" && return 0
  module_config_backup "$model" "$target" || return $?
  bl64_msg_show_task "promote configuration from model (${model}/${config})"
  bl64_fs_path_copy \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "${home}/.config" \
    "${source}/${config}"
}
