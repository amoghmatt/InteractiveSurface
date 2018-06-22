// Sketch by Daniel Shiffman
// https://github.com/CodingTrain/Rainbow-Code/tree/master/Tutorials/Processing/12_kinect/sketch_12_4_HandTrackingSortofParticles

class Particle {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float lifespan;

  Particle(float x, float y) {
    acceleration = new PVector(random(-0.05, 0.05), random(-0.05, 0.05)); // Vary these to randomise the acceleration of the particles
    velocity = new PVector(random(-1, 1), random(-2, 0)); // Vary these to randomise the velocity of the particles
    location = new PVector(x, y);
    lifespan = 200.0;
  }
  
  // Function to run the particles
  void run() {
    update();
    display();
  }

  // Function to update location
  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    lifespan -= 1.0;
  }

  // Function to display
  void display() {
    stroke(255, lifespan);
    fill(255, lifespan);
    ellipse(location.x, location.y, 8, 8);
  }

  // Function to remove the particle after its lifespan 
  boolean isDead() {
    if (lifespan < 0.0) {
      return true;
    } else {
      return false;
    }
  }
}