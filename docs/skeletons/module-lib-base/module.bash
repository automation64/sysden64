function module_X_MODULE_ID_X_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local module_type="$SYSDEN64_MODULE_TYPE_SHARED"
  local model='X_MODULE_ID_X'
  local source=''
  local config='X_CONFIG_X'
  local target="${home}/${config}"

  [[ -z "$(bl64_bsh_command_locate 'X_MODULE_ID_X')" ]] &&
    bl64_dbg_app_show_info "$SYSDEN64_TXT_NOT_DETECTED" && return 0
  bl64_msg_show_phase 'prepare X_MODULE_NAME_X'

  source="$(module_set_model "$module_type" "$model")" ||
    return $?

  # X_SHELL_ENV_PLACECHOLDER_X

  # X_PROMOTE_PLACECHOLDER_X
