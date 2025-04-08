# Version: 2.0.0
function module_gpg_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local module_type="$SYSDEN64_MODULE_TYPE_DEDICATED"
  local model='gpg'
  local source=''
  local config='.gnupg'
  local target="${home}/${config}"
  local vault="${DEV_PATH_PROF_VAULT}/${model}"

  [[ -z "$(bl64_bsh_command_locate 'gpg')" ]] &&
    bl64_dbg_app_show_info "$SYSDEN64_TXT_NOT_DETECTED" && return 0
  bl64_msg_show_phase 'prepare GNUPG'

  source="$(module_set_model "$module_type" "$model")" ||
    return $?

  bl64_lib_flag_is_enabled "$SYSDEN64_FLAG_MODULE_SYNC" && return 0

  module_config_backup "$model" "$target" || return $?
  bl64_msg_show_task "setup GNUPG (${target})"
  if bl64_lib_flag_is_enabled "$SYSDEN64_FLAG_USER_WIDE"; then
    if [[ ! -d "$vault" ]]; then
      bl64_fs_dir_create "$BL64_VAR_DEFAULT" "$BL64_VAR_DEFAULT" "$BL64_VAR_DEFAULT" \
        "$vault" ||
        return $?
    fi
    bl64_fs_symlink_create "$vault" "$target" "$BL64_VAR_ON"
  else
    bl64_fs_dir_create "$BL64_VAR_DEFAULT" "$BL64_VAR_DEFAULT" "$BL64_VAR_DEFAULT" \
      "$target"
  fi
}
