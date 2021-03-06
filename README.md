# For the other participants
https://www.youtube.com/watch?v=ZXsQAXx_ao0
# What's this?
This is our entry to the RIOT GAMES API CHALLENGE 2.0 : Black Market Brawlers category.
#What is it about?
The Minutizer is a web based application, which is created to represent a randomly selected Black Market Brawlers Game (from all regions) minute by minute. 

Using the application you can follow how the matches are developing, and how and when the teams prefered their items, and brawlers choose because of the circumtances. The purpose of the application is to do all of these things interactively instead of just showing raw data. 

Why would you read raw data, when you can 'play' it how the matches took place in the event! You only have to scroll with your mouse (or navigate with the keyboard) and experience the legendary bloody battles!

Let's scroll!
# How to use?
Opening the application, you find a short instruction, which you can leave by scrolling or with the help of the navigation buttons, that will take you to the game itself. After this you don't have to do other, just lean back and rush in time, back and forth, like Ekko does!

When you reach the end of the match, you will know which team won, and with the next scroll you can check the ratio of the most frequent items bought in the Black Market. You can reach this page by clicking on the 'Jump to stats' button next to the timeline.

Did you finished the match, but you'd watch more? Next to the timeline, on the left side you can find the "Randomize" button, which will generate a new match for you.

# If you'd like to setup our project

1. Edit this file: db/db_connection.php
2. Create a database
3. Import the SQL from the file: db/db_sql.rar (extract it before you gonna work with that)

If you want to try out the generator.php too (to create the database tables from scratch), don't forget to modify the api_key.php and replace the key with your own.

# Under the hood (short)
We are keeping the datas and the statistics of the matches in a database. These processes are transacted by the generator.php. It processes all the matches one by one and keeps just the data what we need. Because of that the pages loading time significantly reduces.
#Technologies
- PHP - PHP manages the datas, and places them into the database. The final outputs are stored in Smarty variables. - http://php.net/
- Smarty - The available datas processed by Smarty Template Engine, and this is what we used for the front end. - http://www.smarty.net/
- Data-Driven Documents - The manipulation of the SVG element runned by D3JS. - http://d3js.org/
- Easy Pie Chart - http://rendro.github.io/easy-pie-chart/
- Bootstrap - http://getbootstrap.com/
- jQuery - https://jquery.com/
- LESS - http://lesscss.org/
- Pace - http://github.hubspot.com/pace/docs/welcome/

# Recommended Resolution:
1920x1080

(This doesn't mean you can't check it on other resolutions, but this is the most optional one. As much as we could, we tried to make it responsive, but because of the short time, and technological barriers, it couldn't be done. It's a "To Do" from here.)

# To Do List
- FULL RESPONSIVE
- Because the application itself is independent from the Bilgewater Event (on the code side), so normal games can be easily representated as well. So later there could be even a "last game by summoner name" thing.

# Licence
We dont have any.
