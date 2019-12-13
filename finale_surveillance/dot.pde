//This is the base unit of the visuals.
//Its just a square that rotates and disappears over time.

class Dot {
  //Variables for position, size, opacity, and rotation speed.
  float x, y, size, opacity, rotSpeed; 
  //Constructor. We'll want everything to be changeable because beauty is in the eye of the beholder.
  Dot (float xDot, float yDot, float sizeDot, float opacityDot, float rotSpeedDot) {
    x = xDot; 
    y = yDot; 
    size = sizeDot; 
    opacity = opacityDot;
    rotSpeed = rotSpeedDot;
  }
  //Initialize the angle.
  float rotAngle = 1;

  //Just a display function is needed.
  void display() {
    rectMode(CENTER);            //Center the squares. It's easier for the rotation.
    fill(255, opacity);          //Make it white, but make the opacity variable.
    noStroke(); 

    pushMatrix();                //Draw a rectangle that rotates around its center.
    translate(x, y);              
    rotate(radians(rotAngle));
    rect(0, 0, size, size);
    popMatrix();

    rotAngle += rotSpeed;        //Increase the angle with each frame,
    opacity -=4;                 //and fade it, too.
  }
}
