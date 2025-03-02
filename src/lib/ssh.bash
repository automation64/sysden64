# Version: 1.1.0
function module_ssh_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local config='.ssh'
  local target="${home}/${config}"
  local vault=''
  local model='ssh'

  ! bl64_bsh_command_is_executable 'ssh' &&
    bl64_dbg_app_show_info "$SYSDEN64_TXT_NOT_DETECTED" && return 0
  bl64_msg_show_phase 'prepare OpenSSH'

  module_create_shared "$model" || return $?
  model="$(module_set_model "$model")"

  bl64_lib_flag_is_enabled "$SYSDEN64_FLAG_MODULE_UPGRADE" && return 0

  config_backup "$target" || return $?
  bl64_msg_show_task "setup OpenSSH (${target})"
  if bl64_lib_flag_is_enabled "$SYSDEN64_USE_DEVBIN64"; then
    vault="${DEV_PATH_PROF_VAULT}/ssh"
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

  [[ -f "${target}/config" ]] &&
    bl64_msg_show_warning "$SYSDEN64_TXT_CONFIGURED" &&
    return 0
  bl64_msg_show_task "promote configuration from model (${model}/${config})"
  bl64_fs_path_copy \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$target" \
    "${model}/${config}/config"
}
