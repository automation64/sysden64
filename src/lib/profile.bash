# version: 1.0.3
function module_profile_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local module_type="$SYSDEN64_MODULE_TYPE_DEDICATED"
  local module_name='profile'
  local module_etc=''

  ! user_wide_is_enabled && return 0
  bl64_msg_show_subtask "${SYSDEN64_TXT_CONFIGURE_MODULE}: SysDen64 Profile"

  module_etc="$(module_config_get_source "$module_type" "$module_name")" ||
    return $?

  if bl64_lib_flag_is_enabled "$SYSDEN64_ACTION_SWITCH" ||
    bl64_lib_flag_is_enabled "$SYSDEN64_ACTION_SYNC" ||
    bl64_lib_flag_is_enabled "$SYSDEN64_ACTION_DEPLOY"; then
    module_profile_setup_links "$home" "$module_etc"
  else
    return 0
  fi
}

function module_profile_setup_links() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local module_etc="$2"
  local resource_list=''
  local resource=''

  bl64_msg_show_subtask "update dedicated configuration links (${home}/${SYSDEN64_PATH_SHELLENV})"
  resource_list="$(cd "${module_etc}/${SYSDEN64_PATH_SHELLENV}" && echo *)" ||
    return $?
  for resource in $resource_list; do
    bl64_fs_symlink_create \
      "${module_etc}/${SYSDEN64_PATH_SHELLENV}/${resource}" \
      "${home}/${SYSDEN64_PATH_SHELLENV}/${resource}" \
      "$BL64_VAR_ON"
  done
}
