# version: 1.2.1
function module_custom_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local module_type="$SYSDEN64_MODULE_TYPE_SHARED"
  local model='custom'
  local source=''

  bl64_msg_show_subtask "${SYSDEN64_TXT_CONFIGURE_MODULE}: Custom"

  source="$(module_set_model "$module_type" "$model")" ||
    return $?

  module_custom_setup_env "$home" "$source"
}

function module_custom_setup_env() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local source="$2"
  local source_env="${source}/${SYSDEN64_PATH_SHELLENV}"

  bl64_dbg_app_show_comments 'check if v3.5 backward compatibility is needed'
  if [[ -f "${source_env}/10_custom_path.env" ]]; then
    bl64_dbg_app_show_comments 'replace templates with old content'
    bl64_fs_run_mv -f "${source_env}/10_custom_path.env" "${source_env}/19_custom_path.env" &&
      bl64_fs_run_mv -f "${source_env}/20_custom_var.env" "${source_env}/29_custom_var.env" &&
      bl64_fs_run_mv -f "${source_env}/90_custom_alias.env" "${source_env}/99_custom_alias.env" ||
      return $?

    bl64_dbg_app_show_comments 'add new templates'
    bl64_fs_path_copy "$BL64_VAR_DEFAULT" "$BL64_VAR_DEFAULT" "$BL64_VAR_DEFAULT" "$BL64_VAR_DEFAULT" \
      "$source_env" \
      "${SYSDEN64_PATH_ETC}/custom/${SYSDEN64_PATH_SHELLENV}/19_custom_path.fish" \
      "${SYSDEN64_PATH_ETC}/custom/${SYSDEN64_PATH_SHELLENV}/29_custom_var.fish" \
      "${SYSDEN64_PATH_ETC}/custom/${SYSDEN64_PATH_SHELLENV}/79_custom_source.zsh" \
      "${SYSDEN64_PATH_ETC}/custom/${SYSDEN64_PATH_SHELLENV}/79_custom_source.bash" \
      "${SYSDEN64_PATH_ETC}/custom/${SYSDEN64_PATH_SHELLENV}/79_custom_source.fish" \
      "${SYSDEN64_PATH_ETC}/custom/${SYSDEN64_PATH_SHELLENV}/99_custom_alias.fish" ||
      return $?
  fi

  module_setup_env "$home" "$source"
}
