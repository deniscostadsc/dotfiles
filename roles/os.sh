kickstart.context 'OS'

kickstart.package.update
kickstart.package.upgrade

apt -y autoclean
apt -y autoremove
