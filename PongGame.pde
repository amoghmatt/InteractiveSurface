/*
Simple Pong by Gabriel Lovato
https://www.openprocessing.org/sketch/47481
*/

// Altered the key press section with the kinect hand detections
void pongGame() {
  background(255);
  fill(128,128,128);
  pong_diam = 20;
  ellipse(pong_x, pong_y, pong_diam, pong_diam);
  fill(pong_leftColor);
  rect(0, 0, 20, height);
  fill(pong_rightColor);
  rect(width-30, handAvgY - pong_rectSize/2, 10, pong_rectSize);
  if (gameStart) {
    pong_x = pong_x + pong_speedX;
    pong_y = pong_y + pong_speedY;
    // if ball hits paddle bar, invert X direction and apply effects
    if ( pong_x > width-30 && pong_x < width -20 && pong_y > handAvgY - pong_rectSize/2 && pong_y < handAvgY + pong_rectSize/2 ) {
      pong_speedX = pong_speedX * -1;
      pong_x = pong_x + pong_speedX;
      pong_rightColor = 0;
      fill(random(0,128),random(0,128),random(0,128));
      pong_diamHit = random(75,150);
      ellipse(pong_x,pong_y,pong_diamHit,pong_diamHit);
      pong_rectSize = pong_rectSize-10;
      pong_rectSize = constrain(pong_rectSize, 10,150);      
    } 
    // if ball hits wall, change direction of X
    else if (pong_x < 25) {
      pong_speedX = pong_speedX * -1.1;
      pong_x = pong_x + pong_speedX;
      pong_leftColor = 0;
    }
    else {     
      pong_leftColor = 128;
      pong_rightColor = 128;
    }
    // resets things if you lose
    if (pong_x > width) { 
      gameStart = false;
      pong_x = 150;
      pong_y = 150; 
      pong_speedX = random(5, 10);
      pong_speedY = random(3, 5);
      pong_rectSize = 150;
    }  
    // if ball hits up or down, change direction of Y   
    if ( pong_y > height || pong_y < 0 ) {
      pong_speedY = pong_speedY * -1;
      pong_y = pong_y + pong_speedY;
    }
  }  
}

// If hand is not detected. Pause game.
void startGame() {
  if(projectState == "pong") {
   if(!Float.isNaN(handAvgX) && !Float.isNaN(handAvgY)) {
    gameStart = !gameStart;  
   }
  }
}