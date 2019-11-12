Cube[] cubeArray = new Cube[234];

float populationData[];

void setup() {


  size (1000, 1000);

  String populationNum[] = loadStrings("populationNum.csv");

  populationData = float (split(populationNum[0], ','));

  //populationTable = loadTable("populationData.csv", "header");

  //for (TableRow row : populationTable.rows() ) {
  //  String name = row.getString("Name");
  //  float population = row.getFloat("Population");
  //  float density = row.getFloat("Density");
  //  println(name + population + density);

  for (int i = 0; i < cubeArray.length; i ++) {
    cubeArray[i] = new Cube(random(width), random(height), 10);
  }
}

void draw() {
  for (int i = 0; i < cubeArray.length; i++) {
    cubeArray[i].move();
    cubeArray[i].display();
  }
}




class Cube {
  float x, y, size;

  Cube (float xCube, float yCube, float sizeCube) {

    x = xCube;
    y = yCube;
    size = sizeCube;
  }
  float strokeR = random(0, 255);
  float strokeG = random(0, 255);
  float strokeB = random(0, 255);
  color randStroke = color(strokeR, strokeG, strokeB);

  float fillR = random(0, 255);
  float fillG = random(0, 255);
  float fillB = random(0, 255);
  color randFill = color(fillR, fillG, fillB);

  void move() {
    boolean rightDrawn = false;
    boolean leftDrawn = false;
    boolean topDrawn = false;
    boolean bottomDrawn = false;
    int posNextCube = (int)random(1, 5); 
    switch(posNextCube) {
    case 1 : 
      //cube on right
      if (!rightDrawn) { 
        x += size * .86062;
        y += size/2;
        rightDrawn = true;
      }
      break; 
    case 2 : 
      //cube on left
      if (!leftDrawn) {
        x -= size * .86062;
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
    boolean cubeDrawn = false;
    if (!cubeDrawn) {
      pushMatrix(); 
      translate(x + size * .86062, y + size/2); 
      rotate(radians(330)); 
      shearX(radians(330)); 
      scale(1, .86062); 
      square(0, 0, size); 
      popMatrix(); 

      //left side
      pushMatrix(); 
      translate(x, y); 
      rotate(radians(30)); 
      shearX(radians(30)); 
      scale(1, .86062); 
      square(0, 0, size); 
      popMatrix(); 

      //top
      pushMatrix(); 
      translate(x, y); 
      rotate(radians(330)); 
      shearX(radians(30)); 
      scale(1, .86062); 
      square(0, 0, size); 
      popMatrix();
      cubeDrawn = true;
    }
  }
}
