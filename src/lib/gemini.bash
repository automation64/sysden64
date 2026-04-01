# version: 1.0.1
# template: lib-config-1.0.0
function module_gemini_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local module_type="$SYSDEN64_MODULE_TYPE_SHARED"
  local module='gemini'
  local source=''

  module_detect "$module" 'gemini' 'Gemini - CLI' || return 0

  source="$(module_config_get_source "$module_type" "$module")" &&
    module_gemini_setup_config "$home" "$source" "$module" "$module_type"
}

function module_gemini_setup_config() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local source="$2"
  local module="$3"
  local module_type="$4"
  local base="${home}/.gemini"
  local config='.gemini'
  local config_file='settings.json'
  local target="${base}/${config_file}"

  module_shared_setup_config "$source" "$module" "$module_type" "$base" "$config" "$target" "${source}/${config}/${config_file}"
}
