# Version: 1.1.0
function module_gcloud_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local module_type="$SYSDEN64_MODULE_TYPE_DEDICATED"
  local model='gcloud'
  local config='.config/gcloud'
  local target="${home}/${config}"
  local vault=''

  ! bl64_bsh_command_is_executable 'gcloud' &&
    bl64_dbg_app_show_info "$SYSDEN64_TXT_NOT_DETECTED" && return 0
  bl64_msg_show_phase 'prepare GCloud CLI'

  module_create_shared "$model" "$module_type" "$module_type" || return $?
  model="$(module_set_model "$model")"

  bl64_msg_show_task "setup environment variables (${home}/${SYSDEN64_PATH_SHELLENV})"
  bl64_fs_path_copy \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "${home}/${SYSDEN64_PATH_SHELLENV}" \
    "${model}/${SYSDEN64_PATH_SHELLENV}"/*.env ||
    return $?

  module_sync_allow "$module_type" && return 0
  config_backup "$target" || return $?
  bl64_msg_show_task "setup GCloud CLI (${target})"
  if bl64_lib_flag_is_enabled "$SYSDEN64_FLAG_USE_DEVBIN64"; then
    vault="${DEV_PATH_PROF_VAULT}/gcloud"
    bl64_fs_dir_create "$BL64_VAR_DEFAULT" "$BL64_VAR_DEFAULT" "$BL64_VAR_DEFAULT" \
      "$vault" \
      "${vault}/configurations" &&
      bl64_fs_symlink_create \
        "$vault" \
        "$target" \
        "$BL64_VAR_ON" ||
      return $?
    target="$vault"
  else
    bl64_fs_dir_create "$BL64_VAR_DEFAULT" "$BL64_VAR_DEFAULT" "$BL64_VAR_DEFAULT" \
      "$target" \
      "${target}/configurations" ||
      return $?
  fi
  [[ -f "${target}/configurations/config_default" ]] &&
    bl64_msg_show_warning "$SYSDEN64_TXT_CONFIGURED" &&
    return 0
  bl64_msg_show_task "promote configuration from model (${model}/${config})"
  bl64_fs_path_copy \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "${target}/configurations" \
    "${model}/${config}/configurations/config_default"
}
