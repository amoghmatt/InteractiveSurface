boolean handOverLeftButton = false;
boolean handOverRightButton = false;
boolean handOverUpButton = false;
boolean handOverDownButton = false;
boolean handOverLaunchButton = false;

void loadGround() {
  // Initialize the ground level
  tankwarsGroundLevel = new float[width];
//  player1Height = random(height/2, height-5);
//  player2Height = random(height/2, height-5);
  player1Height = random(height/2, height-100);
  player2Height = random(height/2, height-100);
  for (float i = 0; i < width * 0.2; i++) {
    tankwarsGroundLevel[(int)i] = player1Height;
  }
  for (float i = width * 0.2; i < width * 0.8; i++) {
    tankwarsGroundLevel[(int)i] = player1Height + (player2Height - player1Height) * (i - width*0.2)/(width*0.6);
  }
  for (float i = width * 0.8; i < width; i++) {
    tankwarsGroundLevel[(int)i] = player2Height;
  }    
  
}

void loadControlImages() {
  rightImg = loadImage("images/forward.png");
  rightImg.resize(250,50);
  rightImg.filter(GRAY);
  rightImg.filter(INVERT);
   
  leftImg = loadImage("images/back.png");
  leftImg.resize(250,50);
  leftImg.filter(GRAY);
  leftImg.filter(INVERT);
  
  upImg = loadImage("images/up.png");
  upImg.resize(50,250);
  upImg.filter(GRAY);
  upImg.filter(INVERT);
  
  downImg = loadImage("images/down.png");
  downImg.resize(50,250);
  downImg.filter(GRAY);
  downImg.filter(INVERT);
  
  launchImg = loadImage("images/launch.png");
  launchImg.resize(50,50);
  launchImg.filter(GRAY);
  launchImg.filter(INVERT);
 
}

// Draw the terrain under the tanks
void drawGround() {
  for (float i = 0; i < width; i++) {
    line(i, tankwarsGroundLevel[(int)i], i, height);
    stroke(93,54,30);
  }
}

void drawControls() {
  fill(0);
  rectMode(CORNER);
  stroke(1);
  rect(0,height-100,width,100);
  noStroke();
  
  fill(255);
  textSize(bodyFontSize);
  image(leftImg, 0, height - 80);
  image(rightImg, width/5 - 100, height - 80);
  text("Angle",(width/5) - 100, height - 50);
  
  image(upImg, 2*width/5 + 50, height - 180);
  image(downImg, 3*width/5 - 50, height - 175);
  text("Strength", 3*width/5 - 135, height - 50);
  
  image(launchImg, 4*width/5, height - 80);
  text("Launch",4*width/5 + 150, height - 50);
}

void handOverControls() {
  if(projectState == "tankwars") {
    if (handOverLeftButton(90, height - 90,75,75)) {
      handOverLeftButton = true;
      handOverRightButton = false;
      handOverUpButton = false;
      handOverDownButton = false;
      handOverCloseButton = false;
      handOverLaunchButton = false;
    } else if ( handOverRightButton(width/5 - 15, height - 90,75,75)) {
      handOverLeftButton = false;
      handOverRightButton = true;
      handOverUpButton = false;
      handOverDownButton = false;
      handOverCloseButton = false;
      handOverLaunchButton = false;
    } else if ( handOverUpButton(2*width/5 + 35, height - 90,75,75)) {
      handOverLeftButton = false;
      handOverRightButton = false;
      handOverUpButton = true;
      handOverDownButton = false;
      handOverCloseButton = false;
      handOverLaunchButton = false;
    } else if ( handOverDownButton(3*width/5 - 65, height - 90,75,75)) {
      handOverLeftButton = false;
      handOverRightButton = false;
      handOverUpButton = false;
      handOverDownButton = true;
      handOverCloseButton = false;  
      handOverLaunchButton = false;
    } else if ( handOverLaunchButton(4*width/5 - 15, height - 90,75,75)) {
      handOverLeftButton = false;
      handOverRightButton = false;
      handOverUpButton = false;
      handOverDownButton = false;
      handOverCloseButton = false; 
      handOverLaunchButton = true;
    } else if ( mouseOverCloseButton(width-100, 0, 100, 100)) {
      handOverLeftButton = false;
      handOverRightButton = false;
      handOverUpButton = false;
      handOverDownButton = false;
      handOverCloseButton = true; 
      handOverLaunchButton = false;
    } else {
      handOverLeftButton = handOverRightButton = handOverUpButton = handOverDownButton = handOverCloseButton = false;
    } 
  }
}


boolean handOverLeftButton(float button_x, float button_y, float button_width, float button_height)  {
  if (handAvgX >= button_x && handAvgX <= button_x + button_width && handAvgY >= button_y && handAvgY <= button_y + button_height) {
    leftImg.filter(INVERT);
    return true;
  } else {
    leftImg.filter(GRAY);
    return false;
  }
}

boolean handOverRightButton(float button_x, float button_y, float button_width, float button_height)  {
  if (handAvgX >= button_x && handAvgX <= button_x + button_width && handAvgY >= button_y && handAvgY <= button_y + button_height) {
    rightImg.filter(INVERT);
    return true;
  } else {
    rightImg.filter(GRAY);
    return false;
  }
}

boolean handOverUpButton(float button_x, float button_y, float button_width, float button_height)  {
  if (handAvgX >= button_x && handAvgX <= button_x + button_width && handAvgY >= button_y && handAvgY <= button_y + button_height) {
    upImg.filter(INVERT);
    return true;
  } else {
    upImg.filter(GRAY);
    return false;
  }
}

boolean handOverDownButton(float button_x, float button_y, float button_width, float button_height)  {
  if (handAvgX >= button_x && handAvgX <= button_x + button_width && handAvgY >= button_y && handAvgY <= button_y + button_height) {
    downImg.filter(INVERT);
    return true;
  } else {
    downImg.filter(GRAY);
    return false;
  }
}

boolean handOverLaunchButton(float button_x, float button_y, float button_width, float button_height)  {
  if (handAvgX >= button_x && handAvgX <= button_x + button_width && handAvgY >= button_y && handAvgY <= button_y + button_height) {
    launchImg.filter(INVERT);
    return true;
  } else {
    launchImg.filter(GRAY);
    return false;
  }
}

void loadStars() {
  // Randomly generate the size and position of the stars
  for (int i=0; i < 200; i++) {
    starX[i] = random(0, width);
  }
  for (int i=0; i < 200; i++) {
    starY[i] = random(0, height);
  }
   for (int i=0; i < 200; i++) {
    starSize[i] = random(1, 6);
  }  
}

void loadTanks() {
  // Set the location of the two tanks so they rest on the ground at opposite sides
  tank1X = width * 0.1;
  tank1Y = player1Height;
  tank2X = width * 0.9;
  tank2Y = player2Height;
  
  calculateProjectilePosition(); 
}

void drawTanks() {
  rectMode(CENTER);

  // Drawing player 1 Tank
  noStroke();
  fill(15, 95, 25);
  arc(tank1X, tank1Y, tankDiameter, tankHeight, PI, TWO_PI);
  stroke(15, 95, 25);
  strokeWeight(2);
  line(tank1X, tank1Y-2, tank1X + cos(tank1CannonAngle)*cannonLength, tank1Y - sin(tank1CannonAngle)*cannonLength);

  // Drawing player 2 Tank
  noStroke();
  fill(95, 150, 100);
  arc(tank2X, tank2Y, tankDiameter, tankHeight, PI, TWO_PI);
  stroke(95, 150, 100);
  strokeWeight(2);
  line(tank2X, tank2Y-2, tank2X - cos(tank2CannonAngle)*cannonLength, tank2Y - sin(tank2CannonAngle)*cannonLength);
}

// Draw the projectile, if one is currently in motion
void drawProjectile() {
  if (!projectileInMotion)  // Don't draw anything if there's no projectile in motion
  return;
  noStroke();
  fill(255, 0, 0);
  ellipse(projectilePositionX, projectilePositionY, 6, 6);
  fill(255,255,0);
  ellipse(projectilePositionX, projectilePositionY, 3, 3);
}

// Draw the status text on the top of the screen
void drawStatus() {
  textSize(24);
  textAlign(LEFT);
  fill(255,255,0);

  if (playerHasWon == 1)
    text("Player 1 Wins!", 10, 30);
  else if (playerHasWon == 2)
    text("Player 2 Wins!", 10, 30);
  else if (player1Turn) { // player1Turn == true means it's player 1's turn
    text("Player 1's turn", 10, 30);
    textAlign(RIGHT);   
    text("Angle: " + tank1CannonAngle + " Strength: " + tank1CannonStrength + " Wind Speed " + tankwarsWindSpeed, width - 10, 30);
  } else {                 // player1Turn == false
    text("Player 2's turn", 10, 30);
    textAlign(RIGHT);
    text("Angle: " + tank2CannonAngle + " Strength: " + tank2CannonStrength + " Wind Speed " + tankwarsWindSpeed, width - 10, 30);
  }
}

// Move the projectile and check for a collision
void updateProjectilePositionAndCheckCollision() {
  if (!projectileInMotion)
    return;
  if (player1Turn) {    
    //If you hit yourself
    tankwarsGroundLevelDistX = projectilePositionX - tank1X;
    tankwarsGroundLevelDistY = projectilePositionY - tank1Y;
    tankwarsDistance = sqrt((tankwarsGroundLevelDistX*tankwarsGroundLevelDistX) + (tankwarsGroundLevelDistY*tankwarsGroundLevelDistY));
    if (tankwarsDistance <= tankDiameter/2) {
      playerHasWon = 2;
      projectileInMotion = false;
      explosion();
      return;
    }
    
    /*For collision detection
     //Using the logic from
     //http://www.jeffreythompson.org/collision-detection/point-circle.php
     */
    tankwarsGroundLevelDistX = projectilePositionX - tank2X;
    tankwarsGroundLevelDistY = projectilePositionY - tank2Y;
    tankwarsDistance = sqrt((tankwarsGroundLevelDistX*tankwarsGroundLevelDistX) + (tankwarsGroundLevelDistY*tankwarsGroundLevelDistY));
    if (tankwarsDistance <= tankDiameter/2) {
      playerHasWon = 1;
      projectileInMotion = false;
      explosion();
      return;
    }

    projectilePositionX += projectileVelocityX + tankwarsWindSpeed;
    projectilePositionY -= projectileVelocityY;
    projectileVelocityY -= gravity;

    if (projectilePositionX <= 0  || projectilePositionX >= width) {
      projectileInMotion = false;
      nextPlayersTurn();
      return;
    }

    if (projectilePositionY >= tankwarsGroundLevel[(int)projectilePositionX]) {
      //Reducing Ground if projectile hits ground
      float j=1;
      for (int i= ((int)projectilePositionX - (int)tank1CannonStrength); i <= ((int)projectilePositionX + (int)tank1CannonStrength); i++)
      {  
        if(i >= ((int)projectilePositionX - (int)tank1CannonStrength) && i <= (int)projectilePositionX)
          tankwarsGroundLevel[(int)i] += -tank1CannonStrength*j--;
        else if (i >= (int)projectilePositionX && i <= ((int)projectilePositionX + (int)tank1CannonStrength))
          tankwarsGroundLevel[(int)i] += -tank1CannonStrength*j++;
      }
      projectileInMotion = false;
      nextPlayersTurn();
      return;
    }
  } else {

    //If you hit yourself
    tankwarsGroundLevelDistX = projectilePositionX - tank2X;
    tankwarsGroundLevelDistY = projectilePositionY - tank2Y;
    tankwarsDistance = sqrt((tankwarsGroundLevelDistX*tankwarsGroundLevelDistX) + (tankwarsGroundLevelDistY*tankwarsGroundLevelDistY));
    if (tankwarsDistance <= tankDiameter/2) {
      playerHasWon = 1;
      projectileInMotion = false;
      explosion();
      return;
    }
    
    tankwarsGroundLevelDistX = projectilePositionX - tank1X;
    tankwarsGroundLevelDistY = projectilePositionY - tank1Y;
    tankwarsDistance = sqrt((tankwarsGroundLevelDistX*tankwarsGroundLevelDistX) + (tankwarsGroundLevelDistY*tankwarsGroundLevelDistY));
    if (tankwarsDistance <= tankDiameter/2) {
      playerHasWon = 2;
      projectileInMotion = false;
      explosion();
      return;
    }

    projectilePositionX -= projectileVelocityX - tankwarsWindSpeed;
    projectilePositionY -= projectileVelocityY;
    projectileVelocityY -= gravity;

    if (projectilePositionX <= 0  || projectilePositionX >= width) {
      projectileInMotion = false;
      nextPlayersTurn();
      return;
    }

    if (projectilePositionY >= tankwarsGroundLevel[(int)projectilePositionX]) {
      //Reducing Ground if Projectile hits ground
      float j=1;
      for (int i= ((int)projectilePositionX - (int)tank1CannonStrength); i <= ((int)projectilePositionX + (int)tank1CannonStrength); i++)
      {  
        if(i >= ((int)projectilePositionX - (int)tank1CannonStrength) && i <= (int)projectilePositionX)
          tankwarsGroundLevel[(int)i] += -tank1CannonStrength*j--;
        else if (i >= (int)projectilePositionX && i <= ((int)projectilePositionX + (int)tank1CannonStrength))
          tankwarsGroundLevel[(int)i] += -tank1CannonStrength*j++;
      }
      projectileInMotion = false;
      nextPlayersTurn();
      return;
    }
  }
}

// Advance the turn to the next player
void nextPlayersTurn() {
  
  player1Turn = !player1Turn;
}

// Handle a key press: update the status of the current player's tank
void keyPressed() {
  if (playerHasWon != 0)  // Stop the game when someone has won
    return;
  if (projectileInMotion) // No keys respond while the projectile is firing
    return;
  
  if (player1Turn) {
    if (keyCode == RIGHT)
      if (tank1CannonAngle <= PI)
        tank1CannonAngle -= radians(2);
    if (keyCode == LEFT)
      if (tank1CannonAngle >= 0)
        tank1CannonAngle += radians(2);
    if (keyCode == UP)
      if (tank1CannonStrength < 10)
        tank1CannonStrength += 1;
    if (keyCode == DOWN)
      if (tank1CannonStrength > 0)
        tank1CannonStrength -= 1;
    if (key == ' ') {
      projectileInMotion = true;
      calculateProjectilePosition();
    }
  } else {
    if (keyCode == RIGHT)
      if (tank2CannonAngle <= PI)
        tank2CannonAngle += radians(2);
    if (keyCode == LEFT)
      if (tank2CannonAngle >= 0)
        tank2CannonAngle -= radians(2);
    if (keyCode == UP)
      if (tank2CannonStrength < 10)
        tank2CannonStrength += 1;
    if (keyCode == DOWN)
      if (tank2CannonStrength > 0)
        tank2CannonStrength -= 1;
    if (key == ' ') {
      //nextPlayersTurn();
      projectileInMotion = true;
      calculateProjectilePosition();
    }
  }
}

void calculateProjectilePosition() {
  if (player1Turn) {
    projectilePositionX = tank1X + cos(tank1CannonAngle)*cannonLength;
    projectilePositionY = tank1Y - sin(tank1CannonAngle)*cannonLength;
    projectileVelocityX = tank1CannonStrength*cos(tank1CannonAngle);
    projectileVelocityY = tank1CannonStrength*sin(tank1CannonAngle);
  } else {
    projectilePositionX = tank2X - cos(tank2CannonAngle)*cannonLength;
    projectilePositionY = tank2Y - sin(tank2CannonAngle)*cannonLength;
    projectileVelocityX = tank2CannonStrength*cos(tank2CannonAngle);
    projectileVelocityY = tank2CannonStrength*sin(tank2CannonAngle);
  }
}

//Explosion Definition on projectile hitting a tank
void explosion() {
  fill(255, 0, 0);
  ellipse(projectilePositionX, projectilePositionY, 80, 80);
  fill(255, 255, 0);
  ellipse(projectilePositionX, projectilePositionY, 40, 40);
}

void initializeWindSpeed() {
 tankwarsWindSpeed = random(-3,3); 
}

// Handle a key press: update the status of the current player's tank
void updateTankWarParameters() {
  if (playerHasWon != 0)  // Stop the game when someone has won
    return;
  if (projectileInMotion) // No keys respond while the projectile is firing
    return;  
  if (player1Turn) {
    if (handOverRightButton)
      if (tank1CannonAngle <= PI)
        tank1CannonAngle -= radians(2);
    if (handOverLeftButton)
      if (tank1CannonAngle >= 0)
        tank1CannonAngle += radians(2);
    if (handOverUpButton)
      if (tank1CannonStrength < 10)
        tank1CannonStrength += 1;
    if (handOverDownButton)
      if (tank1CannonStrength > 0)
        tank1CannonStrength -= 1;
    if (handOverLaunchButton) {
      projectileInMotion = true;
      handOverLaunchButton = false;
      calculateProjectilePosition();
    }
  } else {
    if (handOverRightButton)
      if (tank2CannonAngle <= PI)
        tank2CannonAngle += radians(2);
    if (handOverLeftButton)
      if (tank2CannonAngle >= 0)
        tank2CannonAngle -= radians(2);
    if (handOverUpButton)
      if (tank2CannonStrength < 10)
        tank2CannonStrength += 1;
    if (handOverDownButton)
      if (tank2CannonStrength > 0)
        tank2CannonStrength -= 1;
    if (handOverLaunchButton) {
      //nextPlayersTurn();
      projectileInMotion = true;
      handOverLaunchButton = false;
      calculateProjectilePosition();
    }
  }
}