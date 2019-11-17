PShape tile;  //declare smallest unit of tesselation pattern
//declare shapes that make up tile
//only 4 hexagons to create 6 hexagon pattern (woo! background!)
PShape hex1;
PShape hex2;
PShape hex3;
PShape hex4;

//define hexagon side length
float hexSideLength = 3;
//6 equilateral triangles = 1 regular hexagon
// 1/2 of equilaterateral triangle = 30-60-90 triangle
//define 30-60-90 triangle side lengths
//used to establish vertices from center
float hypotenuse = hexSideLength;
float shortLeg = hexSideLength/2;
float longLeg = shortLeg*sqrt(3);

//declare color variables
color color1, color2, color3;

//define/declare variables to retrieve information from the arduino
import processing.serial.*;

Serial myPort;
int[] serialInArray = new int[2]; //array to store Serial values
int serialCount = 0;              //initialize serialCount
int spinSpeed, zoom;                  //declare variables manipulated by Arduino
boolean firstContact = false;     //waits for Arduino signal to start

void setup() {  
  size(1000, 1000);

  //define the vertices of a hexagon centered on its position
  //think about drawing those 30-60-90 triangles from the position as center
  float clX = -hypotenuse;  //center left vertex x position
  float clY = 0;            //center left vertex y position
  float tlX = -shortLeg;    //top left vertex x position
  float tlY = -longLeg;     //top left vertex y position
  float trX = shortLeg;     //top right vertex x position
  float trY = -longLeg;     //top right vertex y position
  float crX = hypotenuse;   //center right vertex x position
  float crY = 0;            //center right vertex y position
  float brX = shortLeg;     //bottom right vertex x position
  float brY = longLeg;      //bottom right vertex y position
  float blX = -shortLeg;    //bottom left vertex x position
  float blY = longLeg;      //bootom left vertex y position
  //define the translation of the hexagons in the second row of the tile
  float hexRo2X = 1.5*hypotenuse;
  //define y translations of hexagons
  float hex1Y = 2*longLeg;
  float hex2Y = -hex1Y;
  float hex3Y = -longLeg;
  float hex4Y = -hex3Y;

  //define hexagon colors
  color1 = color(250, 0, 0);
  color2 = color (0, 0, 250);
  color3 = color (0);
  //create the tile shape as a group of hexagon shapes
  //this makes the tesselation grid simpler to create
  //and is a general method for doing any desired tesselation
  tile = createShape(GROUP);

  //create a hexagon shape
  hex1 = createShape();            //empty createshape() defines shape in next lines
  hex1.beginShape();                 //start to define the shape
  hex1.fill(color1);
  hex1.noStroke();
  hex1.vertex(clX, clY + hex1Y);     //left vertex (ORDER MATTERS)
  hex1.vertex(tlX, tlY + hex1Y);     //top left vertex
  hex1.vertex(trX, trY + hex1Y);     //top right vertex
  hex1.vertex(crX, crY + hex1Y);     //right ertex
  hex1.vertex(brX, brY + hex1Y);     //bottom right vertex
  hex1.vertex(blX, blY + hex1Y);     //bottom left vertex
  hex1.endShape();                   //stop defining shape
  tile.addChild(hex1);             //add shape to shape group
  //now do the same for the rest
  hex2 = createShape();
  hex2.beginShape();
  hex2.fill(color2);
  hex2.noStroke();
  hex2.vertex(clX, clY + hex2Y);
  hex2.vertex(tlX, tlY + hex2Y);
  hex2.vertex(trX, trY + hex2Y);
  hex2.vertex(crX, crY + hex2Y);
  hex2.vertex(brX, brY + hex2Y);
  hex2.vertex(blX, blY + hex2Y);
  hex2.endShape();
  tile.addChild(hex2);

  hex3 = createShape();
  hex3.beginShape();
  hex3.fill(color1);
  hex3.noStroke();
  hex3.vertex(clX + hexRo2X, clY +hex3Y);
  hex3.vertex(tlX + hexRo2X, tlY + hex3Y);
  hex3.vertex(trX + hexRo2X, trY + hex3Y);
  hex3.vertex(crX + hexRo2X, crY + hex3Y);
  hex3.vertex(brX + hexRo2X, brY + hex3Y);
  hex3.vertex(blX + hexRo2X, blY + hex3Y);
  hex3.endShape();
  tile.addChild(hex3);

  hex4 = createShape();
  hex4.beginShape();
  hex4.fill(color2);
  hex4.noStroke();
  hex4.vertex(clX + hexRo2X, clY +hex4Y);
  hex4.vertex(tlX + hexRo2X, tlY + hex4Y);
  hex4.vertex(trX + hexRo2X, trY + hex4Y);
  hex4.vertex(crX + hexRo2X, crY + hex4Y);
  hex4.vertex(brX + hexRo2X, brY + hex4Y);
  hex4.vertex(blX + hexRo2X, blY + hex4Y);
  hex4.endShape();
  tile.addChild(hex4);

  //print list of ports to choose from 
  print(Serial.list());
  //choose your port
  //I use 2, which is the third port in the above list
  String portName = Serial.list()[2];
  //define port and speed, make sure this matches arduino
  myPort = new Serial(this, portName, 9600);
  //initialize variables to be changed by Arduino
  spinSpeed = 0;
  zoom = 1;
}

void draw() {
  //remember that background color = color of one set of hexagons
  //could make two more hexagons, but frame rate issues...
  background(color3);

  //how far to shift tiles so they don't overlap
  float xTileShift = 3 * hypotenuse;
  float yTileShift = 6 * longLeg;
  //set maxs for number of rows + columns
  int roMax = 100;
  int colMax = 160;
  //set starting/ending tile positions for rows
  float rowStart = (width/2) - ((colMax/2) * xTileShift);
  float rowEnd = (width/2) + ((colMax/2) * xTileShift);
  //now for columns
  float colStart = (height/2) - ((roMax/2) * yTileShift);
  float colEnd = (height/2) + ((roMax/2) * yTileShift);

  //move rotation/scale point to the center
  translate(width/2, height/2);
  //scale according to Arduino value
  scale(zoom);
  //rotate according to arduino value
  rotate(radians(spinSpeed));
  //draw the grid of tiles
  for (float xPos = rowStart; xPos < rowEnd; xPos += xTileShift) { 
    for (float yPos = colStart; yPos < colEnd; yPos += yTileShift) {
      shape(tile, xPos, yPos);
    }
  }
}

void serialEvent(Serial myPort) {
  int zoomMin =1;
  int zoomMax = 40;
  int spinSpeedMin = 1;     //it never stops
  int spinSpeedMax = 200;
  // read a byte from the serial port
  int inByte = myPort.read();
  // if this is the first byte received, and it's an A, clear the serial
  // buffer and note that you've had first contact from Arduino
  // Otherwise, add incoming byte to array
  if (firstContact == false) {
    if (inByte == 'A') {
      myPort.clear();          // clear the serial port buffer
      firstContact = true;     // you've had first contact from Arduino
      myPort.write('A');       // ask for more
    }
  } else {
    // Add the latest byte from the serial port to array:
    serialInArray[serialCount] = inByte;
    serialCount++;

    // If we have 2 bytes:
    if (serialCount > 1 ) {
      zoom = (int)map(serialInArray[0], 0, 255, zoomMax, zoomMin);    //zoom = potentiometer
      spinSpeed += (int)map(serialInArray[1], 0, 255, spinSpeedMin, spinSpeedMax); //spind speed = light sensor

      // Send a capital A to request new sensor readings:
      myPort.write('A');
      // Reset serialCount:
      serialCount = 0;
    }
  }
}
