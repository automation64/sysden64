# version: 1.0.2
# template: lib-env-1.0.1
function module_openssl_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local module_type="$SYSDEN64_MODULE_TYPE_SHARED"
  local module_name='openssl'
  local module_etc=''

  if [[ "$BL64_OS_TYPE" != "$BL64_OS_TYPE_MACOS" ]]; then
    bl64_dbg_app_show_comments 'the tool is only supported on macOS.'
    return 0
  fi
  module_detect "$module_name" 'openssl' 'OpenSSL - Cryptography Toolkit' || return 0

  module_etc="$(module_config_get_source "$module_type" "$module_name")" &&
    module_setup_env "$home" "$module_etc" "$module_type" "$module_name"
}
