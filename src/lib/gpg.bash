# version: 2.0.2
# template: lib-dedicated-1.0.1
function module_gpg_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local module_type="$SYSDEN64_MODULE_TYPE_DEDICATED"
  local module_name='gpg'
  local module_etc=''

  module_detect "$module_name" 'gpg' 'GNUPG - Cryptography Toolkit' || return 0

  module_etc="$(module_config_get_source "$module_type" "$module_name")" &&
    module_gpg_setup_config "$home" "$module_etc" "$module_name" "$module_type"
}

function module_gpg_setup_config() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local module_etc="$2"
  local module_name="$3"
  local module_type="$4"
  local config_destination="${home}"
  local module_config='.gnupg'
  local config_backup="${config_destination}/${module_config}"

  module_dedicated_setup_config "$module_etc" "$module_name" "$module_type" "$config_destination" "$module_config" "$config_backup"
}
