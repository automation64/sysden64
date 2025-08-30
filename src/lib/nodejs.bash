# Version: 1.0.1
# template: lib-env-1.0.0
function module_nodejs_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local module_type="$SYSDEN64_MODULE_TYPE_SHARED"
  local model='nodejs'
  local source=''

  [[ -z "$(bl64_bsh_command_locate 'node')" ]] &&
    bl64_dbg_app_show_info "$SYSDEN64_TXT_NOT_DETECTED" && return 0
  bl64_msg_show_phase 'prepare NodeJS'

  source="$(module_set_model "$module_type" "$model")" &&
    module_setup_env "$home" "$source"
}
