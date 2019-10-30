//define grid cell side length, should be factor of width and height
int gridDim = 100;

void setup () {
  size(2100, 1400);
  background(255);

  noFill();
  stroke(0);

  //define initial grid cell position
  int gridSqX= 0;
  int gridSqY= 0;
  //define total number of cells
  int cellTot = (width/gridDim) * (height/gridDim);
  //define last x of any row
  int lastX = width - gridDim;
  //and y of any column
  int lastY = height - gridDim;

  //draw grid
  for (gridSqX = 0; gridSqX >= 0 && gridSqX <=lastX; gridSqX = gridSqX + gridDim) {      //draw all cells in a row
    for (gridSqY = 0; gridSqY >= 0 && gridSqY <= lastY; gridSqY = gridSqY + gridDim) {   //for each row
      rect(gridSqX, gridSqY, gridDim, gridDim);
    }
  }

  //define variables to move from cell to cell
  int xTrans = 0;
  int yTrans = 0;
  //loop to draw squares equal to number of cells
  for (int i = 0; i < cellTot; i++) {
    //draw squares in cell
    squares(xTrans, yTrans);
    //define translation parameters for the squares
    if (xTrans < lastX) {          //draw squares in every cell in the row
      xTrans += gridDim;
    } else if (xTrans == lastX) {  //until the last one
      xTrans = 0;                  //then reset to the first cell
      yTrans += gridDim;           //in the next column
    }
  }
}

void squares(int xTrans, int yTrans) {
  //define size of smallest square
  int size = 20;
  //define max number of squares to make, mess with this with caution, may "break" graphic
  int sqNumMax = 8;
  //define final possible x and y positions of smallest square
  int lastPos = gridDim - size;
  //tie the x coordinates to noise output
  float sqXRange = random(lastPos);
  float sqXNoise = noise(sqXRange);
  int x = (int)map(sqXNoise, 0, 1, 0, lastPos);   //produce an initial x
  //now tie the y coordinates, position is not tied to noise
  float smSqYRange = random(lastPos);
  float smSqYNoise = noise(smSqYRange);
  int y = (int)map(smSqYNoise, 0, 1, 0, lastPos); //produce an initial y

  //now tie mnumber of squares produced to noise, keeping range b/w 1 (can't divide by 0) and 8
  float sqNumRange = random(1, sqNumMax);
  float sqNumNoise = noise(sqNumRange);
  int sqNum = (int)map(sqNumNoise, 0, 1, 0, sqNumMax);

  //define how the position of each square will shift, this is based on the midpoint formula below
  int xChange = x / sqNum;     //xm = (x2 - x1) / 2
  int yChange = y / sqNum;     //ym = (y2 - y1) / 2

  //draw up to the maximum number of squares
  for (int i = 0; i < sqNum; i++) {

    pushMatrix();
    translate(xTrans, yTrans);  //translate to the cell
    square(x, y, size);         //draw a square 
    size+= 80 / sqNum ;     //increases sizes to divide space around small square evenly
    x -= xChange;               //shift squares to adjust for noise locaiton of small square
    y -= yChange;
    popMatrix();
  }
}
