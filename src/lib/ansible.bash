# version: 1.0.2
# template: lib-config-1.0.0
function module_ansible_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local module_type="$SYSDEN64_MODULE_TYPE_SHARED"
  local model='ansible'
  local source=''

  [[ -z "$(bl64_bsh_command_locate 'ansible')" ]] &&
    bl64_dbg_app_show_info "$SYSDEN64_TXT_NOT_DETECTED" && return 0
  bl64_msg_show_phase 'prepare Ansible'

  source="$(module_set_model "$module_type" "$model")" &&
    module_ansible_setup_config "$home" "$source" "$model" "$module_type"
}

function module_ansible_setup_config() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local source="$2"
  local model="$3"
  local module_type="$4"
  local base="${home}"
  local config='.ansible.cfg'
  local target="${base}/${config}"

  module_config_backup "$model" "$module_type" "$target" ||
    return $?

  bl64_msg_show_task "promote configuration from model (${model}/${config})"
  bl64_fs_path_copy \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$base" \
    "${source}/${config}"
}
