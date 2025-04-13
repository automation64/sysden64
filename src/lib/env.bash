# Version: 1.2.0
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
    module_env_setup_config "$home" "$source" "$model" &&
    module_setup_env "$home" "$source"
}

function module_env_setup_config() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local source="$2"
  local model="$3"
  local target_base="${home}"
  local config='.env.d'
  local target="${target_base}/${config}"

  module_config_backup "$model" "$target" ||
    return $?

  bl64_msg_show_task "promote configuration from model (${model}/${config})"
  # shellcheck disable=SC2086
  bl64_fs_dir_create \
    "$BL64_VAR_DEFAULT" "$BL64_VAR_DEFAULT" "$BL64_VAR_DEFAULT" \
    "$target"
}
