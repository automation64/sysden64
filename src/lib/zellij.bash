# Version: 1.1.0
function module_zellij_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local module_type="$SYSDEN64_MODULE_TYPE_SHARED"
  local model='zellij'
  local source=''
  local config='.config/zellij'
  local target="${home}/${config}"

  [[ -z "$(bl64_bsh_command_locate 'zellij')" ]] &&
    bl64_dbg_app_show_info "$SYSDEN64_TXT_NOT_DETECTED" && return 0
  bl64_msg_show_phase 'prepare Zellij'

  source="$(module_set_model "$module_type" "$model")" &&
    module_zellij_setup_env "$home" "$source" &&
    module_zellij_setup_config "$home" "$source" "$config" "$model" "$target"
}

function module_zellij_setup_config() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local source="$2"
  local config="$3"
  local model="$4"
  local target="$5"

  module_config_backup "$model" "$target" ||
    return $?

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

function module_zellij_setup_env() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local source="$2"
  module_setup_env "$home" "$source"

}
