// Variables for 2 Player Pong Game
PImage pong2Img;
int pong2ballDiameter = 15;
float pong2Xpos, pong2Ypos;
float pong2Xspeed = random(5,6);
float pong2Yspeed = random(0,4);
int pongScore1=0;
int pongScore2=0;
int player1Pos;
int player2Pos;

// Function to initialise the variables
void loadPong2() {
 pongScore1=0;
 pongScore2=0;
 player1Pos = height/2;
 player2Pos = height/2;
 pong2Xpos = width/2;
 pong2Ypos = height;
 pong2Xspeed = random(5,6);
 pong2Yspeed = random(0,4);
}

void pong2Game() {
  background(80);
  fill(255);
  textSize(headingFontSize);
  text(str(pongScore2)+" : "+str(pongScore1), width/2, 0.1*height);
  
  // Detect the player on the right side of the screen
  rightHand();
  // Detect the player on the left side of the screen
  leftHand();
  if(!Float.isNaN(leftAvgX) && !Float.isNaN(leftAvgY) && !Float.isNaN(rightAvgX) && !Float.isNaN(rightAvgY)) { // Check if both players are detected. Else do not continue with the game.
    
    player1Pos = int(leftAvgY);
    player2Pos = int(rightAvgY);
    
    pong2Xspeed *= 1.001;
    pong2Xpos += pong2Xspeed;
    pong2Ypos += pong2Yspeed; 
    
    // Height Edge Detection 
    if (pong2Ypos > height - (pong2ballDiameter/2) || pong2Ypos < 0 + (pong2ballDiameter/2)) {
     pong2Yspeed *= -1;
   }
   
   // Player 1 Padde Hit Detection
   if ( pong2Xpos <= 30 + (pong2ballDiameter/2)) {
     if (pong2Ypos > player1Pos - 100 && pong2Ypos < player1Pos + 100){
       pong2Xspeed *= -1;
       pong2Yspeed += (pong2Ypos - player1Pos)/5;
     }
   }
   //Player 1
   if (pong2Xpos <= 0){
     pongScore1 += 1;
     if (pongScore1 <= 4){
       pong2Xpos = 50;
       pong2Ypos = player1Pos;
       pong2Xspeed = random(5,6);
       pong2Yspeed = 0; 
       textAlign(CENTER);
     }
     if (pongScore1 ==5) {
       text("Player 2 wins: "+ str(pongScore2), width/2, 0.1*height + 20);
     }
   }
   
   // Player 2 Paddle Hit Detection
   if ( pong2Xpos >= width - 30 - pong2ballDiameter/2) {
     if (pong2Ypos > player2Pos - 100 && pong2Ypos < player2Pos + 100){
       pong2Xspeed *= -1;
       pong2Yspeed += (pong2Ypos-player2Pos)/5;
     }
   }
   
   //Player 2
   if (pong2Xpos >= width){
     pongScore2 +=1 ;
     if (pongScore2 <= 4){
       pong2Xpos = width - 50;
       pong2Ypos = player2Pos;
       pong2Xspeed = -random(5,6);
       pong2Yspeed = 0; 
     } 
     if (pongScore2 ==5) {
       text("Player 1 wins: "+ str(pongScore1), width/2, 0.1*height + 20);
     }
   }
   
   //Increment the position of the ball
   ellipse(pong2Xpos, pong2Ypos, pong2ballDiameter, pong2ballDiameter);
   
   // Draw the paddles
   rect (10, player1Pos - 50,20,200);
   rect (width-30, player2Pos - 50,20,200);
   
   //Update the positions of the paddles
   player1Pos = int(rightAvgY);
   player2Pos = int(leftAvgY);
   
  }
}