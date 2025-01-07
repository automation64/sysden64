function sysden64_docker_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local target="${home}/.docker"
  local vault=''
  local model="${SYSDEN64_PATH_ETC}/docker"

  bl64_msg_show_phase 'prepare Docker CLI'
  ! bl64_bsh_command_is_executable 'docker' &&
    bl64_msg_show_warning "$SYSDEN64_TXT_NOT_DETECTED" && return 0

  bl64_fs_path_copy \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "${home}/${SYSDEN64_PATH_SHELLENV}" \
    "${model}/${SYSDEN64_PATH_SHELLENV}"/*.env ||
    return $?

  bl64_msg_show_task "setup Docker CLI (${target})"
  if bl64_lib_flag_is_enabled "$SYSDEN64_USE_DEVBIN64"; then
    vault="${DEV_PATH_PROF_VAULT}/docker"
    bl64_fs_dir_create "$BL64_VAR_DEFAULT" "$BL64_VAR_DEFAULT" "$BL64_VAR_DEFAULT" \
      "$vault" &&
      bl64_fs_symlink_create \
        "$vault" \
        "$target" ||
      return $?
    target="$vault"
  else
    bl64_fs_dir_create "$BL64_VAR_DEFAULT" "$BL64_VAR_DEFAULT" "$BL64_VAR_DEFAULT" \
      "$target" ||
      return $?
  fi
  [[ -f "${target}/config.json" ]] &&
    bl64_msg_show_warning "$SYSDEN64_TXT_CONFIGURED" &&
    return 0
  bl64_fs_path_copy \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$target" \
    "${model}/.docker/config.json"
}
