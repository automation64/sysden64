# version: 3.0.2
# template: lib-env-1.0.1

function module_omz_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local module_type="$SYSDEN64_MODULE_TYPE_SHARED"
  local module_name='omz'
  local module_etc=''
  local extra_locations="${HOME}/.oh-my-zsh"
  local plugins="${extra_locations}/custom/plugins"

  [[ -d "$extra_locations" ]] &&
    [[ -d "${plugins}/fzf-tab" ]] &&
    [[ -d "${plugins}/zsh-autosuggestions" ]] &&
    [[ -d "${plugins}/zsh-syntax-highlighting" ]] &&
    module_detect "$module_name" 'zsh' 'Oh-My-ZSH - Zsh Framework' || return 0

  module_etc="$(module_config_get_source "$module_type" "$module_name")" &&
    module_setup_env "$home" "$module_etc" "$module_type" "$module_name"
}
