# Version: 1.0.0
declare SYSDEN64_GIT_TMUX_PLUGINS=''
SYSDEN64_GIT_TMUX_PLUGINS+=' https://github.com/tmux-plugins/tpm.git'

function module_tmux_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local module_type="$SYSDEN64_MODULE_TYPE_SHARED"
  local model='tmux'
  local source=''

  local config='.tmux.conf'
  local target="${home}/${config}"
  local plugins_path="${home}/.tmux/plugins"

  module_profile_switch_allow "$module_type" && return 0

  ! bl64_bsh_command_is_executable 'tmux' &&
    bl64_dbg_app_show_info "$SYSDEN64_TXT_NOT_DETECTED" && return 0
  bl64_msg_show_phase 'prepare TMUX'

  module_create_shared "$module_type" "$model" &&
  source="$(module_set_model "$module_type" "$model")" ||
  return $?

  module_config_backup "$model" "$target" || return $?
  bl64_msg_show_task "promote configuration from model (${model}/${config})"
  bl64_fs_path_copy \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$home" \
    "${source}/${config}" ||
    return $?

  [[ -d "$plugins_path" ]] && return 0
  bl64_msg_show_task "deploy plugins (${plugins_path})"
  bl64_fs_dir_create "$BL64_VAR_DEFAULT" "$BL64_VAR_DEFAULT" "$BL64_VAR_DEFAULT" \
    "${home}/.tmux" ||
    return $?
  for plugin in $SYSDEN64_GIT_TMUX_PLUGINS; do
    bl64_vcs_git_clone \
      "$plugin" \
      "$plugins_path" ||
      return $?
  done
}
