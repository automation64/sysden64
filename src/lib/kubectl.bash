# Version: 1.1.0
function module_kubectl_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local module_type="$SYSDEN64_MODULE_TYPE_DEDICATED"
  local model='kubectl'
  local source=''

  local config='.kube'
  local target="${home}/${config}"
  local vault=''

  ! bl64_bsh_command_is_executable 'kubectl' &&
    bl64_dbg_app_show_info "$SYSDEN64_TXT_NOT_DETECTED" && return 0
  bl64_msg_show_phase 'prepare KubeCTL'

  module_create_shared "$module_type" "$model" &&
  source="$(module_set_model "$module_type" "$model")" ||
  return $?

  bl64_msg_show_task "setup environment variables (${home}/${SYSDEN64_PATH_SHELLENV})"
  bl64_fs_path_copy \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "${home}/${SYSDEN64_PATH_SHELLENV}" \
    "${source}/${SYSDEN64_PATH_SHELLENV}"/*.env

  module_sync_allow "$module_type" && return 0
  module_config_backup "$model" "$target" || return $?
  bl64_msg_show_task "setup KubeCTL (${target})"
  if bl64_lib_flag_is_enabled "$SYSDEN64_FLAG_USER_WIDE"; then
    vault="${DEV_PATH_PROF_VAULT}/kubectl"
    bl64_fs_dir_create "$BL64_VAR_DEFAULT" "$BL64_VAR_DEFAULT" "$BL64_VAR_DEFAULT" \
      "$vault" &&
      bl64_fs_symlink_create \
        "$vault" \
        "$target" \
        "$BL64_VAR_ON" ||
      return $?
    target="$vault"
  else
    bl64_fs_dir_create "$BL64_VAR_DEFAULT" "$BL64_VAR_DEFAULT" "$BL64_VAR_DEFAULT" \
      "$target" ||
      return $?
  fi
  bl64_msg_show_task "promote configuration from model (${model}/${config})"
  bl64_fs_path_copy \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$target" \
    "${source}/${config}/config"
}
