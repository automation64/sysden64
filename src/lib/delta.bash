# Version: 1.0.0
# template: lib-env-1.0.0
function module_delta_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local module_type="$SYSDEN64_MODULE_TYPE_SHARED"
  local model='delta'
  local source=''

  [[ -z "$(bl64_bsh_command_locate 'delta')" ]] &&
    bl64_dbg_app_show_info "$SYSDEN64_TXT_NOT_DETECTED" && return 0
  bl64_msg_show_phase 'prepare Delta'

  source="$(module_set_model "$module_type" "$model")" &&
    module_setup_env "$home" "$source"
}
