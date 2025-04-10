# Version: 1.0.0
function module_xdg_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local module_type="$SYSDEN64_MODULE_TYPE_SHARED"
  local model='xdg'
  local source=''

  bl64_msg_show_task 'prepare XDG'
  bl64_bsh_xdg_create \
    "$home" ||
    return $?

  source="$(module_set_model "$module_type" "$model")" &&
    module_setup_env "$home" "$source"
}
