<?php

/**
 * Get the helpers
 */
include 'db/db_connection.php';
include 'api.php';
require_once('libs/Smarty.class.php');
$smarty = new Smarty();
$api = new Api();

/**
 * Random ID to pick a match from the DB
 */
$id=rand(1,1000);

/**
 * Get a random match from the DB
 */
$result_match = mysql_query("SELECT * FROM matches WHERE id=$id");
$match = mysql_fetch_array($result_match);

/**
 * Get an array of statistics from DB
 */
$result_gameover = mysql_query("SELECT data FROM gameover");
$gameover = mysql_fetch_array($result_gameover);

/**
 * Give the arrays to Smarty
 */
$stats_json = json_decode($match['data'], true);
$smarty->assign('stats', $stats_json['stats']);
$smarty->assign('coordinates', json_encode($stats_json['coordinates']));
$smarty->assign('jstats', json_encode($stats_json['stats']));
$smarty->assign('gameover', json_decode($gameover[0],true));
$smarty->assign('winner', $stats_json['winner']);

/**
 * Display the Teamplate
 */
$smarty->display('index.tpl');