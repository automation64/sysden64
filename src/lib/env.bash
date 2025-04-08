# Version: 1.1.2
function module_env_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local module_type="$SYSDEN64_MODULE_TYPE_SHARED"
  local model='env'
  local source=''
  local config='.env.d'
  local target="${home}/${config}"

  bl64_msg_show_phase 'prepare shell env repository'

  source="$(module_set_model "$module_type" "$model")" ||
    return $?

  module_config_backup "$model" "$target" &&
    module_env_setup_env "$home" "$source"
}

function module_env_setup_env() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local source="$2"

  bl64_msg_show_task "setup environment variables (${home}/${SYSDEN64_PATH_SHELLENV})"
  bl64_fs_path_copy \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$home" \
    "${source}/${SYSDEN64_PATH_SHELLENV}"
}
