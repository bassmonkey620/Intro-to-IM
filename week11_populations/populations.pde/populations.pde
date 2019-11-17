//declare an array of the number of coutnries you would like to visualize
//the countries are listed in order of relative population size from largest to smallest
//50 countries = 50 countries with largest populations in the world
Cube[] cubeArray = new Cube[50]; //change the number to change the number of countries shown
//declare array to hold the population data
float populationData[];
//and density data
float densityData[];

void setup() {
  size (2000, 1260);
  background(0);
  //load the csvs into strings
  String populationNum[] = loadStrings("populationNum.csv");
  String density[] = loadStrings("density.csv");
  //split em
  populationData = float (split(populationNum[0], ','));
  densityData = float (split(density[0], ','));
  //fill the cube array up with cubes, positioned randomly
  for (int i = 0; i < cubeArray.length; i ++) {
    //size of cube is used to show density, divided by 5 for spatial purposes
    cubeArray[i] = new Cube(random(width), random(height), densityData[i]/5); 
    //have each country grow to its maximum population and stop
    for (int j = 1; j < populationData[j]; j++) {
      cubeArray[i].move();
      cubeArray[i].display();
    }
  }
}
//scale factor for isometric from 2d lengths
float isoScaleFactor = .86062;

class Cube {
  float x, y, size;

  Cube (float xCube, float yCube, float sizeCube) {

    x = xCube;
    y = yCube;
    size = sizeCube;
  }
  //randomize stroke
  float strokeR = random(0, 255);
  float strokeG = random(0, 255);
  float strokeB = random(0, 255);
  color randStroke = color(strokeR, strokeG, strokeB);
  //randomize color
  float fillR = random(0, 255);
  float fillG = random(0, 255);
  float fillB = random(0, 255);
  color randFill = color(fillR, fillG, fillB);

  void move() {
    //variables to check last move so not stuck in smallest possible loop
    boolean rightDrawn = false;
    boolean leftDrawn = false;
    boolean topDrawn = false;
    boolean bottomDrawn = false;
    //variable for number of positions
    int posNextCube = (int)random(1, 5); 
    //switch to define where to draw
    switch(posNextCube) {
    case 1 : 
      //cube on right
      if (!rightDrawn) { 
        x += size * isoScaleFactor;
        y += size/2;
        rightDrawn = true;
      }
      break; 
    case 2 : 
      //cube on left
      if (!leftDrawn) {
        x -= size * isoScaleFactor;
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

  void display() {
    
    fill(randFill);
    stroke(randStroke);
    //var so this only runs one cube a time (important for use in draw())
    boolean cubeDrawn = false;
    //draw cubes by creating several squares, scaling and shearing and rotating them to create isometric cube
    if (!cubeDrawn) {
      pushMatrix(); 
      translate(x + size * isoScaleFactor, y + size/2); 
      rotate(radians(330)); 
      shearX(radians(330)); 
      scale(1, isoScaleFactor); 
      square(0, 0, size); 
      popMatrix(); 

      //left side
      pushMatrix(); 
      translate(x, y); 
      rotate(radians(30)); 
      shearX(radians(30)); 
      scale(1, isoScaleFactor); 
      square(0, 0, size); 
      popMatrix(); 

      //top
      pushMatrix(); 
      translate(x, y); 
      rotate(radians(330)); 
      shearX(radians(30)); 
      scale(1, isoScaleFactor); 
      square(0, 0, size); 
      popMatrix();
      cubeDrawn = true;
    }
  }
}
