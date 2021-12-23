#!/usr/bin/bash
mkdir -p ./bin
wget https://ftp.gnu.org/pub/gnu/gettext/gettext-0.21.tar.gz -o ./bin/gettext-0.21.tar.gz
cd ./bin
tar -zxvf gettext-0.21.tar.gz
cd ./gettext-0.21
./configure
make
make install