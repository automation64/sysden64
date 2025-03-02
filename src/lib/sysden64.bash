#
# Module shared libraries and variables
#

#
# Globals
#

# shellcheck disable=SC2034
{
  # SysDen64 / Common messages
  readonly SYSDEN64_TXT_NOT_DETECTED='tool not detected. No further action taken'
  readonly SYSDEN64_TXT_CONFIGURED='already configured. No further action taken'
  readonly SYSDEN64_TXT_WATERMARK='# Warning: configuration file generated by SysDen64. DO NOT MODIFY'
}

#
# Functions
#

function module_create_shared() {
  bl64_dbg_app_show_function "$@"
  local module="$1"
  bl64_lib_flag_is_enabled "$SYSDEN64_USE_DEVBIN64" || return 0
  if [[ ! -d "${SYSDEN64_PATH_SHARED}/${module}" ]]; then
    bl64_fs_path_copy \
      "$BL64_VAR_DEFAULT" "$BL64_VAR_DEFAULT" "$BL64_VAR_DEFAULT" "$BL64_VAR_DEFAULT" \
      "$SYSDEN64_PATH_SHARED" \
      "${SYSDEN64_PATH_ETC}/${module}" ||
      return $?
  fi
}

function module_set_model() {
  local module="$1"
  if bl64_lib_flag_is_enabled "$SYSDEN64_USE_DEVBIN64"; then
    echo "${SYSDEN64_PATH_SHARED}/${module}"
  else
    echo "$SYSDEN64_PATH_ETC/$module"
  fi
}
