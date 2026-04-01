# version: 1.0.1
# template: lib-env-1.0.0
function module_homebrew_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local module_type="$SYSDEN64_MODULE_TYPE_SHARED"
  local module='homebrew'
  local source=''
  local extra_locations='/opt/homebrew/bin /home/linuxbrew/.linuxbrew/bin'

  module_detect "$module" 'brew' 'HomeBrew - Package Manager' "$extra_locations" || return 0

  source="$(module_config_get_source "$module_type" "$module")" &&
    module_setup_env "$home" "$source" "$module_type" "$module"
}
