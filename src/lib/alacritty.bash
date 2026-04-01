# version: 2.0.2
# template: lib-config-1.0.0
function module_alacritty_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local module_type="$SYSDEN64_MODULE_TYPE_SHARED"
  local module='alacritty'
  local source=''

  module_detect "$module" 'alacritty' 'Alacritty - Terminal Emulator' || return 0

  source="$(module_config_get_source "$module_type" "$module")" &&
    module_alacritty_setup_config "$home" "$source" "$module" "$module_type"
}

function module_alacritty_setup_config() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local source="$2"
  local module="$3"
  local module_type="$4"
  local base="${home}"
  local config='.alacritty.toml'
  local config_legacy='.alacritty.yml'
  local target="${base}/${config}"
  local target_legacy="${base}/${config_legacy}"

  module_shared_setup_config "$source" "$module" "$module_type" "$base" "$config" "$target" "${source}/${config}" \
    "$target_legacy"
}
