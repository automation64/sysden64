# version: 1.2.2
# template: lib-config-1.0.0
function module_starship_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local module_type="$SYSDEN64_MODULE_TYPE_SHARED"
  local module='starship'
  local source=''

  module_detect "$module" 'starship' 'Starship - Shell Prompt Manager' || return 0

  source="$(module_config_get_source "$module_type" "$module")" &&
    module_setup_env "$home" "$source" "$module_type" "$module" &&
    module_starship_setup_config "$home" "$source" "$module" "$module_type"
}

function module_starship_setup_config() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local source="$2"
  local module="$3"
  local module_type="$4"
  local base="${home}/.config"
  local config='.config/starship.toml'
  local target="${home}/${config}"

  module_shared_setup_config "$source" "$module" "$module_type" "$base" "$config" "$target" "${source}/${config}"
}
