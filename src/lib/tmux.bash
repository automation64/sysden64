# Version: 1.0.2
declare SYSDEN64_GIT_TMUX_PLUGINS=''
SYSDEN64_GIT_TMUX_PLUGINS+=' https://github.com/tmux-plugins/tpm.git'

function module_tmux_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local module_type="$SYSDEN64_MODULE_TYPE_SHARED"
  local model='tmux'
  local source=''

  [[ -z "$(bl64_bsh_command_locate 'tmux')" ]] &&
    bl64_dbg_app_show_info "$SYSDEN64_TXT_NOT_DETECTED" && return 0
  bl64_msg_show_phase 'prepare TMUX'

  source="$(module_set_model "$module_type" "$model")" &&
    module_tmux_setup_config "$home" "$source" "$model"
}

function module_tmux_setup_config() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local source="$2"
  local model="$3"
  local target_base="${home}"
  local config='conf'
  local config_file='.tmux.conf'
  local target="${target_base}/${config_file}"

  module_config_backup "$model" "$target" || return $?
  bl64_msg_show_task "promote configuration from model (${model}/${config})"
  bl64_fs_path_copy \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$target_base" \
    "${source}/${config}/${config_file}" ||
    return $?

  module_tmux_setup_plugins "$home"
}

function module_tmux_setup_plugins() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local tmux_path="${home}/.tmux"
  local plugins_path="${tmux_path}/plugins"
  local plugin=''

  [[ -d "$plugins_path" ]] && return 0
  bl64_msg_show_task "deploy plugins (${plugins_path})"
  bl64_fs_dir_create "$BL64_VAR_DEFAULT" "$BL64_VAR_DEFAULT" "$BL64_VAR_DEFAULT" \
    "$tmux_path" \
    "$plugins_path" ||
    return $?
  for plugin in $SYSDEN64_GIT_TMUX_PLUGINS; do
    bl64_vcs_git_clone \
      "$plugin" \
      "$plugins_path" ||
      return $?
  done
}
