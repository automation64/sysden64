function module_X_MODULE_ID_X_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local module_type="$SYSDEN64_MODULE_TYPE_SHARED"
  local model='X_MODULE_ID_X'
  local config='X_CONFIG_X'
  local target="${home}/${config}"

  module_profile_switch_allow "$module_type" && return 0

  ! bl64_bsh_command_is_executable 'X_MODULE_ID_X' &&
    bl64_dbg_app_show_info "$SYSDEN64_TXT_NOT_DETECTED" && return 0
  bl64_msg_show_phase 'prepare X_MODULE_NAME_X'

  module_create_shared "$module_type" "$model" "$module_type" || return $?
  model="$(module_set_model "$module_type" "$model")"

  # X_SHELL_ENV_PLACECHOLDER_X

  # X_PROMOTE_PLACECHOLDER_X
