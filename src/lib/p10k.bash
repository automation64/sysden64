# version: 2.0.3
# template: lib-config-2.0.0
function module_p10k_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local module_type="$SYSDEN64_MODULE_TYPE_SHARED"
  local module_name='p10k'
  local module_etc=''

  module_detect "$module_name" 'zsh' 'PowerLevel10K - Zsh Theme' || return 0

  module_etc="$(module_config_get_source "$module_type" "$module_name")" &&
    module_setup_env "$home" "$module_etc" "$module_type" "$module_name" &&
    module_p10k_setup_config "$home" "$module_etc" "$module_name" "$module_type" ||
    return $?
}

function module_p10k_setup_config() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local module_etc="$2"
  local module_name="$3"
  local module_type="$4"
  local config_destination="${home}"
  local module_config='.p10k.zsh'
  local config_backup="${config_destination}/${module_config}"

  module_shared_setup_config "$module_etc" "$module_name" "$module_type" "$config_destination" "$config_backup" "${module_etc}/${module_config}"
}
