# Version: 2.0.0
declare SYSDEN64_GIT_OMZ='https://github.com/ohmyzsh/ohmyzsh.git'
declare SYSDEN64_GIT_OMZ_PLUGINS=''
SYSDEN64_GIT_OMZ_PLUGINS+=' https://github.com/marlonrichert/zsh-autocomplete.git'
SYSDEN64_GIT_OMZ_PLUGINS+=' https://github.com/zsh-users/zsh-autosuggestions.git'
SYSDEN64_GIT_OMZ_PLUGINS+=' https://github.com/zsh-users/zsh-syntax-highlighting.git'
SYSDEN64_GIT_OMZ_PLUGINS+=' https://github.com/zsh-users/zsh-completions.git'
SYSDEN64_GIT_OMZ_PLUGINS+=' https://github.com/Aloxaf/fzf-tab.git'
SYSDEN64_GIT_OMZ_PLUGINS+=' https://github.com/joshskidmore/zsh-fzf-history-search.git'
declare SYSDEN64_GIT_OMZ_THEMES=''
SYSDEN64_GIT_OMZ_THEMES+=' https://github.com/romkatv/powerlevel10k.git'

function module_omz_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local module_type="$SYSDEN64_MODULE_TYPE_SHARED"
  local model='omz'
  local source=''
  local config='.oh-my-zsh'
  local target="${home}/${config}"
  local local_repo='.oh-my-zsh'
  local omz_path="${home}/${local_repo}"

  [[ -z "$(bl64_bsh_command_locate 'zsh')" ]] &&
    bl64_dbg_app_show_info "$SYSDEN64_TXT_NOT_DETECTED" && return 0
  bl64_msg_show_phase 'prepare Oh-My-ZSH'

  source="$(module_set_model "$module_type" "$model")" ||
    return $?

  bl64_msg_show_task "setup environment variables (${home}/${SYSDEN64_PATH_SHELLENV})"
  bl64_fs_path_copy \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "${home}/${SYSDEN64_PATH_SHELLENV}" \
    "${source}/${SYSDEN64_PATH_SHELLENV}"/*.{env,zsh} ||
    return $?

  bl64_dbg_app_show_info 'avoid installation when synchronizing config' 
  if ! bl64_lib_flag_is_enabled "$SYSDEN64_ACTION_SYNC"; then
    module_omz_setup_main "$home" "$local_repo" "$omz_path" &&
      module_omz_setup_plugins "$home" "$local_repo"
  fi
}

function module_omz_setup_main() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local local_repo="$2"
  local omz_path="$3"

  bl64_msg_show_task "deploy Oh-My-ZSH (${omz_path})"
  bl64_fs_path_remove "$omz_path" &&
    bl64_vcs_git_clone \
      "$SYSDEN64_GIT_OMZ" \
      "$home" \
      'master' \
      "$local_repo" ||
    return $?
}

function module_omz_setup_plugins() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local local_repo="$2"
  local omz_custom_path="${home}/${local_repo}/custom"
  local omz_custom_plugins_path="${omz_custom_path}/plugins"
  local omz_custom_themes_path="${omz_custom_path}/themes"
  local plugin=''

  bl64_msg_show_task "deploy plugins (${omz_custom_plugins_path})"
  for plugin in $SYSDEN64_GIT_OMZ_PLUGINS; do
    bl64_vcs_git_clone \
      "$plugin" \
      "$omz_custom_plugins_path" ||
      return $?
  done

  bl64_msg_show_task "deploy themes (${omz_custom_themes_path})"
  [[ -d "$omz_custom_themes_path" ]] && bl64_fs_path_remove "$omz_custom_themes_path"
  for plugin in $SYSDEN64_GIT_OMZ_THEMES; do
    bl64_vcs_git_clone \
      "$plugin" \
      "$omz_custom_themes_path" ||
      return $?
  done
}
