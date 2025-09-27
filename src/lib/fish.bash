# version: 1.0.2
# template: lib-config-1.0.0
function module_fish_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local module_type="$SYSDEN64_MODULE_TYPE_SHARED"
  local model='fish'
  local source=''

  [[ -z "$(bl64_bsh_command_locate 'fish')" ]] &&
    bl64_dbg_app_show_info "$SYSDEN64_TXT_NOT_DETECTED" && return 0
  bl64_msg_show_phase 'prepare Fish'

  source="$(module_set_model "$module_type" "$model")" &&
    module_fish_setup_config "$home" "$source" "$model" "$module_type"
}

function module_fish_setup_config() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local source="$2"
  local model="$3"
  local module_type="$4"
  local base="${home}/.config"
  local config='.config/fish'
  local target="${home}/${config}"

  module_shared_setup_config "$source" "$model" "$module_type" "$base" "$config" "$target" "${source}/${config}"
}
