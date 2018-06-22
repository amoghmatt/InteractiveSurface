// Function to detect if hand is over the buttons in various states of the app
void handOver(float click_x, float click_y) {
  // Hand Detection on Home Screen
  if(projectState == "homescreen") {
    if (mouseOverGamesIcon((0.65*width + 0.3*width/2) - 250, (0.50*height + 0.4*height/2) - 50, 500, 100)) {
      handOverGamesIcon = true;
    }
    else 
      handOverGamesIcon =  false;
    } 
    // Hand Detection On Game Screen.Folder 1
    if(projectState == "gamescreen") {
      if (mouseOverTankWars((0.05*width + 0.4*width/2), (0.1*height + 0.35*height/2), 160, 120)) {
        handOverTankWars = true;
        handOverPong = false;
        handOverDrawing = false;
        handOverPong2 = false;
        handOverCloseButton = false;
        handOverForwardButton = false;
        handOverBackButton = false;
      } else if ( mouseOverRandomArt((0.5*width + 0.4*width/2), (0.1*height + 0.35*height/2), 160, 120)) {
        handOverTankWars = false;
        handOverPong = false;
        handOverDrawing = true;
        handOverPong2 = false;
        handOverCloseButton = false;
        handOverForwardButton = false;
        handOverBackButton = false;
      } else if ( mouseOverPong((0.05*width + 0.4*width/2), (0.5*height + 0.35*height/2), 160, 120)) {
        handOverTankWars = false;
        handOverPong = true;
        handOverDrawing = false;
        handOverPong2 = false;
        handOverCloseButton = false;
        handOverForwardButton = false;
        handOverBackButton = false;
      } else if ( mouseOverPong2((0.5*width + 0.4*width/2), (0.5*height + 0.35*height/2), 160, 120)) {
        handOverTankWars = false;
        handOverPong = false;
        handOverDrawing = false;
        handOverPong2 = true;
        handOverCloseButton = false;
        handOverForwardButton = false;
        handOverBackButton = false;        
      } else if ( mouseOverCloseButton(width-100, 0, 100, 100)) {
        handOverTankWars = false;
        handOverPong = false;
        handOverDrawing = false;
        handOverPong2 = false;
        handOverCloseButton = true;
        handOverForwardButton = false;
        handOverBackButton = false;        
      } else if ( mouseOverForwardButton(width-75, height - 75, 75, 75)) {
        handOverTankWars = false;
        handOverPong = false;
        handOverDrawing = false;
        handOverPong2 = false;
        handOverCloseButton = false;
        handOverForwardButton = true;
        handOverBackButton = false;        
      }  else {
        handOverTankWars = handOverPong = handOverDrawing = handOverPong2 = handOverCloseButton = handOverForwardButton = false;
      }
      
    }
    // Hand Detection On Game Screen Folder 2
    if(projectState == "gamescreen2") {
      if (mouseOverPingPong((0.05*width + 0.4*width/2), (0.1*height + 0.35*height/2), 160, 120)) {
        handOverPingPong = true;
        handOverCloseButton = false;
        handOverBackButton = false;
      } else if ( mouseOverCloseButton(width-100, 0, 100, 100)) {
        handOverPingPong = false;
        handOverCloseButton = true;
        handOverBackButton = false;     
      } else if ( mouseOverBackButton(0, height - 75, 75, 75)) {
        handOverPingPong = false;
        handOverCloseButton = false;
        handOverBackButton = true;      
      } else {
         handOverPingPong = handOverCloseButton = handOverBackButton = false;
      }
    } 
    // Detection if hand is over the close button in pong game
    if(projectState == "pong") {
      if (mouseOverCloseButton(0, 0, 100, 100)) {
        handOverCloseButton = true;
      }
      else {
        handOverCloseButton = false;
      }
    } 
    // Detection if hand is over the close button in random art game
    if(projectState == "art") {
      if (mouseOverCloseButton(width-100, 0, 100, 100)) {
        handOverCloseButton = true;
      }
      else {
        handOverCloseButton = false;
      }
    }
    // Detection if hand is over the close button in 2 player pong game
    if(projectState == "pong2") {
      if (mouseOverRightCloseButton(width/2 - 25, 0, 100, 100)) {
        handOverCloseButton = true;
      }
      else {
        handOverCloseButton = false;
      }
    }
    // Detection if hand is over the close button in ping pong table
    if(projectState == "pingpong") {
      if (mouseOverCloseButton(width - 50, height - 50, 50, 50)) {
        handOverCloseButton = true;
      }
      else {
        handOverCloseButton = false;
      }
    }
  } 

// Functions to detect if detected position is over a rectangular button
boolean mouseOverGamesIcon(float button_x, float button_y, float button_width, float button_height)  {
  if (handAvgX >= button_x && handAvgX <= button_x + button_width && handAvgY >= button_y && handAvgY <= button_y + button_height) {
    gamesImg.filter(INVERT);
    return true;
  } else {
    gamesImg.filter(GRAY);
    return false;
  }
}

boolean mouseOverTankWars(float button_x, float button_y, float button_width, float button_height)  {
  if (handAvgX >= button_x && handAvgX <= button_x + button_width && handAvgY >= button_y && handAvgY <= button_y + button_height) {
    tankwarsImg.filter(BLUR);
    return true;
  } else {
    tankwarsImg.filter(GRAY);
    return false;
  }
}

boolean mouseOverPong(float button_x, float button_y, float button_width, float button_height)  {
  if (handAvgX >= button_x && handAvgX <= button_x + button_width && handAvgY >= button_y && handAvgY <= button_y + button_height) {
    pongImg.filter(BLUR);
    return true;
  } else {
    pongImg.filter(GRAY);
    return false;
  }
}

boolean mouseOverPong2(float button_x, float button_y, float button_width, float button_height)  {
  if (handAvgX >= button_x && handAvgX <= button_x + button_width && handAvgY >= button_y && handAvgY <= button_y + button_height) {
    pong2Img.filter(BLUR);
    return true;
  } else {
    pong2Img.filter(GRAY);
    return false;
  }
}

boolean mouseOverRandomArt(float button_x, float button_y, float button_width, float button_height)  {
  if (handAvgX >= button_x && handAvgX <= button_x + button_width && handAvgY >= button_y && handAvgY <= button_y + button_height) {
    drawImg.filter(BLUR);
    return true;
  } else {
    drawImg.filter(GRAY);
    return false;
  }
}

boolean mouseOverPingPong(float button_x, float button_y, float button_width, float button_height)  {
  if (handAvgX >= button_x && handAvgX <= button_x + button_width && handAvgY >= button_y && handAvgY <= button_y + button_height) {
    tankwarsImg.filter(BLUR);
    return true;
  } else {
    tankwarsImg.filter(GRAY);
    return false;
  }
}

boolean mouseOverLeftCloseButton(float button_x, float button_y, float button_width, float button_height)  {
  if (leftAvgX >= button_x && leftAvgX <= button_x + button_width && leftAvgX >= button_y && leftAvgX <= button_y + button_height) {
    closeButtonImg.filter(INVERT);
    return true;
  } else {
    closeButtonImg.filter(GRAY);
    return false;
  }
}

boolean mouseOverRightCloseButton(float button_x, float button_y, float button_width, float button_height)  {
  if (rightAvgX >= button_x && rightAvgX <= button_x + button_width && rightAvgY >= button_y && rightAvgY <= button_y + button_height) {
    closeButtonImg.filter(BLUR);
    return true;
  } else {
    closeButtonImg.filter(GRAY);
    return false;
  }
}

boolean mouseOverCloseButton(float button_x, float button_y, float button_width, float button_height)  {
  if (handAvgX >= button_x && handAvgX <= button_x + button_width && handAvgY >= button_y && handAvgY <= button_y + button_height) {
    closeButtonImg.filter(BLUR);
    return true;
  } else {
    closeButtonImg.filter(GRAY);
    return false;
  }
}

boolean mouseOverForwardButton(float button_x, float button_y, float button_width, float button_height)  {
  if (handAvgX >= button_x && handAvgX <= button_x + button_width && handAvgY >= button_y && handAvgY <= button_y + button_height) {
    closeButtonImg.filter(BLUR);
    return true;
  } else {
    closeButtonImg.filter(GRAY);
    return false;
  }
}

boolean mouseOverBackButton(float button_x, float button_y, float button_width, float button_height)  {
  if (handAvgX >= button_x && handAvgX <= button_x + button_width && handAvgY >= button_y && handAvgY <= button_y + button_height) {
    closeButtonImg.filter(BLUR);
    return true;
  } else {
    closeButtonImg.filter(GRAY);
    return false;
  }
}