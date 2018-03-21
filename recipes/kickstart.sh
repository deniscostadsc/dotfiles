download() {
  if which curl; then
    curl -LO "$1"
  elif which wget; then
    wget "$1"
  else
    echo you dont have a tool to donwload files
    exit 1
  fi
}

install_temporarily_kickstart() {
    cd $(mktemp -d)
    download https://github.com/bltavares/kickstart/archive/master.zip
    unzip master.zip
    export PATH=${PWD}/kickstart-master/bin:$PATH
    cd -
}
