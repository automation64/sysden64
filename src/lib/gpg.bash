# Version: 1.1.0
function module_gpg_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local module_type="$SYSDEN64_MODULE_TYPE_DEDICATED"
  local model='gpg'
  local config='.gnupg'
  local target="${home}/${config}"
  local vault=''

  module_profile_switch_allow "$module_type" && return 0

  ! bl64_bsh_command_is_executable 'gpg' &&
    bl64_dbg_app_show_info "$SYSDEN64_TXT_NOT_DETECTED" && return 0
  bl64_msg_show_phase 'prepare GNUPG'

  module_create_shared "$model" "$module_type" "$module_type" || return $?
  model="$(module_set_model "$model")"

  module_sync_allow "$module_type" && return 0
  config_backup "$target" || return $?
  bl64_msg_show_task "setup GNUPG (${target})"
  if bl64_lib_flag_is_enabled "$SYSDEN64_FLAG_USE_DEVBIN64"; then
    vault="${DEV_PATH_PROF_VAULT}/gnupg"
    bl64_fs_dir_create "$BL64_VAR_DEFAULT" "$BL64_VAR_DEFAULT" "$BL64_VAR_DEFAULT" \
      "$vault" &&
      bl64_fs_symlink_create \
        "$vault" \
        "$target" \
        "$BL64_VAR_ON"
  else
    bl64_fs_dir_create "$BL64_VAR_DEFAULT" "$BL64_VAR_DEFAULT" "$BL64_VAR_DEFAULT" \
      "$target" ||
      return $?
  fi
}
