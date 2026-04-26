# version: 1.0.3
# template: lib-config_destination-1.0.1
function module_xdg_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local module_type="$SYSDEN64_MODULE_TYPE_SHARED"
  local module_name='xdg'
  local module_etc=''

  bl64_msg_show_subtask "${SYSDEN64_TXT_CONFIGURE_MODULE}: XDG"

  bl64_bsh_xdg_create "$home" ||
    return $?

  module_etc="$(module_config_get_source "$module_type" "$module_name")" &&
    module_setup_env "$home" "$module_etc" "$module_type" "$module_name"
}
