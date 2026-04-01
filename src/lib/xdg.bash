# version: 1.0.3
# template: lib-base-1.0.0
function module_xdg_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local module_type="$SYSDEN64_MODULE_TYPE_SHARED"
  local module='xdg'
  local source=''

  bl64_msg_show_subtask "${SYSDEN64_TXT_CONFIGURE_MODULE}: XDG"

  bl64_bsh_xdg_create "$home" ||
    return $?

  source="$(module_config_get_source "$module_type" "$module")" &&
    module_setup_env "$home" "$source" "$module_type" "$module"
}
