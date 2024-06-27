function sysden64_gcloud_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local target="${home}/.config/gcloud"
  local vault=''
  local model="${SYSDEN64_PATH_ETC}/gcloud"

  bl64_msg_show_phase 'prepare GCloud CLI'
  bl64_msg_show_task "setup GCloud CLI (${target})"
  if bl64_lib_flag_is_enabled "$SYSDEN64_USE_DEVBIN64"; then
    vault="${DEV_PATH_PROF_VAULT}/gcloud"
    bl64_fs_create_dir "$BL64_VAR_DEFAULT" "$BL64_VAR_DEFAULT" "$BL64_VAR_DEFAULT" \
      "$vault" \
      "${vault}/configurations" &&
      bl64_fs_create_symlink \
        "$vault" \
        "$target" ||
      return $?
    target="$vault"
  else
    bl64_fs_create_dir "$BL64_VAR_DEFAULT" "$BL64_VAR_DEFAULT" "$BL64_VAR_DEFAULT" \
      "$target" \
      "${target}/configurations" ||
      return $?
  fi
  [[ -f "${target}/configurations/config_default" ]] &&
    bl64_msg_show_warning 'already configured. No further action taken' &&
    return 0
  bl64_fs_path_copy \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "${target}/configurations" \
    "${model}/.config/gcloud/configurations/config_default"
}
