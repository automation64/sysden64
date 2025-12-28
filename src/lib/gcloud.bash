# version: 3.0.1
# template: lib-dedicated-1.0.0
function module_gcloud_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local module_type="$SYSDEN64_MODULE_TYPE_DEDICATED"
  local model='gcloud'
  local source=''

  module_detect "$model" 'gcloud' 'GCloud CLI' || return 0

  source="$(module_set_model "$module_type" "$model")" &&
    module_setup_env "$home" "$source" "$module_type" "$model" &&
    module_gcloud_setup_config "$home" "$source" "$model" "$module_type"
}

function module_gcloud_setup_config() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local source="$2"
  local model="$3"
  local module_type="$4"
  local base="${home}/.config"
  local config='.config/gcloud'
  local target="${home}/${config}"

  module_dedicated_setup_config "$source" "$model" "$module_type" "$base" "$config" "$target" 
}
