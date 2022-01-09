#!/bin/bash

spede_root=${SPEDE_ROOT:-/opt/spede}

typeset -A install_dirs
install_dirs=(
    [bin]="spede-run spede-target qemu-qmp"
    [etc]="spede.gdbinit"
    [lib]="gdb_helpers.py"
    [share/images/spede-target]="spede-target.qcow2"
)

function main() {
    echo "Creating SPEDE Root directory '${spede_root}'"
    install -d ${spede_root} || return $?

    for dir in ${!install_dirs[*]}; do
        dest=${spede_root}/${dir}

        echo "Creating directory '${dir}'..."
        install -d ${dest} || return $?

        for file in ${install_dirs[${dir}]}; do
            echo "Copying '${file}' to '${dest}'..."
            install ${file} ${dest} || return $?
        done
    done

    echo "Installation complete"
}

main $@
exit $?
