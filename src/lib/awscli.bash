# Version: 1.0.0
function sysden64_awscli_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local config='.aws'
  local target="${home}/${config}"
  local vault=''
  local model="${SYSDEN64_PATH_ETC}/aws"

  ! bl64_bsh_command_is_executable 'aws' &&
    bl64_dbg_app_show_info "$SYSDEN64_TXT_NOT_DETECTED" && return 0
  bl64_msg_show_phase 'prepare AWS CLI'

  bl64_fs_path_copy \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "${home}/${SYSDEN64_PATH_SHELLENV}" \
    "${model}/${SYSDEN64_PATH_SHELLENV}"/*.env ||
    return $?

  config_backup "$target" || return $?
  bl64_msg_show_task "setup AWS CLI (${target})"
  if bl64_lib_flag_is_enabled "$SYSDEN64_USE_DEVBIN64"; then
    vault="${DEV_PATH_PROF_VAULT}/aws"
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
  bl64_fs_path_copy \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$target" \
    "${model}/${config}/config"
}
