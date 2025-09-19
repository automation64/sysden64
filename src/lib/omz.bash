# version: 2.1.0
# template: lib-env-1.0.0
declare SYSDEN64_OMZ_GIT_LOCAL='.oh-my-zsh'
declare SYSDEN64_OMZ_GIT='https://github.com/ohmyzsh/ohmyzsh.git'
declare SYSDEN64_OMZ_GIT_PLUGINS=''
SYSDEN64_OMZ_GIT_PLUGINS+=' https://github.com/marlonrichert/zsh-autocomplete.git'
SYSDEN64_OMZ_GIT_PLUGINS+=' https://github.com/zsh-users/zsh-autosuggestions.git'
SYSDEN64_OMZ_GIT_PLUGINS+=' https://github.com/zsh-users/zsh-syntax-highlighting.git'
SYSDEN64_OMZ_GIT_PLUGINS+=' https://github.com/zsh-users/zsh-completions.git'
SYSDEN64_OMZ_GIT_PLUGINS+=' https://github.com/Aloxaf/fzf-tab.git'
SYSDEN64_OMZ_GIT_PLUGINS+=' https://github.com/joshskidmore/zsh-fzf-history-search.git'
declare SYSDEN64_OMZ_GIT_THEMES=''
SYSDEN64_OMZ_GIT_THEMES+=' https://github.com/romkatv/powerlevel10k.git'

function module_omz_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local module_type="$SYSDEN64_MODULE_TYPE_SHARED"
  local model='omz'
  local source=''

  [[ -z "$(bl64_bsh_command_locate 'zsh')" ]] &&
    bl64_dbg_app_show_info "$SYSDEN64_TXT_NOT_DETECTED" && return 0
  bl64_msg_show_phase 'prepare Oh-My-ZSH'

  source="$(module_set_model "$module_type" "$model")" &&
    module_setup_env "$home" "$source" ||
    return $?

  bl64_dbg_app_show_info 'avoid installation when synchronizing config'
  if ! bl64_lib_flag_is_enabled "$SYSDEN64_ACTION_SYNC"; then
    module_omz_setup_main "$home" &&
      module_omz_setup_plugins "$home"
  fi
}

function module_omz_setup_main() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local omz_path="${home}/${SYSDEN64_OMZ_GIT_LOCAL}"

  bl64_msg_show_task "deploy Oh-My-ZSH (${omz_path})"
  bl64_fs_path_remove "$omz_path" &&
    bl64_vcs_git_clone \
      "$SYSDEN64_OMZ_GIT" \
      "$home" \
      'master' \
      "$SYSDEN64_OMZ_GIT_LOCAL" ||
    return $?
}

function module_omz_setup_plugins() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local omz_custom_path="${home}/${SYSDEN64_OMZ_GIT_LOCAL}/custom"
  local omz_custom_plugins_path="${omz_custom_path}/plugins"
  local omz_custom_themes_path="${omz_custom_path}/themes"
  local plugin=''

  bl64_msg_show_task "deploy plugins (${omz_custom_plugins_path})"
  for plugin in $SYSDEN64_OMZ_GIT_PLUGINS; do
    bl64_vcs_git_clone \
      "$plugin" \
      "$omz_custom_plugins_path" ||
      return $?
  done

  bl64_msg_show_task "deploy themes (${omz_custom_themes_path})"
  [[ -d "$omz_custom_themes_path" ]] && bl64_fs_path_remove "$omz_custom_themes_path"
  for plugin in $SYSDEN64_OMZ_GIT_THEMES; do
    bl64_vcs_git_clone \
      "$plugin" \
      "$omz_custom_themes_path" ||
      return $?
  done
}
