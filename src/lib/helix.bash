# version: 1.0.2
# template: lib-config-1.0.0
function module_helix_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local module_type="$SYSDEN64_MODULE_TYPE_SHARED"
  local model='helix'
  local source=''

  module_detect "$model" 'hx' 'Helix Editor' || return 0

  source="$(module_set_model "$module_type" "$model")" &&
    module_helix_setup_config "$home" "$source" "$model" "$module_type"
}

function module_helix_setup_config() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local source="$2"
  local model="$3"
  local module_type="$4"
  local base="${home}/.config/helix"
  local config='.config/helix'
  local config_file='config.toml'
  local target="${home}/${config}/${config_file}"

  module_shared_setup_config "$source" "$model" "$module_type" "$base" "$config" "$target" "${source}/${config}/${config_file}"
}
