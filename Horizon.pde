class Horizon { 
  float x;
  float y;
  float offsety,foffsety;
  float storedoffset;
  
  Horizon(float tx,int ty,int n) {
    offsety= ty;
    storedoffset = offsety;
    x = tx;
    y = offsety + random(-5,5);
    foffsety = offsety;  
  }
  void update(float ypos, float speed, float rr) {
    offsety = storedoffset+ypos; 
    foffsety += (offsety - foffsety) * .01;
    x-=speed;
    if(x <= 0) {
      x = width;
      y = foffsety+random(-rr,rr);
    }   
  }
  void display() {
    ellipse(x,y,10,10);
  }    
}