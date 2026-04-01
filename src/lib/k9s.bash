# version: 1.0.2
# template: lib-config-1.0.0
function module_k9s_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local module_type="$SYSDEN64_MODULE_TYPE_SHARED"
  local module='k9s'
  local source=''

  module_detect "$module" 'k9s' 'K9S - Kubernetes TUI' || return 0

  source="$(module_config_get_source "$module_type" "$module")" &&
    module_k9s_setup_config "$home" "$source" "$module" "$module_type"
}

function module_k9s_setup_config() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local source="$2"
  local module="$3"
  local module_type="$4"
  local config='.config/k9s'
  local config_file='config.yaml'
  local target=''

  if [[ "$BL64_OS_TYPE" == "$BL64_OS_TYPE_MACOS" ]]; then
    base="${home}/Library/Application Support/k9s"
  elif [[ "$BL64_OS_TYPE" == "$BL64_OS_TYPE_LINUX" ]]; then
    base="${home}/.config/k9s"
  fi
  target="${base}/${config}"

  module_shared_setup_config "$source" "$module" "$module_type" "$base" "$config" "$target" "${source}/${config}/${config_file}"
}
