#!/usr/bin/bash
method=$1
LANGUAGES=$2
TEMPLATE="en_US"

XGETTEXT="xgettext -L PHP --from-code=UTF-8 -F --strict --debug"
XGETTEXT_PL="xgettext.pl -P Locale::Maketext::Extract::Plugin::Volt -u -w -W"
MSGMERGE="msgmerge -U -N --backup=off"
MSGFMT="msgfmt"

CURDIR=$(pwd)
DESTDIR=
LOCALEDIR="/usr/share/locale"

INSTALLEDDIR="/usr/local"
PLUGINSINSTALLEDDIR="/usr/plugins"
#Dev machine
#INSTALLEDDIR="/Volumes/Extra/workspace/selks-gpu/staging/usr/local"
#PLUGINSINSTALLEDDIR="/Volumes/Extra/workspace/opnsense-plugins"
#DESTDIR=$CURDIR

COREDIR="${INSTALLEDDIR}/opnsense"
PLUGINSDIRS=$(find $PLUGINSINSTALLEDDIR -type d -maxdepth 3 -regex ".*/src")

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
  python3 "${CURDIR}/Scriptsv2/collect.py" ${PLUGINSDIRS} ${INSTALLEDDIR}
fi

for LANG in ${LANGUAGES}; do
  echo "\n>>> ${LANG}"
  TEMPLATE="${LANG}"
  LANGDIR="${LOCALEDIR}/${LANG}/LC_MESSAGES"

  if [ $method = "template" ] || [ $method = "all" ]; then
    echo > "${CURDIR}/${TEMPLATE}.pot"

    # for ROOTDIR in ${PLUGINSDIRS} ${COREDIR} ${LANGDIR}; do
    for ROOTDIR in ${PLUGINSDIRS} ${COREDIR}; do
      if [ -d "${ROOTDIR}" ]; then
        echo ">>> Scanning ${ROOTDIR}";
        ${XGETTEXT_PL} -D "${ROOTDIR}" -p "${CURDIR}" -o "${TEMPLATE}.pot";
        find "${ROOTDIR}/" -type f -print0 | \
            xargs -0 ${XGETTEXT} -j -o "${CURDIR}/${TEMPLATE}.pot";
      fi
    done

  fi

  if [ $method = "merge" ] || [ $method = "all" ]; then
    ${MSGMERGE} "${LANG}.po" "${TEMPLATE}.pot"
    # strip stale translations
    #BSD, MacOS
    #sed -i '' -e '/^#~.*/d' "${LANG}.po"
    #Linux
    sed -i -e '/^#~.*/d' "${LANG}.po"
  fi

  if [ $method = "clean" ] || [ $method = "all" ]; then
	  rm -f "${DESTDIR}${LANGDIR}/OPNsense.mo"
  fi

  if [ $method = "install" ] || [ $method = "all" ]; then
	  mkdir -p "${DESTDIR}${LANGDIR}"
	  ${MSGFMT} --strict -o "${DESTDIR}${LANGDIR}/OPNsense.mo" "${LANG}.po"
	  ls -la "${DESTDIR}${LANGDIR}/OPNsense.mo"
  fi

  if [ $method = "test" ] || [ $method = "all" ]; then
    ${MSGFMT} -o /dev/null ${LANG}.po
    # XXX pretty this up
    echo $(grep -c ^msgid "${LANG}.po") / $(grep -c ^msgstr "${LANG}.po")
  fi

done
