# Version: 1.0.1
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
  local local_repo='.oh-my-zsh'
  local profile="${home}/.zshrc"
  local model='oh-my-zsh'
  local omz_path="${home}/${local_repo}"

  bl64_lib_flag_is_enabled "$SYSDEN64_FLAG_PROFILE_SWITCH" && return 0

  ! bl64_bsh_command_is_executable 'zsh' &&
    bl64_dbg_app_show_info "$SYSDEN64_TXT_NOT_DETECTED" && return 0
  bl64_msg_show_phase 'prepare Oh-My-ZSH'

  module_create_shared "$model" || return $?
  model="$(module_set_model "$model")"

  if ! bl64_lib_flag_is_enabled "$SYSDEN64_FLAG_MODULE_UPGRADE"; then
    if [[ -d "$omz_path" ]]; then
      module_omz_setup_zsh "$profile" "$omz_path" "$model" || return $?
      return 0
    fi
  fi
  config_backup "$omz_path" &&
  module_omz_setup_main "$home" "$local_repo" &&
  module_omz_setup_plugins "$home" "$local_repo" &&
  module_omz_setup_zsh "$profile" "$omz_path" "$model"
}

function module_omz_setup_zsh() {
  bl64_dbg_app_show_function "$@"
  local profile="$1"
  local omz_path="$2"
  local model="$3"
  bl64_msg_show_task "enable Oh-My-ZSH (${profile})"
  bl64_check_directory "$omz_path" || return $?
  if ! bl64_txt_run_egrep "$BL64_TXT_SET_GREP_QUIET" '/oh-my-zsh.sh' "$profile"; then
    "$BL64_OS_CMD_CAT" \
      "${model}/oh-my-zsh.snippet" >>"$profile" ||
      return $?
  fi
}

function module_omz_setup_main() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local local_repo="$2"

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
