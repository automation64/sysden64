# Version: 1.0.1
function module_nvm_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local module_type="$SYSDEN64_MODULE_TYPE_SHARED"
  local model='nvm'
  local source=''
  local config='nvm'
  local target="${home}/${config}"

  [[ ! -s "${HOME}/.nvm/nvm.sh" ]] &&
    bl64_dbg_app_show_info "$SYSDEN64_TXT_NOT_DETECTED" && return 0
  bl64_msg_show_phase 'prepare NVM'

  source="$(module_set_model "$module_type" "$model")" &&
    module_setup_env "$home" "$source"
}
