# Version: 1.0.0
function module_ripgrep_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local model='ripgrep'

  bl64_lib_flag_is_enabled "$SYSDEN64_FLAG_PROFILE_SWITCH" && return 0

  ! bl64_bsh_command_is_executable 'rg' &&
    bl64_dbg_app_show_info "$SYSDEN64_TXT_NOT_DETECTED" && return 0
  bl64_msg_show_phase 'prepare RipGrep'

  module_create_shared "$model" || return $?
  model="$(module_set_model "$model")"

  bl64_msg_show_task "setup environment variables (${home}/${SYSDEN64_PATH_SHELLENV})"
  bl64_fs_path_copy \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "${home}/${SYSDEN64_PATH_SHELLENV}" \
    "${model}/${SYSDEN64_PATH_SHELLENV}"/*.env
}
