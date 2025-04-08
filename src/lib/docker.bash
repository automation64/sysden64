# Version: 2.0.0
function module_docker_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local module_type="$SYSDEN64_MODULE_TYPE_DEDICATED"
  local model='docker'
  local source=''
  local config='.docker'
  local target="${home}/${config}"
  local vault="${DEV_PATH_PROF_VAULT}/${model}"

  [[ -z "$(bl64_bsh_command_locate 'docker')" ]] &&
    bl64_dbg_app_show_info "$SYSDEN64_TXT_NOT_DETECTED" && return 0
  bl64_msg_show_phase 'prepare Docker CLI'

  source="$(module_set_model "$module_type" "$model")" ||
    return $?

  if module_sync_is_requested "$module_type" "$vault"; then
    bl64_msg_show_task "setup environment variables (${home}/${SYSDEN64_PATH_SHELLENV})"
    bl64_fs_path_copy \
      "$BL64_VAR_DEFAULT" \
      "$BL64_VAR_DEFAULT" \
      "$BL64_VAR_DEFAULT" \
      "$BL64_VAR_DEFAULT" \
      "${home}/${SYSDEN64_PATH_SHELLENV}" \
      "${source}/${SYSDEN64_PATH_SHELLENV}"/*.env ||
      return $?
  fi
  bl64_lib_flag_is_enabled "$SYSDEN64_ACTION_SYNC" && return 0

  module_config_backup "$model" "$target" || return $?
  bl64_msg_show_task "setup Docker CLI (${target})"
  if bl64_lib_flag_is_enabled "$SYSDEN64_FLAG_USER_WIDE"; then
    if [[ ! -d "$vault" ]]; then
      bl64_fs_dir_create "$BL64_VAR_DEFAULT" "$BL64_VAR_DEFAULT" "$BL64_VAR_DEFAULT" \
        "$vault" &&
        module_docker_setup_promote "$model" "$source" "$config" "$vault" ||
        return $?
    fi
    bl64_fs_symlink_create "$vault" "$target" "$BL64_VAR_ON"
  else
    bl64_fs_dir_create "$BL64_VAR_DEFAULT" "$BL64_VAR_DEFAULT" "$BL64_VAR_DEFAULT" \
      "$target" &&
      module_docker_setup_promote "$model" "$source" "$config" "$vault"
  fi
}

function module_docker_setup_promote() {
  bl64_dbg_app_show_function "$@"
  local model="$1"
  local source="$2"
  local config="$3"
  local target="$4"
  bl64_msg_show_task "promote configuration from model (${model}/${config})"
  bl64_fs_path_copy \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$target" \
    "${source}/${config}/config.json"
}
