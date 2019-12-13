#!/bin/sh

#### Bootstrap

# Usage: build_simple_cdd ...
build_simple_cdd()
{
    set -e

    local this="${0##*/}"
    local this_dir="$(p="${0%$this}" && cd "${p:-.}" && echo "$PWD")"

    cd "$this_dir/.." && [ './profiles' -ef "$this_dir" ] || exit

    exec env -i \
        ${PATH:+PATH="$PATH"} \
        ${TERM:+TERM="$TERM"} \
        ${LOGNAME:+LOGNAME="$LOGNAME"} \
        ${USER:+USER="$USER"} \
        ${USERNAME:+USERNAME="$USERNAME"} \
        ${HOSTNAME:+HOSTNAME="$HOSTNAME"} \
        ${HOME:+HOME="$HOME"} \
        ${SHELL:+SHELL="$SHELL"} \
        ${PWD:+PWD="$PWD"} \
        ${MAIL:+MAIL="$MAIL"} \
        ${LANG:+LANG="$LANG"} \
        ${LANGUAGE:+LANGUAGE="$LANGUAGE"} \
        ${LC_ALL:+LC_ALL="$LC_ALL"} \
        ${LC_CTYPE:+LC_CTYPE="$LC_CTYPE"} \
        build-simple-cdd "$@" --conf "./profiles/$this"
}

# See how we are called
case "$-" in
   *a*) ;;                       # simple-cdd build environment
     *) build_simple_cdd "$@" ;; # directly
esac

# This is default path for build-simple-cdd(1) set by internal VARIABLES
# in python3/dist-packages/simple_cdd/variables.py.
simple_cdd_dir="${simple_cdd_dir:-$PWD}"

# Usage: include_deps <profile> [<profile_desc>] [<val>] ...
include_deps()
{
    # Allow real profile configuration to be included
    unset "__included_${3}__"

    # Order is important to set @profiles and @auto_profiles correctly
    include "${path:+$path/../}./$3.conf"
}

# Define profile and optionally it's description
set -- 'minimalsh' '' 'minimal'

. "$simple_cdd_dir/profiles/groups/distro/debian.conf" "$@"

#### Profile configuration

## Export profiles list

profiles="${profiles}"
