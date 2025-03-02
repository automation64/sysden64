# Version: 1.0.0
function sysden64_p10k_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local profile="${home}/.zshrc"
  local model='powerlevel10k'
  local config='.p10k.zsh'

  bl64_lib_flag_is_enabled "$SYSDEN64_PROFILE_SWITCH" && return 0

  ! bl64_bsh_command_is_executable 'zsh' &&
    bl64_dbg_app_show_info "$SYSDEN64_TXT_NOT_DETECTED" && return 0
  bl64_msg_show_phase 'prepare PowerLevel10K'

  module_create_shared "$model" || return $?
  model="$(module_set_model "$model")"

  config_backup "${home}/${config}"
  bl64_msg_show_task 'setup PowerLevel10K'
  # shellcheck disable=SC2086
  bl64_fs_path_copy \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$home" \
    "${model}/${config}" ||
    return $?

  bl64_msg_show_task "enable PowerLevel10K (${profile})"
  if ! bl64_txt_run_egrep "$BL64_TXT_SET_GREP_QUIET" '# PowerLevel10K' "$profile"; then
    "$BL64_OS_CMD_CAT" \
      "${model}/p10k.snippet" >>"$profile"
  fi
}
