# Version: 1.0.0
function module_keepassx_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local module_type="$SYSDEN64_MODULE_TYPE_SHARED"
  local model='keepassx'
  local config='.config/keepassx'
  local target="${home}/${config}"

  module_profile_switch_allow "$module_type" && return 0

  [[ -d "$target" ]] &&
    bl64_dbg_app_show_info "$SYSDEN64_TXT_NOT_DETECTED" && return 0
  bl64_msg_show_phase 'prepare KeePassX'

  module_create_shared "$model" "$module_type" || return $?
  model="$(module_set_model "$model")"

  module_sync_allow "$module_type" && return 0
  config_backup "$target" || return $?
  bl64_msg_show_task "promote configuration from model (${model}/${config})"
  bl64_fs_path_copy \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "${home}/.config" \
    "${model}/${config}"
}
