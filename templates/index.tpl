<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="content-type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Minutizer - Riot API Challenge - 2015</title>
        <link rel="stylesheet" href="assets/css/bootstrap.min.css">
        <link rel="stylesheet" href="assets/css/jquery.easy-pie-chart.css">
        <link rel="stylesheet" href="assets/css/pace.css">

        <link rel="stylesheet/less" type="text/css" href="assets/css/style.less" />
        <script src="assets/js/less.min.js" type="text/javascript"></script>
    </head>
    <body>
        <!-- Render map -->
        <img src="assets/images/sru-high-res.jpg" id="map_preload" class="img-responsive" alt="Summoner Rift Map">
        <!-- Render map | END -->
        <div id="full-content" class="hide">
            <!-- Cover -->
            <div class="container-fluid">
                <header class="row">
                    <div class="col-md-6" id="h-left">
                        <h1 ><span>Minut</span>izer</h1>
                        <p>The <span>Minut</span>izer is a web based application, which is created to represent a randomly selected Black Market Brawlers Game (from all regions) minute by minute.<br /><br />
                            The purpose of the application is to do all of these things interactively instead of just showing raw data.<br /><br />
                            To start the journey, use your mousewheel to scroll or your keyboard navigation buttons!</p>
                    </div>
                    <div class="col-md-6" id="h-right">
                        <div id="h-tips">
                            <img src="assets/images/mouse_scroll.png" alt="Scroll Tip" id="scroll-tip" class="h-tips-sign pull-left"  alt="Mouse Scroll Sign">
                            <img src="assets/images/keybuttons.png" alt="Keyboard Tip" id="keyboard-tip"  class="h-tips-sign " alt="Keyboard Navigation Sign">
                        </div>
                    </div>
                    <div class="clearfix"></div>
                    <div class="col-md-12 text-center" id="copyright">
                        <em>The Minutizer isn’t endorsed by Riot Games and doesn’t reflect the views or opinions of Riot Games or anyone officially involved in producing or managing League of Legends. League of Legends and Riot Games are trademarks or registered trademarks of Riot Games, Inc. League of Legends © Riot Games, Inc.</em>
                    </div>
                </header>
            </div>
            <!-- Cover | END -->

            <!-- Match -->
            <section id="match">
                <a class="side-button" id="side-left"></a>
                <a class="side-button" id="side-right"></a>

                <!-- Left Side -->
                <div class="sides pull-left">
                    {foreach $stats as $stat name=stat}
                        {if $smarty.foreach.stat.index <5}
                            <div class="one-side">
                                <div class="summoner-bobox" style="background-image: url({$stat['splash']});"></div>
                                <div class="summoner-icon-bobox pull-left" style="background-image: url({$stat['icon']});">
                                    <div class="stats level" id="stat-level-{$smarty.foreach.stat.index+1}">Lv: 0</div>
                                </div>
                                <div class="stat-bg">
                                    <div class="kdamg">
                                        <img src="assets/images/k_icon.png" alt="Kill" class="pull-left kda_icon img-responsive"  alt="Kill Icon"/>
                                        <span class="stats" id="stat-kill-{$smarty.foreach.stat.index+1}"> Kill: 0</span>
                                        <div class="clearfix"></div>
                                        <img src="assets/images/d_icon.png" alt="Death" class="pull-left kda_icon img-responsive" alt="Death Icon"/>
                                        <span class="stats" id="stat-death-{$smarty.foreach.stat.index+1}"> Death: 0</span>
                                        <div class="clearfix"></div>
                                        <img src="assets/images/a_icon.png" alt="Assist" class="pull-left kda_icon img-responsive"  alt="Assist Icon"/>
                                        <span class="stats" id="stat-assist-{$smarty.foreach.stat.index+1}"> Assist: 0</span>
                                        <div class="clearfix"></div>
                                        <img src="assets/images/m_icon.png" alt="Minion" class="pull-left kda_icon img-responsive" alt="Minion Icon"/>
                                        <span class="stats" id="stat-minion-{$smarty.foreach.stat.index+1}"> Minion: 0</span>
                                        <div class="clearfix"></div>
                                        <img src="assets/images/g_icon.png" alt="Gold" class="pull-left kda_icon img-responsive" alt="Gold Icon"/>
                                        <span class="stats" id="stat-gold-{$smarty.foreach.stat.index+1}"> Total Gold: 0</span>
                                    </div>

                                    <div class="items" id="items-{$smarty.foreach.stat.index+1}"></div>
                                    <span class="trinkets" id="trinket-{$smarty.foreach.stat.index+1}"></span>
                                    <div class="brawler" id="brawler-{$smarty.foreach.stat.index+1}"></div>
                                </div>
                                <div class="spells">
                                    <img src="{$stat['spells'][1]['imageUrl']}"  alt="Spell Icon"/>
                                    <img src="{$stat['spells'][0]['imageUrl']}" alt="Spell Icon"/>
                                </div>
                            </div>
                        {/if} 
                    {/foreach}
                </div>
                <!-- Left Side | END -->

                <!-- MAP -->
                <div id="map" class="pull-left">
                    <div id="top-stats">
                        <div id="randomize-btn" class="side-buttons"><a href=""><img src="assets/images/dice.png"  alt="Dice"> Randomize</a></div>
                        <div id="jump-btn" class="side-buttons"><a><span id="to-stats"></span> Jump to stats</a></div>
                        <div class="col-md-8 col-md-offset-2">
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="row">
                                        <div id="wing-blue" class="col-md-4 side-blue stat-panel stat-wing">
                                            <div id="gold-blue" class="wing-value value-gold"><img src="assets/images/coins.png" alt="Gold" class="pull-left kda_icon img-responsive" alt="Coin Icon"/> 0</div>
                                            <div id="dragon-blue" class="wing-value value-dragon"><img src="assets/images/dragon_icon.png" alt="Drag Icon"> 0</div>
                                            <div id="baron-blue" class="wing-value value-baron"><img src="assets/images/baron_icon.png" alt="Baron Icon"> 0</div>
                                        </div>
                                        <div id="stat-center" class="col-md-4 stat-panel">
                                            <div id="perc">0:00</div>
                                            <div id="kills-blue" class="stat-kills">0</div>

                                            <div id="kills-red" class="stat-kills">0</div>
                                        </div>
                                        <div id="wing-red" class="col-md-4 side-red stat-panel stat-wing text-right">
                                            <div id="baron-red" class="wing-value value-baron"><img src="assets/images/baron_icon.png" alt="Baron Icon"> 0</div>
                                            <div id="dragon-red" class="wing-value value-dragon"><img src="assets/images/dragon_icon.png" alt="Drag Icon"> 0</div>
                                            <div id="gold-red" class="wing-value value-gold"><img src="assets/images/coins.png" alt="Gold" class="pull-left kda_icon img-responsive" alt="Coin Icon"/> 0</div>
                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Map | END -->

                <!-- Right Side -->
                <div class="sides pull-left">
                    {foreach $stats as $stat name=stat}
                        {if $smarty.foreach.stat.index >4}
                            <div class="one-side">
                                <div class="summoner-bobox" style="background-image: url({$stat['splash']})"></div>
                                <div class="summoner-icon-bobox pull-left"
                                     style="background-image: url({$stat['icon']});-webkit-box-shadow: inset 0px 0px 0px 0px, 0px 0px 0px 3px red;-moz-box-shadow: inset 0px 0px 0px 0px, 0px 0px 0px 3px red;box-shadow: inset 0px 0px 0px 0px, 0px 0px 0px 3px red;">
                                    <div class="stats level" id="stat-level-{$smarty.foreach.stat.index+1}">Lv: 0</div>
                                </div>
                                <div class="stat-bg">
                                    <div class="kdamg">
                                        <img src="assets/images/k_icon.png" alt="Kill Icon" class="pull-left kda_icon img-responsive"/>
                                        <span class="stats kill" id="stat-kill-{$smarty.foreach.stat.index+1}"> Kill: 0</span>
                                        <div class="clearfix"></div>
                                        <img src="assets/images/d_icon.png" alt="Death Icon" class="pull-left kda_icon img-responsive"/> 
                                        <span class="stats death" id="stat-death-{$smarty.foreach.stat.index+1}"> Death: 0</span>
                                        <div class="clearfix"></div>
                                        <img src="assets/images/a_icon.png" alt="Assist Icon" class="pull-left kda_icon img-responsive"/>
                                        <span class="stats assist" id="stat-assist-{$smarty.foreach.stat.index+1}"> Assist: 0</span>
                                        <div class="clearfix"></div>
                                        <img src="assets/images/m_icon.png" alt="Minion Icon" class="pull-left kda_icon img-responsive"/>
                                        <span class="stats minion" id="stat-minion-{$smarty.foreach.stat.index+1}"> Minion: 0</span>
                                        <div class="clearfix"></div>
                                        <img src="assets/images/g_icon.png" alt="Gold Icon" class="pull-left kda_icon img-responsive"/>
                                        <span class="stats gold" id="stat-gold-{$smarty.foreach.stat.index+1}"> Total Gold: 0</span>
                                    </div>

                                    <div class="items" id="items-{$smarty.foreach.stat.index+1}">
                                    </div>
                                    <span class="trinkets" id="trinket-{$smarty.foreach.stat.index+1}">
                                    </span>
                                    <div class="brawler" id="brawler-{$smarty.foreach.stat.index+1}"></div>
                                </div>
                                <div class="spells">
                                    <img src="{$stat['spells'][1]['imageUrl']}"  alt="Spell Icon"/>
                                    <img src="{$stat['spells'][0]['imageUrl']}"  alt="Spell Icon"/>
                                </div>
                            </div>
                        {/if}
                    {/foreach}
                </div>
                <!-- Right Side | END -->

            </section>
            <!-- Match | END-->

            <!-- FOOTER -->
            <footer>
                <div id="collapse-button" style="display:none;"></div>
                <div class="container">
                    <div class="row">
                        <h1 class="text-center" id="footer-header">Black Market Brawlers Games Statistics</h1>
                        {foreach $gameover['brawlers'] as $braw name=braw}
                            <div class="col-md-3 text-center">
                                <div>
                                    <img src="{$braw['image']}" class="brawler-icon" data-toggle="tooltip" data-html="true" data-placement="bottom" data-original-title="{$braw['desc']}" alt="{$braw['name']}"/>
                                </div>
                                <div class="brawler-name">{$braw['name']}</div>
                                <div class="chart" data-percent="{$braw['rate']}" style="position:relative;">
                                    <span style="position: absolute;margin-left: auto;margin-right: auto;top:30px;left: 0;right: 0;font-weight: bold;"
                                          class="text-center">{$braw['rate']} %</span>
                                </div>
                            </div>
                        {/foreach}
                    </div>
                    <div class="row">
                        <div class="col-md-3 item-col">
                            {foreach $gameover['items'] as $item name=item}
                                {if $smarty.foreach.item.index < 4}
                                    <div class="ic-block">
                                        <div class="item-top">
                                            <span class="item-chart pull-left" data-percent="{$item['rate']}" style="position:relative;"></span>
                                            <span class="ic-percentage text-center">{$item['rate']}</span><span class="perce-mark"> %</span>
                                        </div>
                                        <div class="item-bottom text-center">
                                            <span>
                                                <img src="{$item['image']}" class="item-icon"  data-toggle="tooltip" data-html="true" data-placement="top" data-original-title="{$item['desc']}" alt="{$item['name']}"/>
                                            </span>
                                            <span class="item-name">{$item['name']}</span>
                                        </div>
                                    </div>
                                {/if}
                            {/foreach}
                        </div>

                        <div class="col-md-3 item-col">
                            {foreach $gameover['items'] as $item name=item}
                                {if $smarty.foreach.item.index >= 4 && $smarty.foreach.item.index < 8}
                                    <div class="ic-block">
                                        <div class="item-top">
                                            <span class="item-chart pull-left" data-percent="{$item['rate']}" style="position:relative;"></span>
                                            <span class="ic-percentage text-center">{$item['rate']}</span><span class="perce-mark"> %</span>
                                        </div>
                                        <div class="item-bottom text-center">
                                            <span>
                                                <img src="{$item['image']}" class="item-icon"  data-toggle="tooltip" data-html="true" data-placement="top" data-original-title="{$item['desc']}" alt="{$item['name']}"/>
                                            </span>
                                            <span class="item-name">{$item['name']}</span>
                                        </div>
                                    </div>
                                {/if}
                            {/foreach}
                        </div>

                        <div class="col-md-3 item-col">
                            {foreach $gameover['items'] as $item name=item}
                                {if $smarty.foreach.item.index >= 8 && $smarty.foreach.item.index < 12}
                                    <div class="ic-block">
                                        <div class="item-top">
                                            <span class="item-chart pull-left" data-percent="{$item['rate']}" style="position:relative;"></span>
                                            <span class="ic-percentage text-center">{$item['rate']}</span><span class="perce-mark"> %</span>
                                        </div>
                                        <div class="item-bottom text-center">
                                            <span>
                                                <img src="{$item['image']}" class="item-icon"  data-toggle="tooltip" data-html="true" data-placement="top" data-original-title="{$item['desc']}" alt="{$item['name']}"/>
                                            </span>
                                            <span class="item-name">{$item['name']}</span>
                                        </div>
                                    </div>
                                {/if}
                            {/foreach}
                        </div>

                        <div class="col-md-3 item-col">
                            {foreach $gameover['items'] as $item name=item}
                                {if $smarty.foreach.item.index >= 12}
                                    <div class="ic-block">
                                        <div class="item-top">
                                            <span class="item-chart pull-left" data-percent="{$item['rate']}" style="position:relative;"></span>
                                            <span class="ic-percentage text-center">{$item['rate']}</span><span class="perce-mark"> %</span>
                                        </div>
                                        <div class="item-bottom text-center">
                                            <span>
                                                <img src="{$item['image']}" class="item-icon"  data-toggle="tooltip" data-html="true" data-placement="top" data-original-title="{$item['desc']}" alt="{$item['name']}"/>
                                            </span>
                                            <span class="item-name">{$item['name']}</span>
                                        </div>
                                    </div>
                                {/if}
                            {/foreach}
                        </div>
                    </div>
                </div>
            </footer>
            <!-- FOOTER | END -->
        </div>

        <script src="assets/js/jquery.min.js"></script>
        <script src="assets/js/d3.v3.min.js"></script>
        <script src="assets/js/bootstrap.min.js"></script>
        <script src="assets/js/jquery.easypiechart.min.js"></script>
        <script src="assets/js/pace.min.js"></script>

        {literal}
            <script type="text/javascript">

                $(function () {
                    Pace.on('hide', function () {
                        $('#full-content').removeClass('hide');
                    });
                    
                    /* First draw of the map */
                    var pre_map = $('#map_preload');
                    var i = 0;

                     /* Init domain map */
                    var cords = {/literal}{$coordinates}{literal},
                            domain = {
                                min: {x: -1670, y: -720},
                                max: {x: 15700, y: 16500}
                            },
                    width = pre_map.width(),
                            height = pre_map.height(),
                            bg = "assets/images/sru-high-res.jpg",
                            xScale, yScale, svg;

                    xScale = d3.scale.linear()
                            .domain([domain.min.x, domain.max.x])
                            .range([0, width]);

                    yScale = d3.scale.linear()
                            .domain([domain.min.y, domain.max.y])
                            .range([height, 0]);
                    cord_trans(i, cords, width, height, bg, xScale, yScale);
                    $('.sides').width(($(window).width() - width) / 2);
                    /* Init domain map - END */

                    /* Variables */
                    var body = $('body');
                    var footer = $('footer');
                    var header = $('header');
                    var allKills1 = 0;
                    var allKills2 = 0;
                    var goldRed = 0;
                    var goldBlue = 0;
                    var dragonBlue = 0;
                    var dragonRed = 0;
                    var baronRed = 0;
                    var baronBlue = 0;
                    var stats ={/literal}{$jstats}{literal};
                    var scrollCount = 1;
                    var brawMins = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
                    var winner = '{/literal}{$winner}{literal}';
                    /* Variables - END */

                    /* Init footer offset */
                    footer.css('right', -$(window).width());
                    /* Init - END */

                    $('[data-toggle="tooltip"]').tooltip({container: 'body'});

                    /* Scroll to infinity and beyond */
                    body.bind('mousewheel DOMMouseScroll onmousewheel touchmove scroll keydown', function (e) {

                        var theEvent = e.originalEvent.wheelDelta || e.originalEvent.detail * -1 || e.which;

                        if (theEvent == 120 || theEvent == 3 || theEvent == 38) {
                            /* Scroll up */
                            if (scrollCount == 2) {
                                header.animate({
                                    top: 0
                                }, 1000);
                            } else if (scrollCount == cords.length + 2) {
                                footer.animate({
                                    right: -body.width()
                                }, 1000);
                            }
                            if (scrollCount > 1) {
                                scrollCount -= 1;
                            }
                        } else if (theEvent == -120 || theEvent == -3 || theEvent == 40) {
                            /* Scroll down */
                            if (scrollCount == 1) {
                                header.animate({
                                    top: -header.height()
                                }, 1000);
                            }
                            if (scrollCount < cords.length + 2) {
                                scrollCount += 1;
                            }
                        }

                        if (scrollCount < cords.length + 2) {
                            if ((theEvent == -120 || theEvent == -3 || theEvent == 40) && i < cords.length && scrollCount > 2) {
                                ++i;
                            } else if ((theEvent == 120 || theEvent == 3 || theEvent == 38) && i > 0 && scrollCount < cords.length + 1 && scrollCount >= 2) {
                                --i;
                            }
                            $.each(stats, function (index, value) {
                                $('#stat-kill-' + index).html(' Kill: ' + value['timeline'][i]['kills']);
                                $('#stat-death-' + index).html(' Death: ' + value['timeline'][i]['death']);
                                $('#stat-assist-' + index).html(' Assist: ' + value['timeline'][i]['assists']);
                                $('#stat-minion-' + index).html(' Minion: ' + value['timeline'][i]['minionsKilled']);
                                $('#stat-gold-' + index).html(' Total Gold: ' + value['timeline'][i]['gold']);
                                $('#stat-level-' + index).text('Lv: ' + value['timeline'][i]['level']);

                                $('#items-' + index).add($('#trinket-' + index)).text('');

                                if (i < brawMins[index] && brawMins[index] !== 0) {
                                    $('#brawler-' + index).html('');
                                }
                                if (typeof value['timeline'][i]['brawler_image'] !== 'undefined') {
                                    $('#brawler-' + index).html('<img src="' + value['timeline'][i]['brawler_image'] + '" height="50px" width="50px" data-toggle="tooltip" data-placement="bottom" title="' + value['timeline'][i]['brawler_name'] + '" data-original-title="' + value['timeline'][i]['brawler_name'] + '"/>');
                                    brawMins[index] = i;
                                }

                                if (typeof value['timeline'][i]['items'] !== 'undefined') {
                                    $.each(value['timeline'][i]['items'], function (ind, item) {
                                        if (item['id'] == 2003 || item['id'] == 2004 || item['id'] == 2010 || item['id'] == 2043 || item['id'] == 2044) {
                                            $('#items-' + index).append('<div class="item-image item-potion"><img src="' + item['imageUrl'] + '" height="31px" width="31px" class="hidden-items pot-' + item['id'] + '" data-toggle="tooltip" data-placement="top" title="' + item['name'] + '" data-original-title="' + item['name'] + '" /></div>');
                                        } else if (item['id'] == 3340 || item['id'] == 3341 || item['id'] == 3342 || item['id'] == 3361 || item['id'] == 3362 || item['id'] == 3363 || item['id'] == 3364) {
                                            $('#trinket-' + index).append('<div class="item-image"><img src="' + item['imageUrl'] + '" height="31px" width="31px" data-toggle="tooltip" data-placement="top" title="' + item['name'] + '"  data-original-title="' + item['name'] + '"/></div>');
                                        } else {
                                            $('#items-' + index).append('<div class="item-image"><img src="' + item['imageUrl'] + '" height="31px" width="31px" data-toggle="tooltip" data-placement="top" title="' + item['name'] + '" data-original-title="' + item['name'] + '" /></div>');
                                        }
                                    });
                                    $('[data-toggle="tooltip"]').tooltip({container: 'body'});
                                }

                                if (index - 1 < 5) {
                                    allKills1 = allKills1 + parseInt(value['timeline'][i]['kills']);
                                    goldBlue = goldBlue + parseInt(value['timeline'][i]['gold']);
                                    dragonBlue = dragonBlue + parseInt(value['timeline'][i]['dragons']);
                                    baronBlue = baronBlue + parseInt(value['timeline'][i]['barons']);
                                } else {
                                    allKills2 = allKills2 + parseInt(value['timeline'][i]['kills']);
                                    goldRed = goldRed + parseInt(value['timeline'][i]['gold']);
                                    dragonRed = dragonRed + parseInt(value['timeline'][i]['dragons']);
                                    baronRed = baronRed + parseInt(value['timeline'][i]['barons']);
                                }
                                showQty('#items-' + index + ' .pot-2003');
                                showQty('#items-' + index + ' .pot-2004');
                                showQty('#items-' + index + ' .pot-2010');
                                showQty('#items-' + index + ' .pot-2043');
                                showQty('#items-' + index + ' .pot-2044');
                                $('.item-potion').remove();
                            });

                            $('#kills-blue').text(allKills1);
                            $('#kills-red').text(allKills2);
                            allKills1 = 0;
                            allKills2 = 0;

                            $('#gold-blue').html('<img src="assets/images/coins.png" alt="Gold" class="pull-left kda_icon img-responsive"/> ' + Math.round(goldBlue * 100.0 / 1000) / 100 + " K");
                            $('#gold-red').html('<img src="assets/images/coins.png" alt="Gold" class="pull-left kda_icon img-responsive"/> ' + Math.round(goldRed * 100.0 / 1000) / 100 + " K");
                            goldBlue = 0;
                            goldRed = 0;

                            $('#dragon-blue').html('<img src="assets/images/dragon_icon.png"> ' + dragonBlue);
                            $('#dragon-red').html('<img src="assets/images/dragon_icon.png"> ' + dragonRed);
                            dragonRed = 0;
                            dragonBlue = 0;

                            $('#baron-blue').html('<img src="assets/images/baron_icon.png"> ' + baronBlue);
                            $('#baron-red').html('<img src="assets/images/baron_icon.png"> ' + baronRed);
                            baronBlue = 0;
                            baronRed = 0;

                            $('#perc').text(i + ':00');
                            if (i < cords.length) {
                                $('.kills').fadeOut(250, function () {
                                    $(this).remove();
                                    $('svg').remove();
                                    cord_trans(i, cords, width, height, bg, xScale, yScale);
                                });
                            }

                            if (scrollCount == cords.length + 1) {
                                $('.one-side').css('z-index', '-999999');
                                if (winner == 'blue') {
                                    $('.sides:first-of-type').addClass('winner');
                                    $('.sides:last-of-type').addClass('looser');
                                } else {
                                    $('.sides:first-of-type').addClass('looser');
                                    $('.sides:last-of-type').addClass('winner');
                                }
                            } else {
                                $('.one-side').css('z-index', '1');
                                $('.sides').removeClass('winner looser');
                            }
                            ;
                        } else if (scrollCount >= cords.length + 2 && footer.css('right') !== '0px') {
                            if (theEvent == -120 || theEvent == -3 || theEvent == 40) {
                                footer.animate({
                                    right: "0"
                                }, 1000, function () {
                                    $('footer .container').fadeIn(100, function () {
                                        $('.chart').easyPieChart({
                                            size: 80,
                                            animate: 2000,
                                            lineCap: 'square',
                                            scaleColor: false,
                                            trackColor: '#2b73a3',
                                            barColor: '#FFF',
                                            lineWidth: 10
                                        });
                                        $('.item-chart').easyPieChart({
                                            size: 60,
                                            animate: 2000,
                                            lineCap: 'square',
                                            scaleColor: false,
                                            trackColor: '#2b73a3',
                                            barColor: '#FFF',
                                            lineWidth: 10
                                        });
                                    });
                                });
                            }
                        }
                    });
                    /* Scroll to infinity and beyond - Finaly ended */

                    /* Hover zoom on circles */
                    $(document).on({
                        mouseenter: function () {
                            $(this).attr('r', '30');
                            $('.' + $(this).attr('id') + ' image').attr({'width': '60', 'height': '60'});
                        },
                        mouseleave: function () {
                            $(this).attr('r', '15');
                            $('.' + $(this).attr('id') + ' image').attr({'width': '30', 'height': '30'});
                        }
                    }, "circle");
                    /* Hover zoom on circles - END */

                    $("#side-left").click(function () {
                        $(".sides:first-of-type").slideToggle("slow", function () {
                        });
                    });
                    
                    $("#side-right").click(function () {
                        $(".sides:last-of-type").slideToggle("slow", function () {
                        });
                    });

                    $("#jump-btn").click(function () {
                        footer.animate({
                            right: "0"
                        }, 1000);
                        footer.find('#collapse-button').show();
                        $('.chart').easyPieChart({
                            size: 80,
                            animate: 2000,
                            lineCap: 'square',
                            scaleColor: false,
                            trackColor: '#2b73a3',
                            barColor: '#FFF',
                            lineWidth: 10
                        });
                        $('.item-chart').easyPieChart({
                            size: 60,
                            animate: 2000,
                            lineCap: 'square',
                            scaleColor: false,
                            trackColor: '#2b73a3',
                            barColor: '#FFF',
                            lineWidth: 10
                        });
                    });
                    $("#collapse-button").click(function () {
                        footer.animate({
                            right: -body.width()
                        }, 1000);
                        $(this).hide();
                    });

                });

                /* FUNCTIONS */
                /**
                 * Show item quantities
                 * @param  selector
                 * @return nop
                 */
                function showQty(selector) {
                    if ($(selector).length > 0) {
                        $(selector).first().show().parent().removeClass('item-potion');
                        if ($(selector).length > 1) {
                            $(selector).first().parent().append('<div class="qty">' + $(selector).length + '</div>');
                        }
                    }
                }

                /* Draw */
                function cord_trans(i, cords, width, height, bg, xScale, yScale) {
                    $('.tooltip').remove();
                    svg = d3.select("#map")
                            .append("svg:svg")
                            .attr({"width": width, "height": height});

                    svg.append('image')
                            .attr({'xlink:href': bg, 'x': '0', 'y': '0', "width": width, "height": height});

                    svg.append('svg:g').selectAll("circle")
                            .data(cords[i])
                            .enter().append("svg:circle")
                            .attr({'cx': function (d) {
                                    return xScale(d[0]);
                                }, 'cy': function (d) {
                                    return yScale(d[1]);
                                }, 'r': 15, 'title': function (d) {
                                    return d[2];
                                }, 'data-toggle': 'tooltip', 'data-placement': 'top', 'id': function (d) {
                                    return 'circle-' + d[5] + '-' + d[4];
                                }, 'class': 'kills', 'fill': function (d) {
                                    return 'url(#' + d[5] + '-' + d[4] + ')';
                                }, 'stroke': function (d) {
                                    if (d[4] == 'blue') {
                                        return 'rgb(0, 132, 255)';
                                    } else {
                                        return 'red';
                                    }
                                }, 'stroke-width': '1.5'})
                            .style({"opacity": 0, "filter": "alpha(opacity=0)", "-ms-filter": "progid:DXImageTransform.Microsoft.Alpha(Opacity=0)", "-moz-opacity": 0, "-khtml-opacity": 0})
                            .transition()
                            .style({"opacity": 1, "filter": "alpha(opacity=100)", "-ms-filter": "progid:DXImageTransform.Microsoft.Alpha(Opacity=100)", "-moz-opacity": 1, "-khtml-opacity": 1})
                            .duration(250);

                    svg.selectAll("circle").on("mouseover", function (d) {
                        svg.selectAll("circle").sort(function (a, b) {
                            if (a != d)
                                return -1;
                            else
                                return 1;
                        });
                    });

                    d3.select("g").append('defs').selectAll("pattern").data(cords[i]).enter()
                            .append('g:pattern')
                            .attr({'id': function (d) {
                                    return d[5] + '-' + d[4];
                                }, 'class': function (d) {
                                    return 'circle-' + d[5] + '-' + d[4];
                                }, 'patternUnits': 'objectBoundingBox', 'width': 30, 'height': 30})
                            .append('g:image')
                            .attr({'xlink:href': function (d) {
                                    return d[3];
                                }, 'x': 0, 'y': 0, 'width': 30, 'height': 30})
                            .style({"opacity": 0, "filter": "alpha(opacity=0)", "-ms-filter": "progid:DXImageTransform.Microsoft.Alpha(Opacity=0)", "-moz-opacity": 0, "-khtml-opacity": 0})
                            .transition()
                            .style({"opacity": 1, "filter": "alpha(opacity=100)", "-ms-filter": "progid:DXImageTransform.Microsoft.Alpha(Opacity=100)", "-moz-opacity": 1, "-khtml-opacity": 1})
                            .duration(250);

                    $('[data-toggle="tooltip"]').tooltip({container: 'body'});
                }
                /* Draw - END */
            </script>
        {/literal}
    </body>
</html>