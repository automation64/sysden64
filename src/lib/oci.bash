# template: lib-dedicated-1.0.0
# version: 1.0.1
function module_oci_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local module_type="$SYSDEN64_MODULE_TYPE_DEDICATED"
  local model='oci'
  local source=''
  local extra_locations="${HOME}/.local/bin"

  [[ -z "$(bl64_bsh_command_locate 'oci' "$extra_locations")" ]] &&
    bl64_dbg_app_show_info "$SYSDEN64_TXT_NOT_DETECTED" && return 0
  bl64_msg_show_phase 'prepare OCI CLI'

  source="$(module_set_model "$module_type" "$model")" &&
    module_oci_setup_config "$home" "$source" "$model"
}

function module_oci_setup_config() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local source="$2"
  local model="$3"
  local target_base="${home}"
  local config='.oci'
  local target="${target_base}/${config}"

  module_dedicated_is_new "$model" || return 0
  module_config_backup "$model" "$target" ||
    return $?

  bl64_msg_show_task "promote configuration from model (${model}/${config})"
  if bl64_lib_flag_is_enabled "$SYSDEN64_FLAG_USER_WIDE"; then
    target_base="${DEV_PATH_PROF_VAULT}/${model}"
    bl64_fs_dir_create "$BL64_VAR_DEFAULT" "$BL64_VAR_DEFAULT" "$BL64_VAR_DEFAULT" \
      "$target_base" &&
      bl64_fs_path_copy \
        "$BL64_VAR_DEFAULT" \
        "$BL64_VAR_DEFAULT" \
        "$BL64_VAR_DEFAULT" \
        "$BL64_VAR_DEFAULT" \
        "$target_base" \
        "${source}/${config}" &&
      bl64_fs_symlink_create "${target_base}/${config}" "$target" "$BL64_VAR_ON"
  else
    bl64_fs_path_copy \
      "$BL64_VAR_DEFAULT" \
      "$BL64_VAR_DEFAULT" \
      "$BL64_VAR_DEFAULT" \
      "$BL64_VAR_DEFAULT" \
      "$target_base" \
      "${source}/${config}"
  fi
}
