# Version: 1.0.1
function sysden64_lnav_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local config='lnav'
  local target="${home}/.config/${config}"
  local model="${SYSDEN64_PATH_ETC}/${config}"

  bl64_lib_flag_is_enabled "$SYSDEN64_PROFILE_SWITCH" && return 0

  ! bl64_bsh_command_is_executable 'lnav' &&
    bl64_dbg_app_show_info "$SYSDEN64_TXT_NOT_DETECTED" && return 0
  bl64_msg_show_phase 'prepare LNAV'

  module_create_shared "$model" || return $?
  model="$(module_set_model "$model")"

  config_backup "${home}/.config/${config}"
  bl64_msg_show_task "promote configuration from model (${model}/.config/${config})"
  bl64_fs_path_copy \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "${home}/.config" \
    "${model}/.config/${config}"
}
