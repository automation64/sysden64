# version: 1.0.2
# template: lib-env-1.0.0
function module_openssl_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local module_type="$SYSDEN64_MODULE_TYPE_SHARED"
  local module='openssl'
  local source=''

  if [[ "$BL64_OS_TYPE" != "$BL64_OS_TYPE_MACOS" ]]; then
    bl64_dbg_app_show_comments 'the tool is only supported on macOS.'
    return 0
  fi
  module_detect "$module" 'openssl' 'OpenSSL - Cryptography Toolkit' || return 0

  source="$(module_config_get_source "$module_type" "$module")" &&
    module_setup_env "$home" "$source" "$module_type" "$module"
}
