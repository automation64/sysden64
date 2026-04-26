# version: 1.0.1
# template: lib-config-2.0.0
function module_gemini_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local module_type="$SYSDEN64_MODULE_TYPE_SHARED"
  local module_name='gemini'
  local module_etc=''

  module_detect "$module_name" 'gemini' 'Gemini - CLI' || return 0

  module_etc="$(module_config_get_source "$module_type" "$module_name")" &&
    module_gemini_setup_config "$home" "$module_etc" "$module_name" "$module_type"
}

function module_gemini_setup_config() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local module_etc="$2"
  local module_name="$3"
  local module_type="$4"
  local config_destination="${home}/.gemini"
  local module_config='.gemini'
  local config_file='settings.json'
  local config_backup="${config_destination}/${config_file}"

  module_shared_setup_config "$module_etc" "$module_name" "$module_type" "$config_destination" "$config_backup" "${module_etc}/${module_config}/${config_file}"
}
