<?php
define("DESTDIR", __DIR__."/..");
// Set language to Vietnamese
$locale = 'vi_VN';
putenv("LC_ALL=$locale");
echo setlocale(LC_ALL, $locale);

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
