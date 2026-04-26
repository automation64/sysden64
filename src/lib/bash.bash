# version: 2.0.3
# template: lib-config-2.0.0
function module_bash_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local module_type="$SYSDEN64_MODULE_TYPE_SHARED"
  local module_name='bash'
  local module_etc=''

  module_detect "$module_name" 'bash' 'Bash Shell' || return 0

  module_etc="$(module_config_get_source "$module_type" "$module_name")" &&
    module_bash_setup_config "$home" "$module_etc" "$module_name" "$module_type"
}

function module_bash_setup_config() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local module_etc="$2"
  local module_name="$3"
  local module_type="$4"
  local config_destination="${home}"
  local config_profile='.bash_profile'
  local config_rc='.bashrc'
  local target_profile="${config_destination}/${config_profile}"
  local target_rc="${config_destination}/${config_rc}"

  module_config_backup "$module_name" "$module_type" "$target_profile" "$target_rc" ||
    return $?

  bl64_msg_show_subtask "${SYSDEN64_TXT_PROMOTE_SHARED} (${module_etc}->${config_destination})"
  bl64_fs_path_copy \
    '0700' \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$config_destination" \
    "${module_etc}/${config_profile}" \
    "${module_etc}/${config_rc}"
}
