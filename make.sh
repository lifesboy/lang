#!/usr/bin/bash
method=$1
if [ $method = "src" ]; then
  echo "src"
  python3 ./Scriptsv2/collect.py /Volumes/Extra/workspace/selks-gpu/staging/usr/local/

elif [ $method = "template" ]; then
  echo "template"
  python3 ./Scriptsv2/tools/pygettext.py -a -k gettext src/acl.php

elif [ $method = "merge" ]; then
  echo "merge"

elif [ $method = "clean" ]; then
  echo "clean"

fi
