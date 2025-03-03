# Version: 2.0.0
function module_bash_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local module_type="$SYSDEN64_MODULE_TYPE_SHARED"
  local model='bash'
  local source=''
  local config_profile='.bash_profile'
  local config_rc='.bashrc'

  module_profile_switch_allow "$module_type" && return 0

  ! bl64_bsh_command_is_executable 'bash' &&
    bl64_dbg_app_show_info "$SYSDEN64_TXT_NOT_DETECTED" && return 0
  bl64_msg_show_phase 'prepare Bash'

  module_create_shared "$module_type" "$model" &&
  source="$(module_set_model "$module_type" "$model")" ||
  return $?

  module_sync_allow "$module_type" && return 0
  module_config_backup "$model" "${config_profile}" "${config_rc}" || return $?
  bl64_msg_show_task "promote configuration from model (${model})"
  bl64_fs_path_copy \
    '0700' \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$home" \
    "${source}/${config_profile}" \
    "${source}/${config_rc}"
}
