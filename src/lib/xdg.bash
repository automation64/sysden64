# Version: 1.0.0
function module_xdg_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"

  bl64_msg_show_task 'prepare XDG'
  bl64_bsh_xdg_create \
    "$home"
}
