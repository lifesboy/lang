#!/usr/bin/bash
method=$1
LANGUAGES=$2
TEMPLATE="en_US"

XGETTEXT="xgettext -L PHP --from-code=UTF-8 -F --strict --debug"
XGETTEXT_PL="xgettext.pl -P Locale::Maketext::Extract::Plugin::Volt -u -w -W"
MSGMERGE="msgmerge -U -N --backup=off"
MSGFMT="msgfmt"

CURDIR=$(pwd)
LOCALEDIR="/usr/share/locale"
COREDIR="/Volumes/Extra/workspace/selks-gpu/staging/usr/local"
PLUGINSDIR="/usr/plugins"

#BSD
PERL_DIR="/usr/local/lib/perl5/site_perl"
#Linux
PERL_DIR="/usr/local/share/perl/5.28.1"
#MacOS
PERL_DIR=$PERL5LIB #"~/perl5/lib/perl5"
PERL_NAME="Locale/Maketext/Extract/Plugin"

mkdir -p "${PERL_DIR}/${PERL_NAME}/"
cp "${CURDIR}/Volt.pm" "${PERL_DIR}/${PERL_NAME}/"
#@: > "${TEMPLATE}.pot"
#perl -I lib "${CURDIR}/Volt.pm"

if ! test -n "$LANGUAGES"; then
  LANGUAGES="cs_CZ"
  LANGUAGES="${LANGUAGES} de_DE"
  LANGUAGES="${LANGUAGES} es_ES"
  LANGUAGES="${LANGUAGES} fr_FR"
  LANGUAGES="${LANGUAGES} it_IT"
  LANGUAGES="${LANGUAGES} ja_JP"
  LANGUAGES="${LANGUAGES} no_NO"
  LANGUAGES="${LANGUAGES} pt_BR"
  LANGUAGES="${LANGUAGES} pt_PT"
  LANGUAGES="${LANGUAGES} ru_RU"
  LANGUAGES="${LANGUAGES} tr_TR"
  LANGUAGES="${LANGUAGES} vi_VN"
  LANGUAGES="${LANGUAGES} zh_CN"
fi

if [ $method = "src" ] || [ $method = "all" ]; then
  python3 "${CURDIR}/Scriptsv2/collect.py" "${COREDIR}"
fi

for LANG in ${LANGUAGES}; do
  TEMPLATE="${LANG}"
  LANGDIR="${LOCALEDIR}/${LANG}/LC_MESSAGES"

  if [ $method = "template" ] || [ $method = "all" ]; then

    # for ROOTDIR in ${PLUGINSDIRS} ${COREDIR} ${LANGDIR}; do
    for ROOTDIR in ${COREDIR}; do
      if [ -d "${ROOTDIR}" ]; then
        echo ">>> Scanning ${ROOTDIR}";
        ${XGETTEXT_PL} -D "${ROOTDIR}" -p "${CURDIR}" -o "${TEMPLATE}.pot";
        find "${ROOTDIR}" -type f -print0 | \
            xargs -0 "${XGETTEXT}" -j -o "${CURDIR}/${TEMPLATE}.pot";
      fi
    done

  fi

  if [ $method = "merge" ] || [ $method = "all" ]; then
    ${MSGMERGE} "${LANG}.po" "${TEMPLATE}.pot"
    # strip stale translations
    sed -i '' -e '/^#~.*/d' "${LANG}.po"
  fi

  if [ $method = "clean" ] || [ $method = "all" ]; then
    echo "clean"
  fi

done
