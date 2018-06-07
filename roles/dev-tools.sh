#!/bin/bash

kickstart.context 'Dev Tools'

kickstart.package.install curl
kickstart.package.install jq
kickstart.package.install shellcheck
kickstart.package.install tree
kickstart.package.install wget
