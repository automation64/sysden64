# version: 3.0.2
# template: lib-dedicated-1.0.1
function module_gcloud_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local module_type="$SYSDEN64_MODULE_TYPE_DEDICATED"
  local module_name='gcloud'
  local module_etc=''

  module_detect "$module_name" 'gcloud' 'GCloud - CLI' || return 0

  module_etc="$(module_config_get_source "$module_type" "$module_name")" &&
    module_setup_env "$home" "$module_etc" "$module_type" "$module_name" &&
    module_gcloud_setup_config "$home" "$module_etc" "$module_name" "$module_type"
}

function module_gcloud_setup_config() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local module_etc="$2"
  local module_name="$3"
  local module_type="$4"
  local config_destination="${home}/.config"
  local module_config='.config/gcloud'
  local config_backup="${home}/${module_config}"

  module_dedicated_setup_config "$module_etc" "$module_name" "$module_type" "$config_destination" "$module_config" "$config_backup"
}
