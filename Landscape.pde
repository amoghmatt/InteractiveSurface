/*
Infinite Scrolling Landscape by Bryan J. Cera
https://www.openprocessing.org/sketch/194607
*/
class Landscape {
  Horizon[] points = new Horizon[1000];
  int left, right;
  int timer = 0;
  float yy;
  float shade;
  float res;
  Landscape(int b, float s, float r) {
    res = r; 
    shade = s;
    for (int i = 0; i < points.length; i++) {
      float j = map(i, 0, points.length, 0, width);
      points[i] = new Horizon(j, b, i);
    }
  }
  void update(float speedx) {
    timer-=3;
    if (timer < 0) {
      yy = random(-75, 75);
      timer = int(random(25, 200));
    }
    for (int i = 0; i < points.length; i++) {
      points[i].update(yy,speedx,res); 
    }
  }
  void display() {    
    pushMatrix();
    scale(1.5, 1);
    translate((-width/points.length)*2,0);
    noStroke();
    fill(75-shade,165-shade,70-shade);
    beginShape();
    for (int i = 0; i < points.length; i++) {  
      vertex(points[i].x, points[i].y); 
      if (points[i].x >= width-(width/points.length)-1) {
        vertex(width, height*2); 
        vertex(0, height*2);
      }
    }
    vertex(points[0].x, points[0].y);
    endShape();
    popMatrix();
  }
}