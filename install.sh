#!/usr/bin/bash
mkdir -p ./bin
wget -v -O ./bin/gettext-0.21.tar.gz https://ftp.gnu.org/pub/gnu/gettext/gettext-0.21.tar.gz
cd ./bin
tar -zxvf gettext-0.21.tar.gz
cd ./gettext-0.21
./configure
make
make install
cd ..
apt-get install -y perl-doc
perl -MCPAN -e "install Locale::Maketext::Lexicon"