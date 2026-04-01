# version: 1.0.5
# template: lib-config-1.0.0
declare SYSDEN64_GIT_TMUX_PLUGINS=''
SYSDEN64_GIT_TMUX_PLUGINS+=' https://github.com/tmux-plugins/tpm.git'

function module_tmux_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local module_type="$SYSDEN64_MODULE_TYPE_SHARED"
  local module='tmux'
  local source=''

  module_detect "$module" 'tmux' 'TMUX - Terminal Multiplexer' || return 0

  source="$(module_config_get_source "$module_type" "$module")" &&
    module_tmux_setup_config "$home" "$source" "$module" "$module_type" &&
    module_tmux_setup_plugins "$home"
}

function module_tmux_setup_config() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local source="$2"
  local module="$3"
  local module_type="$4"
  local base="${home}"
  local config='conf'
  local config_file='.tmux.conf'
  local target="${base}/${config_file}"

  module_shared_setup_config "$source" "$module" "$module_type" "$base" "$config" "$target" "${source}/${config}/${config_file}"
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
