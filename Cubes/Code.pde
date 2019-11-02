/*Assignment due week 10*/


final static ArrayList<Cube> cubeGroup = new ArrayList(); //set up array list to add to with each click

void setup() {
  size (1000, 1000);
  smooth();
}

void draw() {
  //grow all cube groups
  for (Cube cube : cubeGroup) {
    cube.grow();
    cube.display();
  }
}

void mousePressed() {
  //add a cube to the array list with each click
  cubeGroup.add( new Cube(mouseX, mouseY));
}
// define cube class

class Cube {
  float x, y;

  Cube (float xCube, float yCube) {
    x = xCube;
    y = yCube;
  }  
  //size randomized here so that each group is different size
  float size = random(1, 21);
  float scaleFactor = .86062; //determined from images of isometric cubes
  //function for shifting the position of each subsequent cube in a cube group
  void grow() {
    //variables to prevent bad loop
    boolean rightDrawn = false;
    boolean leftDrawn = false;
    boolean topDrawn = false;
    boolean bottomDrawn = false;
    //make choice of where to add a cube in relation to previous cube random
    int numOptions = 4; //four potential placements = left, right, top, bottom
    int posNextCube = (int)random(1, numOptions + 1); 
    
    switch(posNextCube) {
    case 1 : 
      //put the cube on the right
      if (!rightDrawn) {          //check to see if just drew a cube there 
        x += size * scaleFactor;  //reposition
        y += size/2;
        rightDrawn = true;
      }
      break; 
    case 2 : 
      //cube on left
      if (!leftDrawn) {
        x -= size * scaleFactor;
        y -= size/2;
        leftDrawn = true;
      }
      break; 
    case 3 : 
      //cube on top
      if (!topDrawn) {
        y -= size;
        topDrawn = true;
      }
      break;
    case 4:
      //cube on bottom
      if (!bottomDrawn) {
        y += size;
        bottomDrawn = true;
      }
    }
  }
  //randomize color and stroke
  float fillR = random(0, 255);
  float fillG = random(0, 255);
  float fillB = random(0, 255);
  color randFill = color(fillR, fillG, fillB);

  float strokeR = random(0, 255);
  float strokeG = random(0, 255);
  float strokeB = random(0, 255);
  color randStroke = color(strokeR, strokeG, strokeB);

  void display() {
    boolean cubeDrawn = false; //want this to make cubes one at a time, no matter where it is

    if (!cubeDrawn) {
      fill(randFill);
      stroke(randStroke);
      //draw a cube in isometric perspective
      //right side
      pushMatrix(); 
      translate(x + size * scaleFactor, y + size/2); //move the side to the proper position
      rotate(radians(330));                          //rotate the side
      shearX(radians(330));                          //shear it
      scale(1, scaleFactor);                         //scale it
      square(0, 0, size);                            //draw it
      popMatrix(); 
      //left side
      pushMatrix(); 
      translate(x, y); 
      rotate(radians(30)); 
      shearX(radians(30)); 
      scale(1, scaleFactor); 
      square(0, 0, size); 
      popMatrix(); 
      //top
      pushMatrix(); 
      translate(x, y); 
      rotate(radians(330)); 
      shearX(radians(30)); 
      scale(1, scaleFactor); 
      square(0, 0, size); 
      popMatrix();
      cubeDrawn = true;
    }
  }
}
