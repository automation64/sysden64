# version: 1.0.1
# template: lib-env-1.0.0
function module_dotnet_setup() {
  bl64_dbg_app_show_function "$@"
  local home="$1"
  local module_type="$SYSDEN64_MODULE_TYPE_SHARED"
  local module='dotnet'
  local extra_locations='/opt/dotnet'

  module_detect "$module" 'dotnet' 'Microsoft .NET SDK' "$extra_locations" || return 0

  source="$(module_config_get_source "$module_type" "$module")" &&
    module_setup_env "$home" "$source" "$module_type" "$module"
}
