# Version: 1.0.0
function sysden64_mc_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local target="${home}/.config/mc"
  local model='mc'

  bl64_lib_flag_is_enabled "$SYSDEN64_PROFILE_SWITCH" && return 0

  ! bl64_bsh_command_is_executable 'mc' &&
    bl64_dbg_app_show_info "$SYSDEN64_TXT_NOT_DETECTED" && return 0
  bl64_msg_show_phase 'prepare MC'

  module_create_shared "$model" || return $?
  model="$(module_set_model "$model")"

  bl64_msg_show_task "setup MC (${target})"
  # shellcheck disable=SC2086
  bl64_fs_run_cp \
    $BL64_FS_SET_CP_RECURSIVE \
    $BL64_FS_SET_CP_FORCE \
    "${model}/.config/mc" \
    "${home}/.config"
}
