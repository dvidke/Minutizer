<?php
include 'api_key.php';
class Api
{
    public static $api_key = KEY;

    /**
     * Match data from Riot API
     * @param  string $region
     * @param  string $match_id
     * @return array
     */
    public function getMatchData($region, $match_id)
    {
        return $this->curl('https://' . $region . '.api.pvp.net/api/lol/' . $region . '/v2.2/match/' . $match_id . '?includeTimeline=true&api_key=' . static::$api_key);
    }

    /**
     * Champ data from Riot API
     * @param  string $region
     * @return array
     */
    public function getStaticData($region)
    {
        return $this->curl('https://' . $region . '.api.pvp.net/api/lol/static-data/' . $region . '/v1.2/champion?champData=image&dataById=true&api_key=' . static::$api_key);
    }

    /**
     * Spell data from Riot API
     * @param  string $region
     * @return array
     */
    public function getSpells($region)
    {
        return $this->curl('https://global.api.pvp.net/api/lol/static-data/' . $region . '/v1.2/summoner-spell?spellData=image&api_key=' . static::$api_key);
    }

    /**
     * Get Champions Names who picked the specified brawlers
     * @param  array $events
     * @param  array $champNames
     * @param  string $brawler_id
     * @return array
     */
    public function getBrawlers($events, $champNames, $brawler_id)
    {
        $champs_with_brawlers = array();
        foreach ($events as $k => $e) {
            foreach ($e as $kk => $event) {
                if (isset($event['itemId']) AND $event['eventType'] == "ITEM_PURCHASED" AND $event['itemId'] == $brawler_id) {
                    $champs_with_brawlers[$event['participantId']] = $champNames[$event['participantId']];
                }
            }
        }
        return $champs_with_brawlers;
    }

    /**
     * Items data from Riot API
     * @param  string $region
     * @return array
     */
    public function getItems($region)
    {
        return $this->curl('https://' . $region . '.api.pvp.net/api/lol/static-data/' . $region . '/v1.2/item?itemListData=image&api_key=' . static::$api_key);
    }


    /**
     * CURL
     * @param  string $url
     * @return array
     */
    public function curl($url)
    {
        do {
            $error=false;
            $curl = curl_init($url);
            curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);
            curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, 0);
            curl_setopt($curl, CURLINFO_HEADER_OUT, 1);
            $result = curl_exec($curl);
            $response_code = curl_getinfo($curl, CURLINFO_HTTP_CODE);

            switch ($response_code) {
                case '400':
                    $error= true;
                    echo 'Bad request 400';
                    break;
                case '401':
                    $error= true;
                    echo 'Unauthorized 401';
                    break;
                case '404':
                    $error= true;
                    echo 'Not Found 404';
                    break;
                case '429':
                    $error= true;
                    echo 'Rate limit exceeded 429';
                    break;
                case '500':
                    $error= true;
                    echo 'Internal server error 500';
                    break;
                case '503':
                    $error= true;
                    echo 'Service unavailable 503';
                    break;
            }
            curl_close($curl);

            sleep(5);
        } while ($error);

        return json_decode($result, true);

    }
}
