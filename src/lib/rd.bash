# version: 1.1.0
# template: lib-config-1.0.0
function module_rd_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local module_type="$SYSDEN64_MODULE_TYPE_SHARED"
  local model='rd'
  local source=''

  [[ "$BL64_OS_TYPE" != "$BL64_OS_TYPE_MACOS" ]] &&
    [[ ! -x '/Applications/Rancher Desktop.app/Contents/Resources/resources/darwin/bin/docker' ]] &&
    bl64_dbg_app_show_info "$SYSDEN64_TXT_NOT_DETECTED" && return 0
  bl64_msg_show_phase 'prepare Rancher Desktop'

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

  module_config_backup "$model" "$module_type" "${target}" ||
    return $?

  bl64_msg_show_task "promote configuration from model (${model}/${config})"
  # shellcheck disable=SC2086
  bl64_fs_path_copy \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$base" \
    "${source}/${config}/${BL64_OS_TYPE}/${config_file}"
}
