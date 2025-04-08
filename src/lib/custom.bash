# Version: 1.2.0
function module_custom_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local module_type="$SYSDEN64_MODULE_TYPE_SHARED"
  local model='custom'
  local source=''

  bl64_msg_show_phase 'prepare custom'

  source="$(module_set_model "$module_type" "$model")" ||
    return $?

  module_custom_setup_env "$home" "$source"
}

function module_custom_setup_env() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local source="$2"
  source="${source}/${SYSDEN64_PATH_SHELLENV}"

  bl64_dbg_app_show_comments 'check if backward compatibility is needed'
  if [[ -f "${source}/10_custom_path.env" ]]; then
    bl64_dbg_app_show_comments 'replace templates with old content'
    bl64_fs_run_mv -f "${source}/10_custom_path.env" "${source}/19_custom_path.env" &&
      bl64_fs_run_mv -f "${source}/20_custom_var.env" "${source}/29_custom_var.env" &&
      bl64_fs_run_mv -f "${source}/90_custom_alias.env" "${source}/99_custom_alias.env" ||
      return $?

    bl64_dbg_app_show_comments 'add new templates'
    bl64_fs_path_copy "$BL64_VAR_DEFAULT" "$BL64_VAR_DEFAULT" "$BL64_VAR_DEFAULT" "$BL64_VAR_DEFAULT" \
      "$source" "${SYSDEN64_PATH_ETC}/custom/${SYSDEN64_PATH_SHELLENV}/79_custom_source.zsh" &&
      bl64_fs_path_copy "$BL64_VAR_DEFAULT" "$BL64_VAR_DEFAULT" "$BL64_VAR_DEFAULT" "$BL64_VAR_DEFAULT" \
        "$source" "${SYSDEN64_PATH_ETC}/custom/${SYSDEN64_PATH_SHELLENV}/79_custom_source.bash" &&
      bl64_fs_path_copy "$BL64_VAR_DEFAULT" "$BL64_VAR_DEFAULT" "$BL64_VAR_DEFAULT" "$BL64_VAR_DEFAULT" \
        "$source" "${SYSDEN64_PATH_ETC}/custom/${SYSDEN64_PATH_SHELLENV}/79_custom_source.fish" ||
      return $?
  fi

  bl64_msg_show_task "setup environment variables (${home}/${SYSDEN64_PATH_SHELLENV})"
  bl64_fs_path_copy \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "${home}/${SYSDEN64_PATH_SHELLENV}" \
    "${source}"/*.{env,bash,zsh,fish}
}
