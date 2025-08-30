# Version: 1.0.3
# template: lib-config-1.0.0
function module_lnav_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local module_type="$SYSDEN64_MODULE_TYPE_SHARED"
  local model='lnav'
  local source=''

  [[ -z "$(bl64_bsh_command_locate 'lnav')" ]] &&
    bl64_dbg_app_show_info "$SYSDEN64_TXT_NOT_DETECTED" && return 0
  bl64_msg_show_phase 'prepare LNAV'

  source="$(module_set_model "$module_type" "$model")" &&
    module_lnav_setup_config "$home" "$source" "$model"
}

function module_lnav_setup_config() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local source="$2"
  local model="$3"
  local target_base="${home}/.config"
  local config='.config/lnav'
  local target="${home}/${config}"

  module_config_backup "$model" "$target" ||
    return $?

  bl64_msg_show_task "promote configuration from model (${model}/${config})"
  bl64_fs_path_copy \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$target_base" \
    "${source}/${config}"
}
