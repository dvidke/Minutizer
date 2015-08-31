<?php

/**
 * Connecting to the DB
 */
$dbconnect = mysql_connect('host', 'username', 'password');
mysql_select_db("db_name", $dbconnect);