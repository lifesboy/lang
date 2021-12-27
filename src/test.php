<?php
define("DESTDIR", "");
// Set language to Vietnamese
$locale = empty($argv[1]) ? 'vi_VN' : $argv[1];
putenv("LC_ALL=$locale");
$res = setlocale(LC_ALL, $locale);
var_dump($res);

// Specify location of translation tables
// bindtextdomain("OPNsense", "./locale");
bindtextdomain("OPNsense", DESTDIR."/usr/share/locale");

// Choose domain
textdomain("OPNsense");

// Translation is looking for in ./locale/$locale/LC_MESSAGES/OPNsense.mo now

require_once __DIR__."/acl.php";
require_once __DIR__."/config.php";
require_once __DIR__."/controllers.php";
require_once __DIR__."/models.php";
require_once __DIR__."/wizards.php";

echo DESTDIR."/usr/share/locale/$locale/LC_MESSAGES/OPNsense.mo";
