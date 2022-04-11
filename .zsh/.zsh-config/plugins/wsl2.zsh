#!/usr/bin/env zsh
if [ -f "/mnt/c/Windows/system32/reg.exe" ]; then
  build_version="$(/mnt/c/Windows/system32/reg.exe query "HKLM\\Software\\Microsoft\\Windows NT\\CurrentVersion" /v CurrentBuild | tail -n 2 | head -n 1 | sed -e 's|\r||g' | awk '{print $3}')"
  if [ "$build_version" -lt 20000 ]; then
    export WSL_HOST=$(tail -1 /etc/resolv.conf | cut -d' ' -f2)
    export DISPLAY=$WSL_HOST:0.0

    export LIBGL_ALWAYS_INDIRECT=1
  fi
fi
