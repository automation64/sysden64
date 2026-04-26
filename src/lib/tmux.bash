# version: 1.0.5
# template: lib-config-2.0.0
declare SYSDEN64_GIT_TMUX_PLUGINS=''
SYSDEN64_GIT_TMUX_PLUGINS+=' https://github.com/tmux-plugins/tpm.git'

function module_tmux_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local module_type="$SYSDEN64_MODULE_TYPE_SHARED"
  local module_name='tmux'
  local module_etc=''

  module_detect "$module_name" 'tmux' 'TMUX - Terminal Multiplexer' || return 0

  module_etc="$(module_config_get_source "$module_type" "$module_name")" &&
    module_tmux_setup_config "$home" "$module_etc" "$module_name" "$module_type" &&
    module_tmux_setup_plugins "$home"
}

function module_tmux_setup_config() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local module_etc="$2"
  local module_name="$3"
  local module_type="$4"
  local config_destination="${home}"
  local module_config='conf'
  local config_file='.tmux.conf'
  local config_backup="${config_destination}/${config_file}"

  module_shared_setup_config "$module_etc" "$module_name" "$module_type" "$config_destination" "$config_backup" "${module_etc}/${module_config}/${config_file}"
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
