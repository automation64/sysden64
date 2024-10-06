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

function sysden64_omz_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local omz_path="${home}/.oh-my-zsh"
  local profile="${home}/.zshrc"
  local model="${SYSDEN64_PATH_ETC}/oh-my-zsh"
  local local_repo='.oh-my-zsh'

  bl64_msg_show_phase 'prepare Oh-My-ZSH'
  ! bl64_bsh_command_is_executable 'zsh' &&
    bl64_msg_show_warning "$SYSDEN64_TXT_NOT_DETECTED" && return 0

  bl64_msg_show_task "enable Oh-My-ZSH (${profile})"
  if ! bl64_txt_run_egrep "$BL64_TXT_SET_GREP_QUIET" '/oh-my-zsh.sh' "$profile"; then
    "$BL64_OS_CMD_CAT" \
      "${model}/oh-my-zsh.snippet" >>"$profile"
  fi

  [[ -d "$omz_path" ]] && return 0
  bl64_msg_show_task "download Oh-My-ZSH (${omz_path})"
  bl64_vcs_git_clone \
    "$SYSDEN64_GIT_OMZ" \
    "$home" \
    'master' \
    "$local_repo" ||
    return $?

  sysden64_omz_setup_plugins "$home" "$local_repo"
}

function sysden64_omz_setup_plugins() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local local_repo="$2"
  local omz_custom_path="${home}/${local_repo}/custom"
  local omz_custom_plugins_path="${omz_custom_path}/plugins"
  local omz_custom_themes_path="${omz_custom_path}/themes"

  bl64_msg_show_task "download plugins (${omz_custom_plugins_path})"
  for plugin in $SYSDEN64_GIT_OMZ_PLUGINS; do
    bl64_vcs_git_clone \
      "$plugin" \
      "$omz_custom_plugins_path" ||
      return $?
  done

  bl64_msg_show_task "download themes (${omz_custom_themes_path})"
  [[ -d "$omz_custom_themes_path" ]] && bl64_fs_rm_full "$omz_custom_themes_path"
  for plugin in $SYSDEN64_GIT_OMZ_THEMES; do
    bl64_vcs_git_clone \
      "$plugin" \
      "$omz_custom_themes_path" ||
      return $?
  done
}
