<?php
ini_set('max_execution_time', 0);
include 'db/db_connection.php';

/**
 * Include the API
 */
include 'api.php';
$api = new Api();

/**
 * Select the region for collect matches
 */
$region = 'tr';
$items_data = $api->getItems('eune');


/**
 * Initializing
 */
$array_to_write = array();
$matches_json = json_decode(file_get_contents('matches/' . strtoupper($region) . '.json'), true);

/**
 * Get the static datas through the API
 */
$spells_data = $api->getSpells('eune');
$data_champs = $api->getStaticData('eune');
$brawler_ids = array(3611, 3612, 3613, 3614);

/**
 * Insert stats
 */
foreach ($matches_json as $key => $match) {

    if ($key == 100) {
        break;
    }
    /**
     * Initializing
     */
    $kills = $death = $assist = $dragons = $barons = array();
    $kills = array_fill(1, 10, '0');
    $death = array_fill(1, 10, '0');
    $assist = array_fill(1, 10, '0');
    $dragons = array_fill(1, 10, '0');
    $barons = array_fill(1, 10, '0');
    $items = array();
    $stats = array();

    /**
     * Get the current match datas
     */
    $data_match = $api->getMatchData($region, $match);

    /**
     * Get the winner team
     */
    $winner="";
    if($data_match['teams'][0]['winner']){
        $winner="blue";
    }else{
        $winner="red";
    }
    $stats['winner']=$winner;

    /**
     * Get champions with some informations
     */
    $champNames = array();
    foreach ($data_match['participants'] as $participant) {
        $champID = $participant['championId'];
        $champNames[$participant['participantId']] = array(
            'name' => str_replace("'", '', $data_champs['data'][$champID]['name']),
            'image' => $data_champs['data'][$champID]['image']['full'],
        );
    }

    /**
     * Fill up the arrays with coordinates and events
     */
    $coordinates = array();
    $events = array();
    foreach ($data_match['timeline']['frames'] as $k => $min) {
        if (!empty($min['events'])) {
            $events[] = $min['events'];
        }
        foreach ($min['participantFrames'] as $kk => $value) {
            if (array_key_exists('position', $value)) {
                ($kk < 6 ? $teamID = 'blue' : $teamID = 'red');
                $ImageUrl = $champNames[$kk]['image'];
                $coordinates[$k][] = array($value['position']['x'], $value['position']['y'], $champNames[$kk]['name'], 'http://ddragon.leagueoflegends.com/cdn/5.15.1/img/champion/' . $ImageUrl, $teamID, str_replace(' ', '', $champNames[$kk]['name']));
            }
        }
    }

    /**
     * Create a participant
     */
    foreach ($champNames as $k => $name) {
        $stats[$k] = array(
            'name' => $name['name'],
            'icon' => 'http://ddragon.leagueoflegends.com/cdn/5.15.1/img/champion/' . $name['image'],
            'splash' => 'http://ddragon.leagueoflegends.com/cdn/img/champion/splash/' . basename($name['image'], '.png') . '_0.jpg'
        );


        /**
        * Spell items
        */
        foreach ($data_match['participants'] as $part) {
            if ($part['participantId'] == $k) {
                $s1 = $part['spell1Id'];
                $s2 = $part['spell2Id'];
                foreach ($spells_data['data'] as $spell_key => $spell) {
                    if ($spell['id'] == $s1 || $spell['id'] == $s2) {
                        $stats[$k]['spells'][] = array(
                            'name' => $spell['name'],
                            'imageUrl' => 'http://ddragon.leagueoflegends.com/cdn/5.15.1/img/spell/' . $spell['image']['full']
                        );
                    }
                }

            }
        }

        /*
        |	Create Stats array w/ ['kills','assist','deaths']
        */

        foreach ($data_match['timeline']['frames'] as $fk => $min) {
            $stats[$k]['timeline'][$fk]['kills'] = $kills[$k];
            $stats[$k]['timeline'][$fk]['assists'] = $assist[$k];
            $stats[$k]['timeline'][$fk]['death'] = $death[$k];
            $stats[$k]['timeline'][$fk]['dragons'] = $dragons[$k];
            $stats[$k]['timeline'][$fk]['barons'] = $barons[$k];

            //minions + level + gold
            foreach ($min['participantFrames'] as $pkk => $pvalue) {
                if ($pvalue['participantId'] == $k) {
                    $stats[$k]['timeline'][$fk]['minionsKilled'] = $pvalue['minionsKilled'];
                    $stats[$k]['timeline'][$fk]['level'] = $pvalue['level'];
                    $stats[$k]['timeline'][$fk]['gold'] = $pvalue['totalGold'];
                }

            }

            /*
            * ITERATE EVENTS
            */

            if (isset($min['events'])) {
                foreach ($min['events'] as $skk => $value) {

                    /*
                     * CHAMPION KILLS + ASSISTS
                     */
                    if ($value['eventType'] == "CHAMPION_KILL") {
                        if ($value['killerId'] == $k) {
                            $kills[$k] += 1;
                            $stats[$k]['timeline'][$fk]['kills'] = $kills[$k];
                        }
                        if ($value['victimId'] == $k) {
                            $death[$k] += 1;
                            $stats[$k]['timeline'][$fk]['deaths'] = $death[$k];
                        }
                        if (isset($value['assistingParticipantIds'])) {
                            foreach ($value['assistingParticipantIds'] as $as) {
                                if ($as == $k) {
                                    $assist[$k] += 1;
                                    $stats[$k]['timeline'][$fk]['assists'] = $assist[$k];
                                }
                            }
                        }
                    }

                    /*
                    * BRAWLERS
                    */
                    if ($value['eventType'] == "ITEM_PURCHASED" && in_array($value['itemId'], $brawler_ids) && $value['participantId'] == $k) {
                        foreach ($items_data['data'] as $item) {
                            if ($item['id'] == $value['itemId']) {
                                $stats[$k]['timeline'][$fk]['brawler_name'] = $item['name'];
                                $stats[$k]['timeline'][$fk]['brawler_id'] = $item['id'];
                                $stats[$k]['timeline'][$fk]['brawler_image'] = 'http://ddragon.leagueoflegends.com/cdn/5.15.1/img/item/' . $item['image']['full'];
                                break;
                            }
                        }

                    }

                    /*
                    * ITEMS
                    */

                    //PURCHASED ITEMS
                    else if ($value['eventType'] == "ITEM_PURCHASED" && $value['participantId'] == $k) {
                        foreach ($items_data['data'] as $item) {
                            if ($item['id'] == $value['itemId']) {

                                $items[$k][] = array(
                                    'name' => $item['name'],
                                    'imageUrl' => 'http://ddragon.leagueoflegends.com/cdn/5.15.1/img/item/' . $item['image']['full'],
                                    'id' => $item['id']
                                );
                            }
                        }
                    }
                    //DESTROYED + SOLD ITEMS
                    else if (($value['eventType'] == "ITEM_DESTROYED" || $value['eventType'] == "ITEM_SOLD") && ($value['participantId'] == $k)) {

                        if (isset($items[$k])) {
                            foreach ($items[$k] as $in => $it) {
                                if ($it['id'] == $value['itemId']) {
                                    unset($items[$k][$in]);
                                }
                            }
                        }
                    } else
                        //UNDO ITEM
                        if ($value['eventType'] == "ITEM_UNDO" && $value['participantId'] == $k) {
                            foreach ($items[$k] as $in => $it) {
                                if ($it['id'] == $value['itemBefore'] || $value['itemBefore'] == 0) {
                                    unset($items[$k][$in]);
                                }
                            }
                        }


                    /*
                    * ELITE MONSTER KILLS (DRAGON + BARON)
                    */
                    if ($value['eventType'] == "ELITE_MONSTER_KILL") {

                        if ($value['killerId'] == $k) {
                            if ($value['monsterType'] == "DRAGON") {
                                $dragons[$k] += 1;
                                $stats[$k]['timeline'][$fk]['dragons'] = $dragons[$k];
                            } else {
                                $barons[$k] += 1;
                                $stats[$k]['timeline'][$fk]['barons'] = $barons[$k];
                            }
                        }
                    }
                }

            }
            /*
            * CURRENT ITEMS OF A CHAMPION IN THIS FRAME
            */
            if (isset($items[$k])) {
                foreach ($items[$k] as $item_key => $itm) {
                    $stats[$k]['timeline'][$fk]['items'][] = $itm;
                }
            }
        }
    }


    /*
    * READY TO INSERT
    */
    $array_to_write['stats'] = $stats;
    $array_to_write['coordinates'] = $coordinates;
    $data = json_encode($array_to_write);


    //INSERT THE PROCESSED ARRAY INTO THE TABLE
    mysql_query("insert into matches (data, region, match_id) values ('" . mysql_real_escape_string($data) . "', '" . mysql_real_escape_string($region) . "', '" . $match . "')");
    $array_to_write = array();
}


/*
* BILGEWATER ITEM IDs
*/

$bilgewater_items = array(3844, 3433, 3431, 3911, 3840, 3430, 3434, 3742, 3841, 3652, 3924, 3745, 3245, 3829, 3744, 3150);

/*
* GET ALL THE MATCHES FOR CREATING STATS
*/

$result = mysql_query("select * from matches");
$matchNum = mysql_num_rows($result);

/*
* INITIALIZE THE BRAWLERS
*/

$gameover = array('countMatches' => $matchNum, 'brawlers' => array(), 'items' => array());
foreach ($brawler_ids as $braw) {
    foreach ($items_data['data'] as $item) {
        if ($item['id'] == $braw) {
            $gameover['brawlers'][$braw] = array(
                'name' => $item['name'],
                'image' => 'http://ddragon.leagueoflegends.com/cdn/5.15.1/img/item/' . $item['image']['full'],
                'qty' => 0,
                'desc' => $item['description'],
                'rate' => 0
            );
            break;
        }
    }
}

/*
* INITIALIZE THE BILGEWATER ITEMS
*/

foreach ($bilgewater_items as $bitem) {
    foreach ($items_data['data'] as $item) {
        if ($item['id'] == $bitem) {
            $gameover['items'][$bitem] = array(
                'name' => $item['name'],
                'image' => 'http://ddragon.leagueoflegends.com/cdn/5.15.1/img/item/' . $item['image']['full'],
                'qty' => 0,
                'desc' => $item['description'],
                'rate' => 0
            );
            break;
        }
    }
}

/*
* PROCESS AND CREATE THE STATISTICS
*/

while ($row = mysql_fetch_array($result)) {
    $data_match = json_decode($row['data'], 1);
    foreach ($data_match['stats'] as $participant) {
        $purchased_item = array();

        foreach ($participant['timeline'] as $frame) {
            if (isset($frame['brawler_id'])) {
                $bid = $frame['brawler_id'];
                $gameover['brawlers'][$bid]['qty'] += 1;
                $gameover['brawlers'][$bid]['rate'] = str_replace(".0", "", (string)number_format(($gameover['brawlers'][$bid]['qty'] / ($matchNum * 10)) * 100, 1, '.', ''));
            }

            if (isset($frame['items'])) {
                foreach ($frame['items'] as $items) {
                    if (in_array($items['id'], $bilgewater_items)) {

                        if (!in_array($items['id'], $purchased_item)) {
                            $purchased_item[] = $items['id'];
                        }
                    }
                }
            }
        }
        foreach ($purchased_item as $pitem) {
            $gameover['items'][$pitem]['qty'] += 1;
            $gameover['items'][$pitem]['rate'] = str_replace(".0", "", (string)number_format(($gameover['items'][$pitem]['qty'] / ($matchNum * 10)) * 100, 1, '.', ''));
        }
    }
}

/*
* PUSH THEM INTO THE TABLE
*/

mysql_query("insert into gameover (data) values ('".mysql_real_escape_string(json_encode($gameover))."')");

echo "<h1>Generation Completed! Everything is ready to show!</h1>";
