function sysden64_gpg_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local target="${home}/.gnupg"
  local vault="${DEV_PATH_PROF_VAULT}/gnupg"

  bl64_msg_show_phase 'prepare GNUPG'
  bl64_msg_show_task "setup GNUPG (${target})"
  if bl64_lib_flag_is_enabled "$SYSDEN64_USE_DEVBIN64"; then
    bl64_fs_create_dir "$BL64_VAR_DEFAULT" "$BL64_VAR_DEFAULT" "$BL64_VAR_DEFAULT" \
      "$vault" &&
      bl64_fs_create_symlink \
        "$vault" \
        "$target"
  else
    bl64_fs_create_dir "$BL64_VAR_DEFAULT" "$BL64_VAR_DEFAULT" "$BL64_VAR_DEFAULT" \
      "$target" ||
      return $?
  fi
}
