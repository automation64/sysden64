# version: 1.0.1
# template: lib-env-1.0.0
function module_cursor_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local module_type="$SYSDEN64_MODULE_TYPE_SHARED"
  local model='cursor'
  local source=''
  local extra_locations='/Applications/Cursor.app/Contents/MacOS'

  module_detect "$model" 'Cursor' 'Cursor IDE' "$extra_locations" || return 0

  source="$(module_set_model "$module_type" "$model")" &&
    module_setup_env "$home" "$source"
}
