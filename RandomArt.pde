class RandomArt{
  float angle1, angle2;
  PVector p, p1, p2, pOld1, pOld2;
  
  RandomArt(int artX, int artY) {
    p = new PVector(artX, artY);
    p1 = new PVector(p.x, p.y);
    p2 = new PVector(p.x, p.y);
    pOld1 = new PVector(p1.x, p1.y);
    pOld2 = new PVector(p2.x, p2.y);
  }
  void updateArt(){
      angle1 = noise(p1.x*noiseScale, p1.y*noiseScale) * noiseStrength;
      angle2 = noise(p2.x*noiseScale, p2.y*noiseScale) * noiseStrength;
      p1.x += cos(angle1) * stepSize;
      p1.y += sin(angle1) * stepSize;
      p2.x -= cos(angle2) * stepSize;
      p2.y -= sin(angle2) * stepSize;
     
      if(random(1)>0.5){
        stroke(0);
        line(pOld1.x, pOld1.y, p1.x, p1.y);
        line(pOld2.x, pOld2.y, p2.x, p2.y);
      }
      pOld1.set(p1);
      pOld2.set(p2);
  }
}

void loadRandomArt() {
  randomArt = new ArrayList<RandomArt>();
  if(randomArt.size() > 0) {
    randomArt.clear();
  }
  stepSize = 0.5;  // resolution, the lower the finer
  noiseScale = 0.01;   // play with this value
  noiseStrength = 10.00; // play with this value  
  maxAgents = 100;   // maximum amount of agents in the screen
  liveAgents = 0;
}

void drawRandomArt() {
  for(int i=0; i<liveAgents; i++){
    randomArt.get(i).updateArt();
  }
}

void addArtAgent(){
  randomArt.add(new RandomArt(int(handAvgX),int(handAvgY)));
  liveAgents++;
  if(liveAgents > maxAgents) {
    randomArt.remove(0);  // remove the first agent
    liveAgents --;
  }
}