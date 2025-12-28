# version: 1.0.0
# template: lib-env-1.0.0
function module_eza_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local module_type="$SYSDEN64_MODULE_TYPE_SHARED"
  local model='eza'
  local source=''

  module_detect "$model" 'eza' 'EZA' || return 0

  source="$(module_set_model "$module_type" "$model")" &&
    module_setup_env "$home" "$source"
}
