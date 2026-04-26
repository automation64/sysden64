# version: 1.0.2
# template: lib-config-2.0.0
function module_k9s_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local module_type="$SYSDEN64_MODULE_TYPE_SHARED"
  local module_name='k9s'
  local module_etc=''

  module_detect "$module_name" 'k9s' 'K9S - Kubernetes TUI' || return 0

  module_etc="$(module_config_get_source "$module_type" "$module_name")" &&
    module_k9s_setup_config "$home" "$module_etc" "$module_name" "$module_type"
}

function module_k9s_setup_config() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local module_etc="$2"
  local module_name="$3"
  local module_type="$4"
  local module_config='.config/k9s'
  local config_file='config.yaml'
  local config_backup=''

  if [[ "$BL64_OS_TYPE" == "$BL64_OS_TYPE_MACOS" ]]; then
    config_destination="${home}/Library/Application Support/k9s"
  elif [[ "$BL64_OS_TYPE" == "$BL64_OS_TYPE_LINUX" ]]; then
    config_destination="${home}/.config/k9s"
  fi
  config_backup="${config_destination}/${module_config}"

  module_shared_setup_config "$module_etc" "$module_name" "$module_type" "$config_destination" "$config_backup" "${module_etc}/${module_config}/${config_file}"
}
