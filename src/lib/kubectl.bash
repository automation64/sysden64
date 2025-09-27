# version: 3.0.1
# template: lib-dedicated-1.0.0
function module_kubectl_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local module_type="$SYSDEN64_MODULE_TYPE_DEDICATED"
  local model='kubectl'
  local source=''

  [[ -z "$(bl64_bsh_command_locate 'kubectl')" ]] &&
    bl64_dbg_app_show_info "$SYSDEN64_TXT_NOT_DETECTED" && return 0
  bl64_msg_show_phase 'prepare KubeCTL'

  source="$(module_set_model "$module_type" "$model")" &&
    module_setup_env "$home" "$source" "$module_type" "$model" &&
    module_kubectl_setup_config "$home" "$source" "$model" "$module_type"
}

function module_kubectl_setup_config() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local source="$2"
  local model="$3"
  local module_type="$4"
  local base="${home}"
  local config='.kube'
  local target="${base}/${config}"

  module_dedicated_setup_config "$source" "$model" "$module_type" "$base" "$config" "$target" 
}
