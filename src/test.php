<?php

// Set language to German
putenv('LC_ALL=vi_VN');
setlocale(LC_ALL, 'vi_VN');

// Specify location of translation tables
// bindtextdomain("OPNsense", "./locale");
bindtextdomain("OPNsense", __DIR__."../usr/share/locale");

// Choose domain
textdomain("OPNsense");

// Translation is looking for in ./locale/de_DE/LC_MESSAGES/myPHPApp.mo now

require_once __DIR__."/acl.php";
require_once __DIR__."/config.php";
require_once __DIR__."/controllers.php";
require_once __DIR__."/models.php";
require_once __DIR__."/wizards.php";
