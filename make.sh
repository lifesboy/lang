#!/usr/bin/bash
method=$1
LANGUAGES=$2
TEMPLATE="en_US"

XGETTEXT="xgettext -L PHP --from-code=UTF-8 -F --strict --debug"
XGETTEXT_PL="xgettext.pl -P Locale::Maketext::Extract::Plugin::Volt -u -w -W"
MSGMERGE="msgmerge -U -N --backup=off"
MSGFMT="msgfmt"

PERL_DIR="/usr/local/lib/perl5/site_perl"
PERL_NAME="Locale/Maketext/Extract/Plugin"

CURDIR=$(pwd)
LOCALEDIR="/usr/share/locale/"

if test -n "$LANGUAGES"; then
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

for LANG in ${LANGUAGES}; do
  TEMPLATE="${LANG}"
  PLUGINSDIR="/usr/plugins"
  COREDIR="/usr/core"
  LANGDIR="${LOCALEDIR}/${LANG}/LC_MESSAGES"

  if [ $method = "src" ] || [ $method = "all" ]; then
    python3 "${CURDIR}/Scriptsv2/collect.py" /Volumes/Extra/workspace/selks-gpu/staging/usr/local/
  fi

  if [ $method = "template" ] || [ $method = "all" ]; then
    cp "${CURDIR}/Volt.pm" ${PERL_DIR}/${PERL_NAME}/
	  @: > "${TEMPLATE}.pot"

    for ROOTDIR in ${PLUGINSDIRS} ${COREDIR} ${LANGDIR}; do
      if [ -d "${ROOTDIR}/src" ]; then
        echo ">>> Scanning ${ROOTDIR}";
        ${XGETTEXT_PL} -D ${ROOTDIR}/src -p "${CURDIR}" -o ${TEMPLATE}.pot;
        find ${ROOTDIR}/src -type f -print0 | \
            xargs -0 ${XGETTEXT} -j -o "${CURDIR}/${TEMPLATE}.pot";
      fi
    done

  fi

  if [ $method = "merge" ] || [ $method = "all" ]; then
    ${MSGMERGE} ${LANG}.po ${TEMPLATE}.pot
    # strip stale translations
    sed -i '' -e '/^#~.*/d' ${LANG}.po
  fi

  if [ $method = "clean" ] || [ $method = "all" ]; then
    echo "clean"
  fi

done

