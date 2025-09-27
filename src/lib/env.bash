# version: 1.3.0
# template: lib-config-1.0.0
function module_env_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local module_type="$SYSDEN64_MODULE_TYPE_SHARED"
  local model='env'
  local source=''

  bl64_msg_show_phase 'prepare shell env repository'

  source="$(module_set_model "$module_type" "$model")" &&
    module_env_setup_config "$home" "$source" "$model" "$module_type"
}

function module_env_setup_config() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local source="$2"
  local model="$3"
  local module_type="$4"
  local base="${home}"
  local config='.env.d'
  local target="${base}/${config}"

  module_config_backup "$model" "$module_type" "$target" ||
    return $?

  bl64_msg_show_task "${SYSDEN64_TXT_PROMOTE_SHARED} (${model}/${config})"
  # shellcheck disable=SC2086
  bl64_fs_dir_create \
    "$BL64_VAR_DEFAULT" "$BL64_VAR_DEFAULT" "$BL64_VAR_DEFAULT" \
    "$target" &&
    module_setup_env "$home" "$source"
}
