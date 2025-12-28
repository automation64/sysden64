# version: 1.0.2
# template: lib-env-1.0.0
function module_nvm_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local module_type="$SYSDEN64_MODULE_TYPE_SHARED"
  local model='nvm'
  local source=''
  local extra_locations="${HOME}/.nvm"

  module_detect "$model" 'nvm.sh' 'NVM - Node Version Manager' "$extra_locations" || return 0

  source="$(module_set_model "$module_type" "$model")" &&
    module_setup_env "$home" "$source"
}
