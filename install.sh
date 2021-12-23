#!/usr/bin/bash
wget https://ftp.gnu.org/pub/gnu/gettext/gettext-0.21.tar.gz -o ./bin/gettext-0.21.tar.gz
cd ./bin/gettext-0.21
./configure
make
make install