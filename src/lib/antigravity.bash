# template: lib-config-2.0.0
function module_antigravity_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local module_type="$SYSDEN64_MODULE_TYPE_SHARED"
  local module_name='antigravity'
  local module_etc=''
  local extra_locations=''

  [[ "$BL64_OS_TYPE" != "$BL64_OS_TYPE_LINUX" ]] && return 0
  module_detect "$module_name" 'antigravity' 'Antigravity - AI IDE' "$extra_locations" || return 0

  module_etc="$(module_config_get_source "$module_type" "$module_name")" &&
    module_antigravity_setup_config "$home" "$module_etc" "$module_name" "$module_type"
}

function module_antigravity_setup_config() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local module_etc="$2"
  local module_name="$3"
  local module_type="$4"
  local config_destination=""
  local module_config='settings'
  local config_file='settings.json'
  local config_backup=''

  if [[ "$BL64_OS_TYPE" == "$BL64_OS_TYPE_LINUX" ]]; then
    config_destination="${home}/.config/Antigravity"
    bl64_fs_dir_create \
      "$BL64_VAR_DEFAULT" "$BL64_VAR_DEFAULT" "$BL64_VAR_DEFAULT" \
      "${config_destination}" \
      "${config_destination}/User" || return $?
  fi
  config_destination+='/User'
  config_backup="${config_destination}/${config_file}"

  module_shared_setup_config "$module_etc" "$module_name" "$module_type" "$config_destination" "$config_backup" "${module_etc}/${module_config}/${config_file}"
}
