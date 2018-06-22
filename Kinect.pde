// Vary these to calibrate the depth detection on the right half of the screen
float rightMinThresh = 800;
float rightMaxThresh = 880;

// Vary these to calibrate the depth detection on the left half of the screen
float leftMinThresh = 800;
float leftMaxThresh = 885;

// Vary these to calibrate the depth detection on the entire screen
float handMinThresh = 800;
float handMaxThresh = 880;

float totalPixels;

// Variables to detect movement on the left side of the screen
int[] leftDepth;
int leftOffset;
float leftSumX = 0;
float leftSumY = 0;
float leftTotalPixels = 0;
float leftAvgX = 0;
float leftAvgY = 0;

// Variables to detect movement on the right side of the screen
int[] rightDepth;
int rightOffset;
float rightSumX = 0;
float rightSumY = 0;
float rightTotalPixels = 0;
float rightAvgX = 0;
float rightAvgY = 0;

// Variables to detect movement all over the screen
int[] handDepth;
int handOffset;
float handSumX = 0;
float handSumY = 0;
float handTotalPixels = 0;
float handAvgX = 0;
float handAvgY = 0;

// Function to initialise the kinect
void loadKinect() {
  kinect.initDepth(); 
}

// Function to detect the movement of the left hand/left side of the screen
void leftHand() {
  // Get the raw depth as array of integers
  leftDepth = kinect.getRawDepth();
  
  leftSumX = 0;
  leftSumY = 0;
  leftTotalPixels = 0;
  for (int x = 180; x < kinect.width/2 + 50; x++) { //Vary these limits to change the width portion of the screen you want to analyse 
    for (int y = 180; y < 420; y++) { //Vary these limits to change the height portion of the screen you want to analyse 
      leftOffset = x + y * kinect.width;
      int d = leftDepth[leftOffset];
      if (d > leftMinThresh && d < leftMaxThresh) {
        leftSumX += x;
        leftSumY += y;
        leftTotalPixels++;
      } else {
      }
    }
  }

  leftAvgX = leftSumX / leftTotalPixels;
  leftAvgY = leftSumY / leftTotalPixels;
  
  if(!Float.isNaN(leftAvgY) && !Float.isNaN(leftAvgY)) { //To prevent calculation when the value is null
    leftAvgX = map(leftAvgX,180,kinect.width/2 + 50,0,width/2); //Done to map the detected average of the left half of 640x480 kinect screen width over to the left half of fullscreen width.
    leftAvgY = map(leftAvgY,180,420,0,height); //Done to map the detected average of the  right half of 640x480 kinect screen height over to the right half of fullscreen height.
    lastTimeLeftHandMoved = millis(); // To calculate the last time hand was detected. For screensaver state
    fill(255);
    ellipse(leftAvgX, leftAvgY, 30, 30);
  }
}

// Function to detect the movement of the right hand/right side of the screen
void rightHand() {
  rightDepth = kinect.getRawDepth();
  
  rightTotalPixels = 0;
  rightSumX = 0;
  rightSumY = 0;
  for (int x = kinect.width/2 + 100; x < kinect.width; x++) { //Vary these limits to change the width portion of the screen you want to analyse 
    for (int y = 180; y < 420; y++) { //Vary these limits to change the height portion of the screen you want to analyse 
      rightOffset = x + y * kinect.width;
      int d = rightDepth[rightOffset];
      if (d > rightMinThresh && d < rightMaxThresh) {
        rightSumX += x;
        rightSumY += y;
        rightTotalPixels++;
      } 
    }
  }  
  rightAvgX = rightSumX / rightTotalPixels;
  rightAvgY = rightSumY / rightTotalPixels; 
  
  if(!Float.isNaN(rightAvgX) && !Float.isNaN(rightAvgY)) { //To prevent calculation when the value is null
    rightAvgX = map(rightAvgX,kinect.width/2 + 100,kinect.width,width/2,width); //Done to map the detected average of the right half of 640x480 kinect screen width over to the right half of fullscreen width.
    rightAvgY = map(rightAvgY,180,420,0,height); //Done to map the detected average of the right half of 640x480 kinect screen height over to the right half of fullscreen height.
    lastTimeRightHandMoved = millis(); // To calculate the last time hand was detected. For screensaver state
    fill(255);
    ellipse(rightAvgX, rightAvgY, 30, 30);
  }
}

// Function to detect the movement all over the screen.
void hands() {
  handDepth = kinect.getRawDepth();
  handTotalPixels = 0;
  handSumX = 0;
  handSumY = 0;
  for (int x = 180; x < kinect.width; x++) { //Vary these limits to change the width portion of the screen you want to analyse 
    for (int y = 180; y < 420; y++) { //Vary these limits to change the height portion of the screen you want to analyse 
      handOffset = x + y * kinect.width;
      int d = handDepth[handOffset];
      if (d > handMinThresh && d < handMaxThresh) {
        handSumX += x;
        handSumY += y;
        handTotalPixels++;
      } 
    }
  }  
  handAvgX = handSumX / handTotalPixels;
  handAvgY = handSumY / handTotalPixels; 
  
  if(!Float.isNaN(handAvgX) && !Float.isNaN(handAvgY)) { //To prevent calculation when the value is null
    handAvgX = map(handAvgX,180,kinect.width,0,width); //Done to map the detected average of the 640x480 kinect screen width over to the fullscreen width.
    handAvgY = map(handAvgY,180,420,0,height); //Done to map the detected average of the 640x480 kinect screen height over to the fullscreen height.
    lastTimeHandMoved = millis(); // To calculate the last time hand was detected. For screensaver state
    fill(255);
    if(!(projectState == "art")){
      ellipse(handAvgX, handAvgY, 30, 30); //Don't draw an ellipse for hand detection when the project state is art.
    }
  }  
}