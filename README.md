# Tank-Wars-Game
The classic tank wars game programmed in Common Lisp

Important: The comments and the name of all functions are written in Catalan, however i will do my best to translate it to you into English.
If you have any trouble with the execution do not hesitate to contact me

Instructions:

1. In order to execute the code you need to install XLisp (i'm currently using the version 3.04)

2. Download the file "canons.lsp" and place it to your XLisp folder.

3. To load the file tpye: (load 'canons)

How to play the game:


There are 2 players who control each tank/canyon.

First player is called cano (cano means canyon in catalan)

Second player is called cano2

The whole game can be played with these four functions

1.(pinta)

This function initializes the scenery, paints all the elements and place the writing cursor at the top left of the screen where players will enter the instructions.
The default inclination of both canyons is set to 60º.
This function has to be executed at the beginning of the game and only need to be run once.
Once executed, the game should look something like this:

![](images/initial.PNG)

As you can see there are the 2 tanks, the mountains and the arrow at the top left indicates the wind speed and direction

2.(simula 'canyonname speed)

This function given a canyon name (either cano or cano2) and the speed of the shot, calculates and draws the trajectory of the projectile.

![](images/simula.PNG)

In this example, the first canyon shoots a projectile with a speed of 20.

3.(puja 'canyonname degrees)

"puja" means "rise/increase" in catalan.
This function increases the angle of the canyon.

![](images/puja.PNG)

Since the initial angle is 60º, if we increase the angle by 30 we got the canyon looking at 90º

4.(baixa 'canyonname degrees)

This function does the same as the 3rd function but the other way around
