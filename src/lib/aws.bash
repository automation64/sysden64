# version: 4.0.0
# template: lib-dedicated-1.0.0
function module_aws_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local module_type="$SYSDEN64_MODULE_TYPE_DEDICATED"
  local model='aws'
  local source=''

  module_detect "$model" 'aws' 'AWS CLI' || return 0

  source="$(module_set_model "$module_type" "$model")" &&
    module_setup_env "$home" "$source" "$module_type" "$model" &&
    module_aws_setup_config "$home" "$source" "$model" "$module_type"
}

function module_aws_setup_config() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local source="$2"
  local model="$3"
  local module_type="$4"
  local base="${home}"
  local config='.aws'
  local target="${home}/${config}"

  module_dedicated_setup_config "$source" "$model" "$module_type" "$base" "$config" "$target" 
}
