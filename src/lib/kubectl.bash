function sysden64_kubectl_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local target="${home}/.kube"
  local vault=''
  local model="${SYSDEN64_PATH_ETC}/kubectl"

  bl64_msg_show_phase 'prepare KubeCTL'
  ! bl64_bsh_command_is_executable 'kubectl' &&
    bl64_msg_show_warning "$SYSDEN64_TXT_NOT_DETECTED" && return 0

  bl64_fs_path_copy \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "${home}/${SYSDEN64_PATH_SHELLENV}" \
    "${model}/${SYSDEN64_PATH_SHELLENV}"/*.env

  bl64_msg_show_task "setup KubeCTL (${target})"
  if bl64_lib_flag_is_enabled "$SYSDEN64_USE_DEVBIN64"; then
    vault="${DEV_PATH_PROF_VAULT}/kubectl"
    bl64_fs_create_dir "$BL64_VAR_DEFAULT" "$BL64_VAR_DEFAULT" "$BL64_VAR_DEFAULT" \
      "$vault" &&
      bl64_fs_create_symlink \
        "$vault" \
        "$target" ||
      return $?
    target="$vault"
  else
    bl64_fs_create_dir "$BL64_VAR_DEFAULT" "$BL64_VAR_DEFAULT" "$BL64_VAR_DEFAULT" \
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
    "${model}/.kube/config"
}
