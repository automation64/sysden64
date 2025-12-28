# version: 1.1.1
# template: lib-config-1.0.0
function module_rd_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local module_type="$SYSDEN64_MODULE_TYPE_SHARED"
  local model='rd'
  local source=''
  local extra_locations=''

  if [[ "$BL64_OS_TYPE" == "$BL64_OS_TYPE_MACOS" ]]; then
    extra_locations='/Applications/Rancher Desktop.app/Contents/Resources/resources/darwin/bin'
  else
    bl64_dbg_app_show_comments 'the tool is only supported on macOS.'
    return 0
  fi

  module_detect "$model" 'docker' 'Rancher Desktop' "$extra_locations" || return 0

  source="$(module_set_model "$module_type" "$model")" &&
    module_setup_env "$home" "$source" &&
    module_rd_setup_config "$home" "$source" "$model" "$module_type"
}

function module_rd_setup_config() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local source="$2"
  local model="$3"
  local module_type="$4"
  local base="${home}/Library/Preferences"
  local config='profile'
  local config_file='io.rancherdesktop.profile.defaults.plist'
  local target="${base}/${config_file}"

  module_shared_setup_config "$source" "$model" "$module_type" "$base" "$config" "$target" "${source}/${config}/${BL64_OS_TYPE}/${config_file}"
}
