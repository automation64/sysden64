# version: 1.3.1
# template: lib-config-1.0.0
function module_env_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local module_type="$SYSDEN64_MODULE_TYPE_SHARED"
  local module='env'
  local source=''

  bl64_msg_show_subtask "${SYSDEN64_TXT_CONFIGURE_MODULE}: ENV"

  source="$(module_config_get_source "$module_type" "$module")" &&
    module_env_setup_config "$home" "$source" "$module" "$module_type"
}

function module_env_setup_config() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local source="$2"
  local module="$3"
  local module_type="$4"
  local base="${home}"
  local config='.env.d'
  local target="${base}/${config}"

  module_config_backup "$module" "$module_type" "$target" ||
    return $?

  bl64_msg_show_subtask "${SYSDEN64_TXT_PROMOTE_SHARED} (${module}/${config})"
  # shellcheck disable=SC2086
  bl64_fs_dir_create \
    "$BL64_VAR_DEFAULT" "$BL64_VAR_DEFAULT" "$BL64_VAR_DEFAULT" \
    "$target" &&
    module_setup_env "$home" "$source" "$module_type" "$module"
}
