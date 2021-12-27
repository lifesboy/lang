<?php
define("DESTDIR", "");
// Set language to Vietnamese
$locale = empty($argv[1]) ? 'vi_VN' : $argv[1];

$lang_encoding = $locale . '.UTF-8';
$textdomain = 'OPNsense';

putenv('LANG=' . $lang_encoding);
textdomain($textdomain);
bindtextdomain($textdomain, DESTDIR."/usr/share/locale");
$res = bind_textdomain_codeset($textdomain, $lang_encoding);
var_dump($res);
putenv("LC_ALL=$locale");
$res = setlocale(LC_ALL, $locale);
var_dump($res);

// Translation is looking for in ./locale/$locale/LC_MESSAGES/OPNsense.mo now

require_once __DIR__."/acl.php";
require_once __DIR__."/config.php";
require_once __DIR__."/controllers.php";
require_once __DIR__."/models.php";
require_once __DIR__."/wizards.php";

echo DESTDIR."/usr/share/locale/$locale/LC_MESSAGES/OPNsense.mo";
