# version: 1.0.0
# template: lib-env-1.0.0
function module_homebrew_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local module_type="$SYSDEN64_MODULE_TYPE_SHARED"
  local model='homebrew'
  local source=''
  local extra_locations='/opt/homebrew/bin /home/linuxbrew/.linuxbrew/bin'

  module_detect "$model" 'brew' 'HomeBrew' "$extra_locations" || return 0

  source="$(module_set_model "$module_type" "$model")" &&
    module_setup_env "$home" "$source"
}
