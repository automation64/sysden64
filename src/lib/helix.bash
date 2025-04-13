# Version: 1.0.0
function module_helix_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local module_type="$SYSDEN64_MODULE_TYPE_SHARED"
  local model='helix'
  local source=''

  [[ -z "$(bl64_bsh_command_locate 'hx')" ]] &&
    bl64_dbg_app_show_info "$SYSDEN64_TXT_NOT_DETECTED" && return 0
  bl64_msg_show_phase 'prepare Helix Editor'

  source="$(module_set_model "$module_type" "$model")" &&
    module_helix_setup_config "$home" "$source" "$model"
}

function module_helix_setup_config() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local source="$2"
  local model="$3"
  local target_base="${home}/.config/helix"
  local config='/.config/helix'
  local config_file='config.toml'
  local target="${home}/${config}/${config_file}"

  module_config_backup "$model" "$target" ||
    return $?

  bl64_msg_show_task "promote configuration from model (${model}/${config})"
  # shellcheck disable=SC2086
  bl64_fs_dir_create \
    "$BL64_VAR_DEFAULT" "$BL64_VAR_DEFAULT" "$BL64_VAR_DEFAULT" \
    "$target_base" &&
    bl64_fs_path_copy \
      "$BL64_VAR_DEFAULT" \
      "$BL64_VAR_DEFAULT" \
      "$BL64_VAR_DEFAULT" \
      "$BL64_VAR_DEFAULT" \
      "$target_base" \
      "${source}/${config}/${config_file}"
}
