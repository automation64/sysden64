# version: 1.0.1
# template: lib-env-1.0.1
function module_dotnet_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local module_type="$SYSDEN64_MODULE_TYPE_SHARED"
  local module_name='dotnet'
  local module_etc=''
  local extra_locations='/opt/dotnet'

  module_detect "$module_name" 'dotnet' 'Microsoft .NET SDK' "$extra_locations" || return 0

  module_etc="$(module_config_get_source "$module_type" "$module_name")" &&
    module_setup_env "$home" "$module_etc" "$module_type" "$module_name"
}
