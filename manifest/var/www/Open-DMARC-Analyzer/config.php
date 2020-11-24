<?php

// ####################################################################
// ### configuration ##################################################
// ####################################################################

// MySQL Settings

define('DB_HOST', getenv('REPORT_DB_HOST'));
define('DB_USER', getenv('REPORT_DB_USER'));
define('DB_PASS', getenv('REPORT_DB_PASS'));
define('DB_NAME', getenv('REPORT_DB_NAME'));
define('DB_PORT', getenv('REPORT_DB_PORT')); // default port 3306

// Debug Settings

define('DEBUG', 1);

// Template Settings

define('TEMPLATE', 'openda');

// Package Loader
define('AUTO_LOADER', 'vendor/autoload.php');	// autoloader for composer installed libraries

// GeoIP2 Settings
define('GEO_ENABLE', 1);											// 0 - disable GeoIP2, 1 - enable GeoIP2
define('GEO_DB', 'includes/geolite2.mmdb');		// location of GeoIP2 database

// Defaults

define('DATE_RANGE', '-1 week');


?>
