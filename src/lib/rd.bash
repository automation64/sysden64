# version: 1.1.2
# template: lib-config-2.0.0
function module_rd_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local module_type="$SYSDEN64_MODULE_TYPE_SHARED"
  local module_name='rd'
  local module_etc=''
  local extra_locations=''

  if [[ "$BL64_OS_TYPE" == "$BL64_OS_TYPE_MACOS" ]]; then
    extra_locations='/Applications/Rancher Desktop.app/Contents/Resources/resources/darwin/bin'
  else
    bl64_dbg_app_show_comments 'the tool is only supported on macOS.'
    return 0
  fi

  module_detect "$module_name" 'docker' 'Rancher Desktop - Container Manager' "$extra_locations" || return 0

  module_etc="$(module_config_get_source "$module_type" "$module_name")" &&
    module_setup_env "$home" "$module_etc" "$module_type" "$module_name" &&
    module_rd_setup_config "$home" "$module_etc" "$module_name" "$module_type"
}

function module_rd_setup_config() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local module_etc="$2"
  local module_name="$3"
  local module_type="$4"
  local config_destination="${home}/Library/Preferences"
  local module_config='profile'
  local config_file='io.rancherdesktop.profile.defaults.plist'
  local config_backup="${config_destination}/${config_file}"

  module_shared_setup_config "$module_etc" "$module_name" "$module_type" "$config_destination" "$config_backup" "${module_etc}/${module_config}/${BL64_OS_TYPE}/${config_file}"
}
