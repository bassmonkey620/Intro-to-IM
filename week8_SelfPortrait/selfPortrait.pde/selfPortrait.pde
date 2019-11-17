//define image variables to use in image function
//q1 = top left, q2 = top right, q3 = bottom right, q4 = bottom left
PImage q1aWatt, q1cPala, q1dMill, q1dGogg, q1dArn, q1eDeg, q1eHul, q1iPor, q1mX, q1mAlex, q1tMorr;
PImage q2aWatt, q2cPala, q2dMill, q2dGogg, q2dArn, q2eDeg, q2eHul, q2iPor, q2mX, q2mAlex, q2tMorr;
PImage q3aWatt, q3cPala, q3dMill, q3dGogg, q3dArn, q3eDeg, q3eHul, q3iPor, q3mX, q3mAlex, q3tMorr;
PImage q4aWatt, q4cPala, q4dMill, q4dGogg, q4dArn, q4eDeg, q4eHul, q4iPor, q4mX, q4mAlex, q4tMorr;

//set up initial case numbers for looping
int q1Num = 1;
int q2Num = 2;
int q3Num = 3;
int q4Num = 4;

//set delay between images
int delay = 30;

void setup() {

  size(500, 500);

  //set image variables to images in data directory for Q1
  q1aWatt = loadImage("q1_alan_watts.png");
  q1cPala = loadImage("q1_chuck_palahniuk.png");
  q1dMill = loadImage("q1_dan_millman.png");
  q1dGogg = loadImage("q1_david_goggins.png");
  q1dArn = loadImage("q1_douglas_arnwine.png");
  q1eDeg = loadImage("q1_ellen_degenereas.png");
  q1eHul = loadImage("q1_elliott_hulse.png");
  q1iPor = loadImage("q1_ido_portal.png");
  q1mX = loadImage("q1_malcolm_x.png");
  q1mAlex = loadImage("q1_michelle_alexander.png");
  q1tMorr = loadImage("q1_toni_morrison.png");

  //set image variables to images in data directory for Q2
  q2aWatt = loadImage("q2_alan_watts.png");
  q2cPala = loadImage("q2_chuck_palahniuk.png");
  q2dMill = loadImage("q2_dan_millman.png");
  q2dGogg = loadImage("q2_david_goggins.png");
  q2dArn = loadImage("q2_douglas_arnwine.png");
  q2eDeg = loadImage("q2_ellen_degenereas.png");
  q2eHul = loadImage("q2_elliott_hulse.png");
  q2iPor = loadImage("q2_ido_portal.png");
  q2mX = loadImage("q2_malcolm_x.png");
  q2mAlex = loadImage("q2_michelle_alexander.png");
  q2tMorr = loadImage("q2_toni_morrison.png");

  //set image variables to images in data directory for Q3
  q3aWatt = loadImage("q3_alan_watts.png");
  q3cPala = loadImage("q3_chuck_palahniuk.png");
  q3dMill = loadImage("q3_dan_millman.png");
  q3dGogg = loadImage("q3_david_goggins.png");
  q3dArn = loadImage("q3_douglas_arnwine.png");
  q3eDeg = loadImage("q3_ellen_degenereas.png");
  q3eHul = loadImage("q3_elliott_hulse.png");
  q3iPor = loadImage("q3_ido_portal.png");
  q3mX = loadImage("q3_malcolm_x.png");
  q3mAlex = loadImage("q3_michelle_alexander.png");
  q3tMorr = loadImage("q3_toni_morrison.png");

  //set image variables to images in data directory for Q4
  q4aWatt = loadImage("q4_alan_watts.png");
  q4cPala = loadImage("q4_chuck_palahniuk.png");
  q4dMill = loadImage("q4_dan_millman.png");
  q4dGogg = loadImage("q4_david_goggins.png");
  q4dArn = loadImage("q4_douglas_arnwine.png");
  q4eDeg = loadImage("q4_ellen_degenereas.png");
  q4eHul = loadImage("q4_elliott_hulse.png");
  q4iPor = loadImage("q4_ido_portal.png");
  q4mX = loadImage("q4_malcolm_x.png");
  q4mAlex = loadImage("q4_michelle_alexander.png");
  q4tMorr = loadImage("q4_toni_morrison.png");
}

void draw() {
  background(0);
  //set switch to read q1 case counter
  switch(q1Num) {
  case 1:
    //position the top left corner of the image at 0,0
    image(q1aWatt, 0, 0);
    //increase the count to move to the next case
    q1Num++;
    //move to next case
    break;
    //repeat for all cases/images
  case 2:
    image(q1cPala, 0, 0);
    q1Num++;
    break;
  case 3:
    image(q1dMill, 0, 0);
    q1Num++;
    break;
  case 4:
    image(q1dGogg, 0, 0);
    q1Num++;
    break;
  case 5:
    image(q1dArn, 0, 0);
    q1Num++;
    break;
  case 6:
    image(q1eDeg, 0, 0);
    q1Num++;
    break;
  case 7:
    image(q1eHul, 0, 0);
    q1Num++;
    break;
  case 8:
    image(q1iPor, 0, 0);
    q1Num++;
    break;
  case 9:
    image(q1mX, 0, 0);
    q1Num++;
    break;
  case 10:
    image(q1mAlex, 0, 0);
    q1Num++;
    break;
  case 11:
    image(q1tMorr, 0, 0);
    //reset loop
    q1Num = 1;
  }
  delay(delay);
  
  //now for q2
    switch(q2Num) {
  case 1:
    //position the top right corner of the image at 250, 0
    image(q2aWatt, 250, 0);
    //increase the count to move to the next case
    q2Num++;
    //move to next case
    break;
    //repeat for all cases/images
  case 2:
    image(q2cPala, 250, 0);
    q2Num++;
    break;
  case 3:
    image(q2dMill, 250, 0);
    q2Num++;
    break;
  case 4:
    image(q2dGogg, 250, 0);
    q2Num++;
    break;
  case 5:
    image(q2dArn, 250, 0);
    q2Num++;
    break;
  case 6:
    image(q2eDeg, 250, 0);
    q2Num++;
    break;
  case 7:
    image(q2eHul, 250, 0);
    q2Num++;
    break;
  case 8:
    image(q2iPor, 250, 0);
    q2Num++;
    break;
  case 9:
    image(q2mX, 250, 0);
    q2Num++;
    break;
  case 10:
    image(q2mAlex, 250, 0);
    q2Num++;
    break;
  case 11:
    image(q2tMorr, 250, 0);
    //reset loop
    q2Num = 1;
  }
  delay(delay);
  
  //now q3
    switch(q3Num) {
  case 1:
    //position the bottom right corner of the image at 250, 250
    image(q3aWatt, 250, 250);
    //increase the count to move to the next case
    q3Num++;
    //move to next case
    break;
    //repeat for all cases/images
  case 2:
    image(q3cPala, 250, 250);
    q3Num++;
    break;
  case 3:
    image(q3dMill, 250, 250);
    q3Num++;
    break;
  case 4:
    image(q3dGogg, 250, 250);
    q3Num++;
    break;
  case 5:
    image(q3dArn, 250, 250);
    q3Num++;
    break;
  case 6:
    image(q3eDeg, 250, 250);
    q3Num++;
    break;
  case 7:
    image(q3eHul, 250, 250);
    q3Num++;
    break;
  case 8:
    image(q3iPor, 250, 250);
    q3Num++;
    break;
  case 9:
    image(q3mX, 250, 250);
    q3Num++;
    break;
  case 10:
    image(q3mAlex, 250, 250);
    q3Num++;
    break;
  case 11:
    image(q3tMorr, 250, 250);
    //reset loop
    q3Num = 1;
  }
  delay(delay);
  
  //q4
    switch(q4Num) {
  case 1:
    //position the bottom left corner of the image at 0, 250
    image(q4aWatt, 0, 250);
    //increase the count to move to the next case
    q4Num++;
    //move to next case
    break;
    //repeat for all cases/images
  case 2:
    image(q4cPala, 0, 250);
    q4Num++;
    break;
  case 3:
    image(q4dMill, 0, 250);
    q4Num++;
    break;
  case 4:
    image(q4dGogg, 0, 250);
    q4Num++;
    break;
  case 5:
    image(q4dArn, 0, 250);
    q4Num++;
    break;
  case 6:
    image(q4eDeg, 0, 250);
    q4Num++;
    break;
  case 7:
    image(q4eHul, 0, 250);
    q4Num++;
    break;
  case 8:
    image(q4iPor, 0, 250);
    q4Num++;
    break;
  case 9:
    image(q4mX, 0, 250);
    q4Num++;
    break;
  case 10:
    image(q4mAlex, 0, 250);
    q4Num++;
    break;
  case 11:
    image(q4tMorr, 0, 250);
    //reset loop
    q4Num = 1;
  }
  delay(delay);
  
}
