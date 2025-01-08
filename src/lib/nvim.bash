function sysden64_nvim_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local target="${home}/.config/nvim"
  local model="${SYSDEN64_PATH_ETC}/nvim"

  bl64_lib_flag_is_enabled "$SYSDEN64_PROFILE_SWITCH" && return 0

  bl64_msg_show_phase 'prepare NVIM'
  ! bl64_bsh_command_is_executable 'nvim' &&
    bl64_dbg_app_show_info  "$SYSDEN64_TXT_NOT_DETECTED" && return 0

  bl64_fs_path_copy \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "${home}/${SYSDEN64_PATH_SHELLENV}" \
    "${model}/${SYSDEN64_PATH_SHELLENV}"/*.env ||
    return $?

  bl64_msg_show_task "setup NVIM (${target})"
  # shellcheck disable=SC2086
  bl64_fs_run_cp \
    $BL64_FS_SET_CP_RECURSIVE \
    $BL64_FS_SET_CP_FORCE \
    "${model}/.config/nvim" \
    "${home}/.config"
}
