# version: 1.0.1
# template: lib-env-1.0.0
function module_openssl_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local module_type="$SYSDEN64_MODULE_TYPE_SHARED"
  local model='openssl'
  local source=''

  if [[ "$BL64_OS_TYPE" != "$BL64_OS_TYPE_MACOS" ]]; then
    bl64_dbg_app_show_comments 'the tool is only supported on macOS.'
    return 0
  fi
  module_detect "$model" 'openssl' 'OpenSSL' || return 0

  source="$(module_set_model "$module_type" "$model")" &&
    module_setup_env "$home" "$source"
}
