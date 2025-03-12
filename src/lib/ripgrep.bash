# Version: 1.0.0
function module_ripgrep_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local module_type="$SYSDEN64_MODULE_TYPE_SHARED"
  local model='ripgrep'
  local source=''

  module_profile_switch_allow "$module_type" && return 0

  [[ -z "$(bl64_bsh_command_locate 'rg')" ]] &&
    bl64_dbg_app_show_info "$SYSDEN64_TXT_NOT_DETECTED" && return 0
  bl64_msg_show_phase 'prepare RipGrep'

  module_create_shared "$module_type" "$model" &&
  source="$(module_set_model "$module_type" "$model")" ||
  return $?

  bl64_msg_show_task "setup environment variables (${home}/${SYSDEN64_PATH_SHELLENV})"
  bl64_fs_path_copy \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "${home}/${SYSDEN64_PATH_SHELLENV}" \
    "${source}/${SYSDEN64_PATH_SHELLENV}"/*.env
}
