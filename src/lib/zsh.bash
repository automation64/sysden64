# version: 2.0.2
# template: lib-config-1.0.0
function module_zsh_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local module_type="$SYSDEN64_MODULE_TYPE_SHARED"
  local module='zsh'
  local source=''

  module_detect "$module" 'zsh' 'ZSH' || return 0

  source="$(module_config_get_source "$module_type" "$module")" &&
    module_zsh_setup_config "$home" "$source" "$module" "$module_type"
}

function module_zsh_setup_config() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local source="$2"
  local module="$3"
  local module_type="$4"
  local base="${home}"
  local config_env='.zshenv'
  local config_rc='.zshrc'
  local target_env="${base}/${config_env}"
  local target_rc="${base}/${config_rc}"

  module_config_backup "$module" "$module_type" "$target_env" "$target_rc" ||
    return $?

  bl64_msg_show_subtask "${SYSDEN64_TXT_PROMOTE_SHARED} (${module})"
  bl64_fs_path_copy \
    '0700' \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$base" \
    "${source}/${config_env}" \
    "${source}/${BL64_OS_TYPE}/${config_rc}"
}
