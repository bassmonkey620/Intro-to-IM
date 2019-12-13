//Next level of the visuals. These are spirals drawn using Dots

class Spiral {
  //Variables for position, as well as two variables based upon gneral formula for a spiral and a spinSpeed variable.

  float x, y, inc, rad, spinSpeed; 

  //Each spiral is an array list of dots, that way we can add to it over time.
  ArrayList<Dot> spiral = new ArrayList(); 

  //Only the position needs to be defined in this one.
  Spiral (float xSpiral, float ySpiral) {
    x = xSpiral; 
    y = ySpiral;
  }
  
  //Once again, overall position will be determined in cell, so we only need a display function here.
  void display() {
    //Set an limit to the size of the spiral, this helps increase the contrast between a new and old spiral.
    //Doing so was necessary based upon feedback that it was hard to tell where a person was behind the wall,
    //when the spirals all looked so similar.
    //A new spiral is hard to spot if the screen is filled with dots.
    int spiralSizeLim = 250;
    if (spiral.size() < spiralSizeLim) {                 //If the spiral is not at full size,
      x += (cos(radians(inc)) * rad)/10;                 //change position along the spiral line.
      y += (sin(radians(inc)) * rad)/10; 
      inc += 16;                                         //These change the shape of the spiral.
      rad += 2; 

      spiral.add(new Dot(x, y, 10, 255, 20));            //Add a new dot at the new position. (size = 10, initial opacity = 255, rotation speed = 20)
      for (Dot dot : spiral) {                           //Iterate over all the dots in the array list,
        dot.display();                                   //and display them all.
      }
    } else if (spiral.size() >= spiralSizeLim) {         //If the spiral is at full size,
      for (Dot dot : spiral) {                           //do nothing but display all the dots of the spiral as they fade with each frame.
        dot.display();
      }
    }
  }
}
