#!/bin/bash

kickstart.gpg_verify() {
    # On machines withoput the gpog keyring this would fail,
    # so we chose when check gpg signatures
    if [ "$NO_GPG_VERIFY" -eq 0] ; then
        gpg --verify "$1" "$2"
    fi
}
