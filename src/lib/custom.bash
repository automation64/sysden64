# version: 1.3.1
function module_custom_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local module_type="$SYSDEN64_MODULE_TYPE_SHARED"
  local module_name='custom'
  local module_etc=''

  bl64_msg_show_subtask "${SYSDEN64_TXT_CONFIGURE_MODULE}: Custom"

  module_etc="$(module_config_get_source "$module_type" "$module_name")" ||
    return $?

  module_setup_env "$home" "$module_etc" "$module_type" "$module_name"
}

function module_custom_upgrade() {
  bl64_dbg_app_show_function
  local module_name='custom'
  local base_env="${SYSDEN64_PATH_ETC}/${module_name}/${SYSDEN64_PATH_SHELLENV}"
  local source_env=''

  source_env="$(module_config_get_source "$SYSDEN64_MODULE_TYPE_SHARED" "$module_name")" &&
    source_env="${source_env}/${SYSDEN64_PATH_SHELLENV}" &&
    module_custom_upgrade_legacy_v3_5 "$source_env" "$base_env" &&
    module_custom_upgrade_legacy_v4_11 "$source_env" &&
    module_custom_upgrade_new "$source_env" "$base_env"
}

function module_custom_upgrade_legacy_v3_5() {
  bl64_dbg_app_show_function "$@"
  local source_env="$1"
  local base_env="$2"

  bl64_dbg_app_show_comments 'check if v3.5 backward compatibility is needed'
  [[ ! -f "${source_env}/10_custom_path.env" ]] && return 0
  bl64_msg_show_subtask 'migrate legacy files (v3.5)'

  bl64_dbg_app_show_comments 'replace templates with old content'
  bl64_fs_run_mv -f "${source_env}/10_custom_path.env" "${source_env}/19_custom_path.env" &&
    bl64_fs_run_mv -f "${source_env}/20_custom_var.env" "${source_env}/29_custom_var.env" &&
    bl64_fs_run_mv -f "${source_env}/90_custom_alias.env" "${source_env}/99_custom_alias.env" ||
    return $?

  bl64_dbg_app_show_comments 'add new templates'
  bl64_fs_path_copy "$BL64_VAR_DEFAULT" "$BL64_VAR_DEFAULT" "$BL64_VAR_DEFAULT" "$BL64_VAR_DEFAULT" \
    "$source_env" \
    "${base_env}/19_custom_path.fish" \
    "${base_env}/29_custom_var.fish" \
    "${base_env}/79_custom_source.zsh" \
    "${base_env}/79_custom_source.bash" \
    "${base_env}/79_custom_source.fish" \
    "${base_env}/99_custom_alias.fish" ||
    return $?

  return 0
}

function module_custom_upgrade_legacy_v4_11() {
  bl64_dbg_app_show_function "$@"
  local source_env="$1"

  bl64_dbg_app_show_comments 'check if v4.11 backward compatibility is needed'
  [[ ! -f "${source_env}/19_custom_path.env" ]] && return 0
  bl64_msg_show_subtask 'migrate legacy files (v4.11)'

  bl64_dbg_app_show_comments 'rename templates'

  if [[ -f "${source_env}/19_custom_path.env" ]]; then
    bl64_fs_run_mv $BL64_FS_SET_MV_FORCE \
      "${source_env}/19_custom_path.env" \
      "${source_env}/18_custom_path.env" ||
      return $?
  fi
  if [[ -f "${source_env}/19_custom_path.fish" ]]; then
    bl64_fs_run_mv $BL64_FS_SET_MV_FORCE \
      "${source_env}/19_custom_path.fish" \
      "${source_env}/18_custom_path.fish" ||
      return $?
  fi
  if [[ -f "${source_env}/29_custom_var.env" ]]; then
    bl64_fs_run_mv $BL64_FS_SET_MV_FORCE \
      "${source_env}/29_custom_var.env" \
      "${source_env}/28_custom_var.env" ||
      return $?
  fi
  if [[ -f "${source_env}/29_custom_var.fish" ]]; then
    bl64_fs_run_mv $BL64_FS_SET_MV_FORCE \
      "${source_env}/29_custom_var.fish" \
      "${source_env}/28_custom_var.fish" ||
      return $?
  fi
  if [[ -f "${source_env}/79_custom_source.bash" ]]; then
    bl64_fs_run_mv $BL64_FS_SET_MV_FORCE \
      "${source_env}/79_custom_source.bash" \
      "${source_env}/78_custom_source.bash" ||
      return $?
  fi
  if [[ -f "${source_env}/79_custom_source.fish" ]]; then
    bl64_fs_run_mv $BL64_FS_SET_MV_FORCE \
      "${source_env}/79_custom_source.fish" \
      "${source_env}/78_custom_source.fish" ||
      return $?
  fi
  if [[ -f "${source_env}/79_custom_source.zsh" ]]; then
    bl64_fs_run_mv $BL64_FS_SET_MV_FORCE \
      "${source_env}/79_custom_source.zsh" \
      "${source_env}/78_custom_source.zsh" ||
      return $?
  fi
  if [[ -f "${source_env}/99_custom_alias.env" ]]; then
    bl64_fs_run_mv $BL64_FS_SET_MV_FORCE \
      "${source_env}/99_custom_alias.env" \
      "${source_env}/98_custom_alias.env" ||
      return $?
  fi
  if [[ -f "${source_env}/99_custom_alias.fish" ]]; then
    bl64_fs_run_mv $BL64_FS_SET_MV_FORCE \
      "${source_env}/99_custom_alias.fish" \
      "${source_env}/98_custom_alias.fish" ||
      return $?
  fi

  return 0
}

function module_custom_upgrade_new() {
  bl64_dbg_app_show_function
  local source_env="$1"
  local base_env="$2"
  local module_name='custom'
  local files=''
  local file=''

  bl64_msg_show_task "upgrade module_name (${module_name}: new files only)"
  bl64_bsh_run_pushd "$base_env" &&
    files="$(bl64_bsh_pattern_match_file "*_${module_name}_*")" &&
    bl64_bsh_run_popd ||
    return $?

  for file in $files; do
    [[ -f "${source_env}/${file}" ]] && continue
    bl64_fs_path_copy \
      "$BL64_VAR_DEFAULT" "$BL64_VAR_DEFAULT" "$BL64_VAR_DEFAULT" "$BL64_VAR_DEFAULT" \
      "$source_env" \
      "${base_env}/${file}" ||
      return $?
  done
}
