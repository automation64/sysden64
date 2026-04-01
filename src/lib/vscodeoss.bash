# version: 1.0.2
# template: lib-config-1.0.0
function module_vscodeoss_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local module_type="$SYSDEN64_MODULE_TYPE_SHARED"
  local module='vscodeoss'
  local source=''
  local extra_locations=''

  [[ "$BL64_OS_TYPE" != "$BL64_OS_TYPE_LINUX" ]] && return 0
  module_detect "$module" 'code-oss' 'VSCode OSS IDE' "$extra_locations" || return 0

  source="$(module_config_get_source "$module_type" "$module")" &&
    module_setup_env "$home" "$source" "$module_type" "$module" &&
    module_vscodeoss_setup_config "$home" "$source" "$module" "$module_type"
}

function module_vscodeoss_setup_config() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local source="$2"
  local module="$3"
  local module_type="$4"
  local base=''
  local config='settings'
  local config_file='settings.json'
  local target=''

  if [[ "$BL64_OS_TYPE" == "$BL64_OS_TYPE_LINUX" ]]; then
    base="${home}/.config/Code - OSS"
    bl64_fs_dir_create \
      "$BL64_VAR_DEFAULT" "$BL64_VAR_DEFAULT" "$BL64_VAR_DEFAULT" \
      "${base}" \
      "${base}/User" || return $?
  fi
  base+='/User'
  target="${base}/${config_file}"

  module_shared_setup_config "$source" "$module" "$module_type" "$base" "$config" "$target" "${source}/${config}/${config_file}"
}
