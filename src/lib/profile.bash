# version: 1.0.0
function module_profile_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local module_type="$SYSDEN64_MODULE_TYPE_DEDICATED"
  local model='profile'
  local source=''

  bl64_msg_show_phase 'prepare profile'

  source="$(module_set_model "$module_type" "$model")" ||
    return $?

  if bl64_lib_flag_is_enabled "$SYSDEN64_ACTION_SWITCH"; then
    module_profile_setup_links "$home" "$source"
  elif bl64_lib_flag_is_enabled "$SYSDEN64_ACTION_SYNC"; then
    module_profile_setup_links "$home" "$source"
  elif bl64_lib_flag_is_enabled "$SYSDEN64_ACTION_DEPLOY"; then
    ! bl64_lib_flag_is_enabled "$SYSDEN64_FLAG_USER_WIDE" && return 0
    module_profile_setup_links "$home" "$source"
  else
    return 0
  fi
}

function module_profile_setup_links() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local source="$2"
  local resource_list=''
  local resource=''

  bl64_msg_show_task "update dedicated configuration links (${home}/${SYSDEN64_PATH_SHELLENV})"
  resource_list="$(cd "${source}/${SYSDEN64_PATH_SHELLENV}" && echo *)" ||
    return $?
  for resource in $resource_list; do
    bl64_fs_symlink_create \
      "${source}/${SYSDEN64_PATH_SHELLENV}/${resource}" \
      "${home}/${SYSDEN64_PATH_SHELLENV}/${resource}" \
      "$BL64_VAR_ON"
  done
}
