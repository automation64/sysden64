# version: 3.0.0
# template: lib-env-1.0.0

function module_omz_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local module_type="$SYSDEN64_MODULE_TYPE_SHARED"
  local model='omz'
  local source=''
  local extra_locations="${HOME}/.oh-my-zsh"

  [[ -r "$extra_locations" ]] &&
    module_detect "$model" 'zsh' 'Oh-My-ZSH' || return 0

  source="$(module_set_model "$module_type" "$model")" &&
    module_setup_env "$home" "$source" ||
    return $?
}
