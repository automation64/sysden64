# version: 1.0.2
# template: lib-config-1.0.0
function module_vscodium_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local module_type="$SYSDEN64_MODULE_TYPE_SHARED"
  local model='vscodium'
  local source=''
  local extra_locations=''

  module_detect "$model" 'code' 'VSCodium IDE' "$extra_locations" || return 0

  source="$(module_set_model "$module_type" "$model")" &&
    module_setup_env "$home" "$source" &&
    module_vscodium_setup_config "$home" "$source" "$model" "$module_type"
}

function module_vscodium_setup_config() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local source="$2"
  local model="$3"
  local module_type="$4"
  local base=''
  local config='settings'
  local config_file='settings.json'
  local target=''

  if [[ "$BL64_OS_TYPE" == "$BL64_OS_TYPE_LINUX" ]]; then
    base="${home}/.config/VSCodium/User"
    bl64_fs_dir_create \
      "$BL64_VAR_DEFAULT" "$BL64_VAR_DEFAULT" "$BL64_VAR_DEFAULT" \
      "${home}/.config/VSCodium" \
      "${home}/.config/VSCodium/User" || return $?
  fi
  target="${base}/${config_file}"

  module_shared_setup_config "$source" "$model" "$module_type" "$base" "$config" "$target" "${source}/${config}/${config_file}"
}
