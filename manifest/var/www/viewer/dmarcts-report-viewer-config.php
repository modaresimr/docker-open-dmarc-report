<?php

// ####################################################################
// ### configuration ##################################################
// ####################################################################

$dbhost=getenv('REPORT_DB_HOST');
$dbname=getenv('REPORT_DB_NAME');
$dbuser=getenv('REPORT_DB_USER');
$dbpass=getenv('REPORT_DB_PASS');
$dbport=getenv('REPORT_DB_PORT');

$cssfile="default.css";

$default_hostlookup = 1;  # 1=on 0=off (on is old behaviour )
$default_sort = 0;  # 1=ASCdening 0=DESCending (ASCending is default behaviour )

?>
