//Highest level boject class for the visuals.
//Cells are a way to easily define the boundaries a spiral can appear in,
//and also allow the spirals to be rotated in their entirity.

class Cell {
  //Variables for the bounds of the area a spiral can appear
  float xLowBound, xHighBound, yLowBound, yHighBound;
  //Everything should be accessible.
  Cell (float cellLeftBound, float cellRightBound, float cellHighBound, float cellLowBound) {
    xLowBound = cellLeftBound;
    xHighBound = cellRightBound;
    yLowBound = cellHighBound;
    yHighBound = cellLowBound;
  }
  //Declare a spiral.
  Spiral spiral;

  float xPos, yPos;
  float angle;
  //Since this is the highest level of the nest, we will need an initializing function.
  void generate() {
    //Randomize the origin point.
    xPos = random(xLowBound, xHighBound);
    yPos = random(yLowBound, yHighBound);
    //Generate a spiral at 0,0 NOT at the origin point.
    //We'll move it when we rotate it.
    spiral = new Spiral(0, 0);
  }
  //Now the function to display the spirals.
  void display() {
    pushMatrix();                
    translate(xPos, yPos);        //Translate to the random origin.
    rotate(radians(angle));       //Rotate about that origin.
    spiral.display();             //Display the spiral.
    popMatrix();
    angle--;                      //Decrease the rotation angle.
                                  //It's the same as increasing, but in the opposite direction to dots.
  }
}
