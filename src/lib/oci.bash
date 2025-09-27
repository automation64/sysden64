# template: lib-dedicated-1.0.0
# version: 1.1.0
function module_oci_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local module_type="$SYSDEN64_MODULE_TYPE_DEDICATED"
  local model='oci'
  local source=''
  local extra_locations="${HOME}/.local/bin"

  [[ -z "$(bl64_bsh_command_locate 'oci' "$extra_locations")" ]] &&
    bl64_dbg_app_show_info "$SYSDEN64_TXT_NOT_DETECTED" && return 0
  bl64_msg_show_phase 'prepare OCI CLI'

  source="$(module_set_model "$module_type" "$model")" &&
    module_oci_setup_config "$home" "$source" "$model" "$module_type"
}

function module_oci_setup_config() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local source="$2"
  local model="$3"
  local module_type="$4"
  local base="${home}"
  local config='.oci'
  local target="${base}/${config}"

  module_dedicated_setup_config "$source" "$model" "$module_type" "$base" "$config" "$target" 
}
