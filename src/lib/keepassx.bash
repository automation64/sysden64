function sysden64_keepassx_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local target="${home}/.config/keepassx"
  local model="${SYSDEN64_PATH_ETC}/keepassx"

  bl64_lib_flag_is_enabled "$SYSDEN64_PROFILE_SWITCH" && return 0

  bl64_msg_show_phase 'prepare KeePassX'
  bl64_msg_show_task "setup KeePassX (${target})"
  [[ -d "$target" ]] && bl64_msg_show_warning "$SYSDEN64_TXT_CONFIGURED" && return 0
  bl64_fs_path_copy \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "${home}/.config" \
    "${model}/.config/keepassx"
}
