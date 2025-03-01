# Version: 1.0.0
function sysden64_alacritty_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local model="${SYSDEN64_PATH_ETC}/alacritty"
  local config='.alacritty.yml'

  bl64_lib_flag_is_enabled "$SYSDEN64_PROFILE_SWITCH" && return 0

  bl64_lib_flag_is_enabled "$SYSDEN64_USE_DEVBIN64

  ! bl64_bsh_command_is_executable 'alacritty' &&
    bl64_dbg_app_show_info "$SYSDEN64_TXT_NOT_DETECTED" && return 0
  bl64_msg_show_phase 'prepare Alacritty'

  config_backup "${home}/${config}" || return $?
  bl64_msg_show_task "promote configuration from model (${model}/${config})"
  bl64_fs_path_copy \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$home" \
    "${model}/${config}"
}
