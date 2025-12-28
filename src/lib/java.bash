# version: 1.0.1
# template: lib-env-1.0.0
function module_java_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local module_type="$SYSDEN64_MODULE_TYPE_SHARED"
  local model='java'
  local extra_locations=''

  if [[ "$BL64_OS_TYPE" == "$BL64_OS_TYPE_MACOS" ]]; then
      extra_locations+=' /opt/homebrew/opt/openjdk/bin'
      extra_locations+=' /opt/homebrew/opt/openjdk@8/bin'
      extra_locations+=' /opt/homebrew/opt/openjdk@11/bin'
      extra_locations+=' /opt/homebrew/opt/openjdk@17/bin'
      extra_locations+=' /opt/homebrew/opt/openjdk@21/bin'
  fi

  module_detect "$model" 'java' 'Java JDK' "$extra_locations"|| return 0

  source="$(module_set_model "$module_type" "$model")" &&
    module_setup_env "$home" "$source"
}
