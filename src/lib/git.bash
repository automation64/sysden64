function sysden64_git_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local model="${SYSDEN64_PATH_ETC}/git"

  bl64_msg_show_phase 'prepare GIT'
  bl64_fs_path_copy \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$home" \
    "${model}/.gitconfig" &&
    bl64_fs_path_copy \
      "$BL64_VAR_DEFAULT" \
      "$BL64_VAR_DEFAULT" \
      "$BL64_VAR_DEFAULT" \
      "$BL64_VAR_DEFAULT" \
      "${home}/${SYSDEN64_PATH_SHELLENV}" \
      "${model}/${SYSDEN64_PATH_SHELLENV}"/*.env
}
