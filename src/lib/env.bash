function module_env_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local module_type="$SYSDEN64_MODULE_TYPE_SHARED"
  local model='env'
  local source=''
  bl64_msg_show_phase 'prepare shell-env'

  source="$(module_set_model "$module_type" "$model")" ||
  return $?

  bl64_msg_show_task "Populate env store  (${SYSDEN64_PATH_SHELLENV})"
  # shellcheck disable=SC2086
  bl64_fs_path_copy \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$home" \
    "${source}/${SYSDEN64_PATH_SHELLENV}"
}
