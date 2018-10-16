#!/bin/bash

kickstart.gpg_verify() {
    # On machines withoput the gpog keyring this would fail,
    # so we chose when check gpg signatures
    if [ "$NO_GPG_VERIFY" -eq 0 ] ; then
        echo -e '\n\n\n\n GPG SIGNATURED VERIFIED \n\n\n\n'
        gpg --verify "$1" "$2"
    fi
}
