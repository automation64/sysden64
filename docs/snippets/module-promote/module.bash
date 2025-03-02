# X_PROMOTE_PLACECHOLDER_X
  config_backup "${home}/${config}" || return $?
  bl64_msg_show_task "promote configuration from model (${model}/${config})"
  bl64_fs_path_copy \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$BL64_VAR_DEFAULT" \
    "$home" \
    "${model}/${config}"
