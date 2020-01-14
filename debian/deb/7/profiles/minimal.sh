#!/bin/sh

# This snippet is
if [ -n "$-" -a -z "${-##*a*}" ]; then
    # sourced by simple-cdd build environment
    set -- 'minimal-sh' 'minimal'
else
    # called by user directly
    this="${0##*/}"
    this_dir="$(p="${0%$this}" && cd "${p:-.}" && echo "$PWD")"

    cd "$this_dir/.." && [ './profiles' -ef "$this_dir" ] || exit
fi

. './profiles/sh/common'
