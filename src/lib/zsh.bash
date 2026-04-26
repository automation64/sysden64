# version: 2.0.2
# template: lib-config-2.0.0
function module_zsh_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local module_type="$SYSDEN64_MODULE_TYPE_SHARED"
  local module_name='zsh'
  local module_etc=''

  module_detect "$module_name" 'zsh' 'ZSH' || return 0

  module_etc="$(module_config_get_source "$module_type" "$module_name")" &&
    module_zsh_setup_config "$home" "$module_etc" "$module_name" "$module_type"
}

function module_zsh_setup_config() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local module_etc="$2"
  local module_name="$3"
  local module_type="$4"
  local config_destination="${home}"
  local config_env='.zshenv'
  local config_rc='.zshrc'
  local target_env="${config_destination}/${config_env}"
  local target_rc="${config_destination}/${config_rc}"

  module_config_backup "$module_name" "$module_type" "$target_env" "$target_rc" ||
    return $?

  bl64_msg_show_subtask "${SYSDEN64_TXT_PROMOTE_SHARED} (${module_name})"
  bl64_fs_path_copy \
    '0700' \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$config_destination" \
    "${module_etc}/${config_env}" \
    "${module_etc}/${BL64_OS_TYPE}/${config_rc}"
}
