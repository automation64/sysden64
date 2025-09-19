# version: 3.0.1
# template: lib-dedicated-1.0.0
function module_awscli_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local module_type="$SYSDEN64_MODULE_TYPE_DEDICATED"
  local model='aws'
  local source=''

  [[ -z "$(bl64_bsh_command_locate 'aws')" ]] &&
    bl64_dbg_app_show_info "$SYSDEN64_TXT_NOT_DETECTED" && return 0
  bl64_msg_show_phase 'prepare AWS CLI'

  source="$(module_set_model "$module_type" "$model")" &&
    module_setup_env "$home" "$source" "$module_type" "$model" &&
    module_awscli_setup_config "$home" "$source" "$model" "$module_type"
}

function module_awscli_setup_config() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local source="$2"
  local model="$3"
  local module_type="$4"
  local base="${home}"
  local config='.aws'
  local target="${home}/${config}"

  if module_dedicated_is_new "$model"; then
    module_config_backup "$model" "$module_type" "$target" ||
      return $?

    bl64_msg_show_task "promote configuration from model (${model}/${config})"
    if bl64_lib_flag_is_enabled "$SYSDEN64_FLAG_USER_WIDE"; then
      base="${DEV_PATH_PROF_VAULT}/${model}"
      bl64_fs_dir_create "$BL64_VAR_DEFAULT" "$BL64_VAR_DEFAULT" "$BL64_VAR_DEFAULT" \
        "$base" &&
        bl64_fs_path_copy \
          "$BL64_VAR_DEFAULT" \
          "$BL64_VAR_DEFAULT" \
          "$BL64_VAR_DEFAULT" \
          "$BL64_VAR_DEFAULT" \
          "$base" \
          "${source}/${config}" &&
        module_dedicated_relink "$model" "${DEV_PATH_PROF_VAULT}/${model}" "$config" "$target"
    else
      bl64_fs_path_copy \
        "$BL64_VAR_DEFAULT" \
        "$BL64_VAR_DEFAULT" \
        "$BL64_VAR_DEFAULT" \
        "$BL64_VAR_DEFAULT" \
        "$base" \
        "${source}/${config}"
    fi
  else
    module_dedicated_relink "$model" "${DEV_PATH_PROF_VAULT}/${model}" "$config" "$target"
  fi
}
