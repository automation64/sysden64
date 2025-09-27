# version: 2.0.1
# template: lib-config-1.0.0
function module_zsh_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local module_type="$SYSDEN64_MODULE_TYPE_SHARED"
  local model='zsh'
  local source=''

  [[ -z "$(bl64_bsh_command_locate 'zsh')" ]] &&
    bl64_dbg_app_show_info "$SYSDEN64_TXT_NOT_DETECTED" && return 0
  bl64_msg_show_phase 'prepare ZSH'

  source="$(module_set_model "$module_type" "$model")" &&
    module_zsh_setup_config "$home" "$source" "$model" "$module_type"
}

function module_zsh_setup_config() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local source="$2"
  local model="$3"
  local module_type="$4"
  local base="${home}"
  local config_env='.zshenv'
  local config_rc='.zshrc'
  local target_env="${base}/${config_env}"
  local target_rc="${base}/${config_rc}"

  module_config_backup "$model" "$module_type" "$target_env" "$target_rc" ||
    return $?

  bl64_msg_show_task "${SYSDEN64_TXT_PROMOTE_SHARED} (${model}/)"
  bl64_fs_path_copy \
    '0700' \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$base" \
    "${source}/${config_env}" \
    "${source}/${BL64_OS_TYPE}/${config_rc}"
}
