# version: 1.2.0
# template: lib-config-1.0.0
function module_starship_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local module_type="$SYSDEN64_MODULE_TYPE_SHARED"
  local model='starship'
  local source=''

  [[ -z "$(bl64_bsh_command_locate 'starship')" || -z "$(bl64_bsh_command_locate 'bash')" ]] &&
    bl64_dbg_app_show_info "$SYSDEN64_TXT_NOT_DETECTED" && return 0
  bl64_msg_show_phase 'prepare Starship'

  source="$(module_set_model "$module_type" "$model")" &&
    module_setup_env "$home" "$source" &&
    module_starship_setup_config "$home" "$source" "$model" "$module_type"
}

function module_starship_setup_config() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local source="$2"
  local model="$3"
  local module_type="$4"
  local base="$home"
  local config='.config/starship.toml'
  local target="${base}/${config}"

  module_config_backup "$model" "$module_type" "$target" ||
    return $?

  bl64_msg_show_task "promote configuration from model (${model}/${config})"
  bl64_fs_path_copy \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "${base}/.config" \
    "${source}/${config}"
}
