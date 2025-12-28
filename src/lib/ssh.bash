# version: 3.0.1
# template: lib-dedicated-1.0.0
function module_ssh_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local module_type="$SYSDEN64_MODULE_TYPE_DEDICATED"
  local model='ssh'
  local source=''

  module_detect "$model" 'ssh' 'OpenSSH' || return 0

  source="$(module_set_model "$module_type" "$model")" &&
    module_ssh_setup_config "$home" "$source" "$model" "$module_type"
}

function module_ssh_setup_config() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local source="$2"
  local model="$3"
  local module_type="$4"
  local base="${home}"
  local config='.ssh'
  local target="${base}/${config}"

  module_dedicated_setup_config "$source" "$model" "$module_type" "$base" "$config" "$target" 
}
