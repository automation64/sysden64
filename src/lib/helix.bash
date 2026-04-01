# version: 1.0.3
# template: lib-config-1.0.0
function module_helix_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local module_type="$SYSDEN64_MODULE_TYPE_SHARED"
  local module='helix'
  local source=''

  module_detect "$module" 'hx' 'Helix Text Editor' || return 0

  source="$(module_config_get_source "$module_type" "$module")" &&
    module_helix_setup_config "$home" "$source" "$module" "$module_type"
}

function module_helix_setup_config() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local source="$2"
  local module="$3"
  local module_type="$4"
  local base="${home}/.config/helix"
  local config='.config/helix'
  local config_file='config.toml'
  local target="${home}/${config}/${config_file}"

  module_shared_setup_config "$source" "$module" "$module_type" "$base" "$config" "$target" "${source}/${config}/${config_file}"
}
