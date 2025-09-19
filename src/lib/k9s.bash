# template: lib-config-1.0.0
# version: 1.0.0
function module_k9s_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local module_type="$SYSDEN64_MODULE_TYPE_SHARED"
  local model='k9s'
  local source=''

  [[ -z "$(bl64_bsh_command_locate 'k9s')" ]] &&
    bl64_dbg_app_show_info "$SYSDEN64_TXT_NOT_DETECTED" && return 0
  bl64_msg_show_phase 'prepare K9S'

  source="$(module_set_model "$module_type" "$model")" &&
    module_k9s_setup_config "$home" "$source" "$model" "$module_type"
}

function module_k9s_setup_config() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local source="$2"
  local model="$3"
  local module_type="$4"
  local config='.config/k9s'
  local config_file='config.yaml'
  local target=''

  if [[ "$BL64_OS_TYPE" == "$BL64_OS_TYPE_MACOS" ]]; then
    base="${home}/Library/Application Support/k9s"
  elif [[ "$BL64_OS_TYPE" == "$BL64_OS_TYPE_LINUX" ]]; then
    base="${home}/.config/k9s"
  fi
  target="${base}/${config}"

  module_config_backup "$model" "$module_type" "$target" ||
    return $?

  bl64_msg_show_task "promote configuration from model (${model}/${config})"
  bl64_fs_dir_create \
    "$BL64_VAR_DEFAULT" "$BL64_VAR_DEFAULT" "$BL64_VAR_DEFAULT" \
    "$base" &&
  bl64_fs_path_copy \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$base" \
    "${source}/${config}/${config_file}"
}
