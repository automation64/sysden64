# version: 1.0.0
# template: lib-env-1.0.0
function module_java_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local module_type="$SYSDEN64_MODULE_TYPE_SHARED"
  local model='java'
  local source=''

  [[ "$BL64_OS_TYPE" != "$BL64_OS_TYPE_MACOS" ]] &&
    [[ ! -d '/opt/homebrew/opt/openjdk' &&
      ! -d '/opt/homebrew/opt/openjdk@8' &&
      ! -d '/opt/homebrew/opt/openjdk@11' &&
      ! -d '/opt/homebrew/opt/openjdk@17' &&
      ! -d '/opt/homebrew/opt/openjdk@21' ]] &&
    bl64_dbg_app_show_info "$SYSDEN64_TXT_NOT_DETECTED" && return 0
  bl64_msg_show_phase 'prepare Java JDK'

  source="$(module_set_model "$module_type" "$model")" &&
    module_setup_env "$home" "$source"
}
