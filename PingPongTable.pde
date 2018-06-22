ParticleSystem ps;

// Function to load the components for generating the ping pong table
void loadPingPongTable() {
  background(70,160,126);
  rectMode(CORNER);
  ps = new ParticleSystem(new PVector(width/2, 50));
}

// Function to draw the layout of the ping pong table
void drawPingPongTable() {
  background(70,160,126);
  fill(255);
  rect(0,height/2 - 15,width, 30);
  rect(0,0,width,15);
  rect(0,height-15,width,15);
  rect(0,0,15,height);
  rect(width-15,0,15,height);
  rect(width/2 - 15,0,30,height);
  fill(255);
  // Detect the motion of the ball over the table
  ellipse(handAvgX, handAvgY, 30, 30);
  // Draw particles around the detected ball on the table
  for (int i = 0; i < 10; i++) {
    ps.addParticle(handAvgX, handAvgY);
  }
  ps.run();
}