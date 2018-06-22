# InteractiveSurface
Interactive Projected Surface controlled by hovering your hand over the projection, detected via a Kinect.

Demo Video: https://youtu.be/dA5SCVDZzOg

The project consists of an application designed via processing which is projected onto a surface. The hand movement detection is done via a Microsoft Kinect V1. The application displays an interactive screen consisting of an animation of the day’s weather along with the details and the forecast for the next seven days, the top ten headlines from BBC news and a games folder. All of which can be interacted with by waving the hand over the projection.

## Games / Interactions

There are four games programmed in the code. The Tank Wars game which was part of our second assignment in IDMT on the topic of processing is included to bring about a feeling of nostalgia. The Tank Wars game was altered to include the controls in a bar below. The keyboard controls of the initial tank wars game have been altered to detect the hand location over the control bar. Hovering your hand on the left and right buttons are programmed to alter the tank’s firing angle, the up and down buttons are programmed to alter the strength of the projectile and a launch button has been included to fire the projectile. Each of the two player uses the same controls to alter the values, but only the player indicated on the screen can use the controls at any given moment.

The random art game is an incorporation of a processing sketch taught by Fabio Morreale (f.morreale@qmul.ac.uk). The sketch which incorporates the randomness of the random function to generate a generative art is altered to be triggered by the detection of motion over the projection.
The single player pong game is developed over the open-processing sketch programmed by Gabriel Lovato (https://www.openprocessing.org/sketch/47481). While most of the game physics remains unaltered, the movement of the paddle has been altered to include the Kinect sensor. The average Y coordinates of the movement detected are used as the position of the paddle. The game has also been upgraded so that it pauses if the hand/ object is not detected. The game continues from the same state once the hand/object is detected back in the frame.

The two player pong game is an extension of the single player pong game. One major difference is that in this, not one but, two hands/objects are detected on either side of the screen. The Kinect detection is altered to incorporate an average X and Y coordinates for the movement detected on the left half of the screen as well as another set of coordinates for the right half of the screen. Similar to single player pong, the game pauses if either of the players is not detected on the screen. The game continues once both the players are detected.

One the main intentions of developing this application were to project it onto a table and use it to play normal table sports. For this purpose, I programmed a ping pong table layout along with a depth-sensing algorithm that detects the motion of the ping pong ball over the table. The motion of the ping pong ball is detected when in motion and an animation is created along the trail followed by the ball.
