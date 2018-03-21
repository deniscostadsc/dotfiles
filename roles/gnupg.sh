kickstart.context 'GnuPG'

kickstart.package.install gnupg2

kickstart.info "Copy GnuPG config files"
cp --preserve=mode,ownership files/gnupg/* ~/.gnupg/
