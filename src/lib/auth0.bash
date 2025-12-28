# version: 1.0.0
# template: lib-dedicated-1.0.0
function module_auth0_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local module_type="$SYSDEN64_MODULE_TYPE_DEDICATED"
  local model='auth0'
  local source=''

  module_detect "$model" 'auth0' 'Auth0 CLI' || return 0

  source="$(module_set_model "$module_type" "$model")" &&
    module_auth0_setup_config "$home" "$source" "$model" "$module_type"
}

function module_auth0_setup_config() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local source="$2"
  local model="$3"
  local module_type="$4"
  local base="${home}"
  local config='.config/auth0'
  local target="${base}/${config}"

  module_dedicated_setup_config "$source" "$model" "$module_type" "$base" "$config" "$target" 
}
