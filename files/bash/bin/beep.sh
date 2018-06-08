#!/bin/bash

( speaker-test -t sine -f 1000 > /dev/null )& pid=$! ; sleep 0.1s ; kill -9 $pid
