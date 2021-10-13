# Tank-Wars-Game
The classic tank wars game programmed in Lisp

Disclaimer: The comments and the name of all functions are written in Catalan, however i will do my best to translate it to you into English

Instructions:

1. In order to execute the code you need to install XLisp (i'm currently using the version 3.04)

2. To load the file tpye: (load 'canons)

How to play the game:


There are 2 players who control each tank/canyon.
First player is called cano (cano means canyon in english)
Second player is called cano2

The whole game can be played with these four functions

1.(pinta)
This function initializes the scenery, paints all the elements and place the writing cursor at the top left of the screen where players will enter the instructions.
It has to be executed at the beginning of the game and only need to be run once.
Once executed, the game should look something like this:



2.(simula canyonname speed)
This function given a canon name (either cano or cano2) and the speed of the shot, calculates and draws the trajectory of the projectile.
