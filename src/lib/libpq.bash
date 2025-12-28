# version: 1.0.1
# template: lib-env-1.0.0
function module_libpq_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local module_type="$SYSDEN64_MODULE_TYPE_SHARED"
  local model='libpq'
  local source=''
  local extra_locations=''

  if [[ "$BL64_OS_TYPE" == "$BL64_OS_TYPE_MACOS" ]]; then
    extra_locations='/opt/homebrew/opt/libpq/bin'
  else
    bl64_dbg_app_show_comments 'the tool is only supported on macOS.'
    return 0
  fi
  module_detect "$model" 'psql' 'PostgreSQL LibPQ' "$extra_locations" || return 0

  source="$(module_set_model "$module_type" "$model")" &&
    module_setup_env "$home" "$source"
}
