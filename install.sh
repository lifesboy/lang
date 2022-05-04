#!/usr/bin/bash
os=$1

mkdir -p ./bin
wget -v -O ./bin/gettext-0.21.tar.gz https://ftp.gnu.org/pub/gnu/gettext/gettext-0.21.tar.gz
cd ./bin
tar -zxvf gettext-0.21.tar.gz
cd ./gettext-0.21
./configure
make
make install
cd ../..
apt-get install -y perl-doc
perl -MCPAN -e "install Locale::Maketext::Lexicon"

#BSD
PERL_DIR="/usr/local/lib/perl5/site_perl"
#Linux
PERL_DIR="/usr/share/perl5"
if [ "${os}" = "mac" ]; then
  #MacOS
  PERL_DIR=$PERL5LIB #"~/perl5/lib/perl5"
fi
PERL_NAME="Locale/Maketext/Extract/Plugin"

mkdir -p "${PERL_DIR}/${PERL_NAME}/"
cp "./Volt.pm" "${PERL_DIR}/${PERL_NAME}/"
#perl -I lib "${CURDIR}/Volt.pm"