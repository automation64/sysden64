# version: 1.0.2
# template: lib-env-1.0.1
function module_java_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local module_type="$SYSDEN64_MODULE_TYPE_SHARED"
  local module_name='java'
  local module_etc=''
  local extra_locations=''

  if [[ "$BL64_OS_TYPE" == "$BL64_OS_TYPE_MACOS" ]]; then
    extra_locations+=' /opt/homebrew/opt/openjdk/bin'
    extra_locations+=' /opt/homebrew/opt/openjdk@8/bin'
    extra_locations+=' /opt/homebrew/opt/openjdk@11/bin'
    extra_locations+=' /opt/homebrew/opt/openjdk@17/bin'
    extra_locations+=' /opt/homebrew/opt/openjdk@21/bin'
  fi

  module_detect "$module_name" 'java' 'Java JDK' "$extra_locations" || return 0

  module_etc="$(module_config_get_source "$module_type" "$module_name")" &&
    module_setup_env "$home" "$module_etc" "$module_type" "$module_name"
}
