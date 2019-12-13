//Processing Code for Final Introduction to Interactive Media Project*/

//Oh, and put comments as you go next time, idiot.

//load sound library
import processing.sound.*;

//declare soundfile
SoundFile bgMelody;
//delcare variables for playback rate and volume
//destVol and destPBRate are the desired values for use in the smoothing formula
//scaleVals are variables for how much to increment by in the smoothing formula
float pbRate, vol, destVol, scaleValVol, destPBRate, scaleValPBRate;

//declare an array list of cells for each of the 16 IR sensors
ArrayList<Cell> cell1 = new ArrayList<Cell>(1);
ArrayList<Cell> cell2 = new ArrayList<Cell>(1);
ArrayList<Cell> cell3 = new ArrayList<Cell>(1);
ArrayList<Cell> cell4 = new ArrayList<Cell>(1);
ArrayList<Cell> cell5 = new ArrayList<Cell>(1);
ArrayList<Cell> cell6 = new ArrayList<Cell>(1);
ArrayList<Cell> cell7 = new ArrayList<Cell>(1);
ArrayList<Cell> cell8 = new ArrayList<Cell>(1);
ArrayList<Cell> cell9 = new ArrayList<Cell>(1);
ArrayList<Cell> cell10 = new ArrayList<Cell>(1);
ArrayList<Cell> cell11 = new ArrayList<Cell>(1);
ArrayList<Cell> cell12 = new ArrayList<Cell>(1);
ArrayList<Cell> cell13 = new ArrayList<Cell>(1);
ArrayList<Cell> cell14 = new ArrayList<Cell>(1);
ArrayList<Cell> cell15 = new ArrayList<Cell>(1);
ArrayList<Cell> cell16 = new ArrayList<Cell>(1);

//declare variables to define the position of each cell
float xPos, yPos;
int roNum = 4;      //number of rows
int colNum = 4;     //number of columns

//state triggers for adding a spiral
//necessary so that the sensor can reset while the visuals continue independently
boolean cell1SpiralAdded = false;
boolean cell2SpiralAdded = false;
boolean cell3SpiralAdded = false;
boolean cell4SpiralAdded = false;
boolean cell5SpiralAdded = false;
boolean cell6SpiralAdded = false;
boolean cell7SpiralAdded = false;
boolean cell8SpiralAdded = false;
boolean cell9SpiralAdded = false;
boolean cell10SpiralAdded = false;
boolean cell11SpiralAdded = false;
boolean cell12SpiralAdded = false;
boolean cell13SpiralAdded = false;
boolean cell14SpiralAdded = false;
boolean cell15SpiralAdded = false;
boolean cell16SpiralAdded = false;

//state trigger variables for activated IR sensors
boolean IR1Triggered = false;
boolean IR2Triggered = false;
boolean IR3Triggered = false;
boolean IR4Triggered = false;
boolean IR5Triggered = false;
boolean IR6Triggered = false;
boolean IR7Triggered = false;
boolean IR8Triggered = false;
boolean IR9Triggered = false;
boolean IR10Triggered = false;
boolean IR11Triggered = false;
boolean IR12Triggered = false;
boolean IR13Triggered = false;
boolean IR14Triggered = false;
boolean IR15Triggered = false;
boolean IR16Triggered = false;

//import the serial library for communication
import processing.serial.*;

//declare the serial port
Serial myPort;
//declare an array to store the values sent from Arduino
int[] serialInArray = new int[16];
//initialize a counter to move through the array
int serialCount = 0;
//declare the variables the values in the array will correspond to
//in this case, each value corresponds to a sensor
int IR1, IR2, IR3, IR4, IR5, IR6, IR7, IR8, IR9, IR10, IR11, IR12, IR13, IR14, IR15, IR16;
//declare the handshaking boolean so the program waits for Arduino
boolean firstContact = false;

void setup() {
  //size should be screen resolution
  size(2160, 1440);
  smooth();
  //hide the cursor
  noCursor();

  //load the soundfile of the arpeggios
  bgMelody = new SoundFile(this, "Finale_Audio.mp3");
  //play it in a loop, with vol for amplitude and pbRate for playback speed
  bgMelody.loop(vol, pbRate);

  //choose the serial port to communicate across
  String portName = Serial.list()[2];
  //initialize the earlier serial port as the serial port you're communicating with
  //make sure the last number matches the number used in arduino
  myPort = new Serial(this, portName, 9600);
}


void draw() {
  //initialize variables so each cell is equal and able to cover the entirity of the sketch
  int cellWidth = width/colNum;
  int cellHeight = height/roNum;

  //Set thresholds for IR sensors to determine if they are activated or not.
  //Each IR sensor will be constantly detecting a wall, sending in a narrow range of numbers.
  //These thresholds should be set just under the low end of that range.
  //Use the println sequence in the serialEvent function to see these values and adjust thresholds.
  int IR1threshold = 155;
  int IR2threshold = 130;
  int IR3threshold = 165;
  int IR4threshold = 140;
  int IR5threshold = 150;
  int IR6threshold = 120;
  int IR7threshold = 135;
  int IR8threshold = 125;
  int IR9threshold = 135;
  int IR10threshold = 120;
  int IR11threshold = 130;
  int IR12threshold = 145;
  int IR13threshold = 135;
  int IR14threshold = 145;
  int IR15threshold = 110;
  int IR16threshold = 105;

  //Set a limit to the number of spirals in any area, so this doesn't crash your computer.
  int spiralLim = 5;

  //call the background or they won't fade
  background(0);

  //Start with the aduio feedback.
  //set the amplitude of the audio file to the volume variable
  bgMelody.amp(vol);
  //set the playback rate of the audio file to the playback rate
  bgMelody.rate(pbRate);

  //This is a smoothing formula.
  //It takes a defined desired volume,
  //subtracts the current volume,
  //multiples the result by a defined increment
  //and adds the result to the current volume.
  //As a result, rather than, say, jumping from .1 to .3 when a sensor is activated,
  //volume simply increases by a small incrememnt until it reaches .3.
  //This means smoother audio and less confusion for the user.
  vol += (destVol - vol) * scaleValVol;

  //These are defensive if loops to keep the volume from going out of range.
  //When it did go out of range before, the volume would just move to 1 and stay there.
  //These if loops keep that from happening.
  if (vol < .1) vol = .1;
  if (vol > .9) vol = .9;

  //Set a default that will always be slowly moved toward.
  //This way, when people stand in between sensors, and no sensor is activated,
  //the volume slowly moves down toward this baseline.
  //It's imperceptable unless the person leaves the area or stands between sensors for a long time.
  destVol = .1;
  scaleValVol = .001;

  //Now we do the same thing for playback speed.
  pbRate += (destPBRate - pbRate) * scaleValPBRate;   //formula

  if (pbRate < .25) pbRate = .25;       //defensive if loops
  if (pbRate > 1.2) pbRate = 1.2;

  destPBRate = .2;                      //default settings
  scaleValPBRate = .01;

  float pbRateRo1 = 1.2;      //highest playback speed
  float pbRateRo2 = 1.0;      //next highest
  float pbRateRo3 = 0.6;      //next highest
  float pbRateRo4 = 0.2;      //lowest

  float volCol1 = .3;         //lowest volume
  float volCol2 = .4;         //next lowest
  float volCol3 = .7;         //next lowest
  float volCol4 = .9;         //highest

  float volTransitionSpeed = .1;     //Move at one-tenth incrememtns beween volumes,
  float volInitializeSpeed = .3;     //except the first one. Jump there to provide feedback to the user that they have been detected.
  float pbRateTransitionSpeed = .2;  //Move at one-fifth increments between playback speeds.

  //When a particular row is activated, the audio file starts moving toward the playback speed for that row.
  if (IR1Triggered || IR2Triggered || IR3Triggered || IR4Triggered) {        //When row 1 is actve. (see below)
    destPBRate = pbRateRo1;                                                  //Move toward a playback speed of 1.2
    scaleValPBRate = pbRateTransitionSpeed;                                  //Increasing by one fifth of the distance between the current and new speeds.
  } 
  if (IR5Triggered || IR6Triggered || IR7Triggered || IR8Triggered) {        //now row 2
    destPBRate = pbRateRo2;
    scaleValPBRate =pbRateTransitionSpeed;
  }
  if (IR9Triggered || IR10Triggered || IR11Triggered || IR12Triggered) {     //row 3
    destPBRate = pbRateRo3;
    scaleValPBRate = pbRateTransitionSpeed;
  } 
  if (IR13Triggered || IR14Triggered || IR15Triggered || IR16Triggered) {    //row 4
    destPBRate = pbRateRo4;
    scaleValPBRate = pbRateTransitionSpeed;
  } 

  //Now we do the same for volume, but with columns.
  if (IR1Triggered || IR5Triggered || IR9Triggered || IR13Triggered) {
    destVol = volCol1;
    scaleValVol =volInitializeSpeed;
  }
  if (IR2Triggered || IR6Triggered || IR10Triggered || IR14Triggered) {
    destVol = volCol2;
    scaleValVol = volTransitionSpeed;
  }
  if (IR3Triggered || IR7Triggered || IR11Triggered || IR15Triggered) {
    destVol = volCol3;
    scaleValVol = volTransitionSpeed;
  }
  if (IR4Triggered || IR8Triggered || IR12Triggered || IR16Triggered) {
    destVol = volCol4;
    scaleValVol = volTransitionSpeed;
  }

  //Now we work with the visuals.
  //Sensor 1, top right.
  if (IR1 < IR1threshold)           //If the detected value for IR1 from Arduino is below the set threshold,
    IR1Triggered = true;            //IR1 is activated.
  else if (IR1 >= IR1threshold)     //If it is above the set threshold,
    IR1Triggered = false;           //IR1 is inactive.

  if (IR1Triggered && !cell1SpiralAdded) {                //If something is in front of IR1 and the spiral parameters have not been generated yet,

    cell1.add(new Cell(0, cellWidth, 0, cellHeight));     //Add a Cell to the arraylist with the parameters for the area IR1 is responsible for (top right).
    //Cell parameters were defined in an earlier version. Basically creating a 4x4 grid with them.
    Cell cell = cell1.get(cell1.size() - 1);              //Access that Cell by defining it; it's the last one in the list.
    cell.generate();                                      //Generate a random position for the Spiral of that Cell.

    cell1SpiralAdded = true;                              //Spiral parameters have been added.
  } 
  if (IR1Triggered && cell1SpiralAdded) {                 //If something is in front of IR1 and spiral parameters have been added,
    for (Cell cell : cell1) {                             //then for every Cell int the array,
      cell.display();                                     //display its Spiral.
    }
  } 
  if (!IR1Triggered && cell1SpiralAdded) {                //If something is no longer in front of IR1 but it is still concerned with the last Spiral it addded,
    for (Cell cell : cell1) {                             //keep displaying the Spirals in the Cells of the area,
      cell.display();
    } 
    cell1SpiralAdded = false;                             //but reset the boolean so it can generate a new position for the spiral when IR1 is activated again.
  } 
  if (!IR1Triggered && !cell1SpiralAdded) {               //Finally, if nothing is in front of IR1 and it is not concerned with the last Spiral added,
    for (Cell cell : cell1) {                             //make sure the Spirals are still displayed.
      cell.display();
    }
  }
  if (cell1.size() > spiralLim) {                         //If the cize of the array of this area is greater than the defined limit for the number of Spirals visible,
    cell1.clear();                                        //clear the array.
  }

  //Now do that for the rest of them.

  //Sensor 2
  if (IR2 < IR2threshold) 
    IR2Triggered = true;
  else if (IR2 >= IR2threshold)
    IR2Triggered = false;

  if (IR2Triggered && !cell2SpiralAdded) {
    cell2.add(new Cell(cellWidth, 2*cellWidth, 0, cellHeight));
    Cell cell = cell2.get(cell2.size() - 1);
    cell.generate();

    cell2SpiralAdded = true;
  } 

  if (IR2Triggered && cell2SpiralAdded) {
    for (Cell cell : cell2) {
      cell.display();
    }
  } 
  if (!IR2Triggered && cell2SpiralAdded) {
    for (Cell cell : cell2) {
      cell.display();
    } 
    cell2SpiralAdded = false;
  } 
  if (!IR2Triggered && !cell2SpiralAdded) {
    for (Cell cell : cell2) {
      cell.display();
    }
  }
  if (cell2.size() > spiralLim) {
    cell2.clear();
  }

  //SENSOR3
  if (IR3 < IR3threshold) 
    IR3Triggered = true;
  else if (IR3 >= IR3threshold)
    IR3Triggered = false;

  if (IR3Triggered && !cell3SpiralAdded) {
    cell3.add(new Cell(2*cellWidth, 3*cellWidth, 0, cellHeight));
    Cell cell = cell3.get(cell3.size() - 1);
    cell.generate();

    cell3SpiralAdded = true;
  }

  if (IR3Triggered && cell3SpiralAdded) {
    for (Cell cell : cell3) {
      cell.display();
    }
  } 
  if (!IR3Triggered && cell3SpiralAdded) {
    for (Cell cell : cell3) {
      cell.display();
    } 
    cell3SpiralAdded = false;
  } 
  if (!IR3Triggered && !cell3SpiralAdded) {
    for (Cell cell : cell3) {
      cell.display();
    }
  }
  if (cell3.size() > spiralLim) {
    cell3.clear();
  }

  //SENSOR4
  if (IR4 < IR4threshold) 
    IR4Triggered = true;
  else if (IR4 >= IR4threshold)
    IR4Triggered = false;

  if (IR4Triggered && !cell4SpiralAdded) {
    cell4.add(new Cell(3*cellWidth, width, 0, cellHeight));
    Cell cell = cell4.get(cell4.size() - 1);
    cell.generate();

    cell4SpiralAdded = true;
  } 
  if (IR4Triggered && cell4SpiralAdded) {
    for (Cell cell : cell4) {
      cell.display();
    }
  } 
  if (!IR3Triggered && cell3SpiralAdded) {
    for (Cell cell : cell4) {
      cell.display();
    } 
    cell3SpiralAdded = false;
  } 
  if (!IR3Triggered && !cell3SpiralAdded) {
    for (Cell cell : cell4) {
      cell.display();
    }
  }
  if (cell4.size() > 10) {
    cell4.clear();
  }
  //SENSOR5
  if (IR5 < IR5threshold) 
    IR5Triggered = true;
  else if (IR5 >= IR5threshold)
    IR5Triggered = false;

  if (IR5Triggered && !cell5SpiralAdded) {
    cell5.add(new Cell(0, cellWidth, cellHeight, 2*cellHeight));
    Cell cell = cell5.get(cell5.size() - 1);
    cell.generate();

    cell5SpiralAdded = true;
  } 

  if (IR5Triggered && cell5SpiralAdded) {
    for (Cell cell : cell5) {
      cell.display();
    }
  } 
  if (!IR5Triggered && cell5SpiralAdded) {
    for (Cell cell : cell5) {
      cell.display();
    } 
    cell5SpiralAdded = false;
  } 
  if (!IR5Triggered && !cell5SpiralAdded) {
    for (Cell cell : cell5) {
      cell.display();
    }
  }
  if (cell5.size() > spiralLim) {
    cell5.clear();
  }

  //SENSOR6
  if (IR6 < IR6threshold) 
    IR6Triggered = true;
  else if (IR6 >= IR6threshold)
    IR6Triggered = false;

  if (IR6Triggered && !cell6SpiralAdded) {
    cell6.add(new Cell(cellWidth, 2*cellWidth, cellHeight, 2*cellHeight));
    Cell cell = cell6.get(cell6.size() - 1);
    cell.generate();

    cell6SpiralAdded = true;
  } 

  if (IR6Triggered && cell6SpiralAdded) {
    for (Cell cell : cell6) {
      cell.display();
    }
  } 
  if (!IR6Triggered && cell6SpiralAdded) {
    for (Cell cell : cell6) {
      cell.display();
    } 
    cell6SpiralAdded = false;
  } 
  if (!IR6Triggered && !cell6SpiralAdded) {
    for (Cell cell : cell6) {
      cell.display();
    }
  }
  if (cell6.size() > spiralLim) {
    cell6.clear();
  }

  //SENSOR7!!!
  if (IR7 < IR7threshold) 
    IR7Triggered = true;
  else if (IR7 >= IR7threshold)
    IR7Triggered = false;

  if (IR7Triggered && !cell7SpiralAdded) {
    cell7.add(new Cell(2*cellWidth, 3*cellWidth, cellHeight, 2*cellHeight));
    Cell cell = cell7.get(cell7.size() - 1);
    cell.generate();

    cell7SpiralAdded = true;
  } 

  if (IR7Triggered && cell7SpiralAdded) {
    for (Cell cell : cell7) {
      cell.display();
    }
  } 
  if (!IR7Triggered && cell7SpiralAdded) {
    for (Cell cell : cell7) {
      cell.display();
    } 
    cell7SpiralAdded = false;
  } 
  if (!IR7Triggered && !cell7SpiralAdded) {
    for (Cell cell : cell7) {
      cell.display();
    }
  }
  if (cell7.size() > spiralLim) {
    cell7.clear();
  }

  //SENSOR8!!!
  if (IR8 < IR8threshold) 
    IR8Triggered = true;
  else if (IR8 >= IR8threshold)
    IR8Triggered = false;

  if (IR8Triggered && !cell8SpiralAdded) {
    cell8.add(new Cell(3*cellWidth, width, cellHeight, 2*cellHeight));
    Cell cell = cell8.get(cell8.size() - 1);
    cell.generate();

    cell8SpiralAdded = true;
  } 

  if (IR8Triggered && cell8SpiralAdded) {
    for (Cell cell : cell8) {
      cell.display();
    }
  } 
  if (!IR8Triggered && cell8SpiralAdded) {
    for (Cell cell : cell8) {
      cell.display();
    } 
    cell8SpiralAdded = false;
  } 
  if (!IR8Triggered && !cell8SpiralAdded) {
    for (Cell cell : cell8) {
      cell.display();
    }
  }
  if (cell8.size() > spiralLim) {
    cell8.clear();
  }
  //SENSOR9
  if (IR9 < IR9threshold) 
    IR9Triggered = true;
  else if (IR9 >= IR9threshold)
    IR9Triggered = false;

  if (IR9Triggered && !cell9SpiralAdded) {
    cell9.add(new Cell(0, cellWidth, 2*cellHeight, 3*cellHeight));
    Cell cell = cell9.get(cell9.size() - 1);
    cell.generate();

    cell9SpiralAdded = true;
  } 

  if (IR9Triggered && cell9SpiralAdded) {

    for (Cell cell : cell9) {
      cell.display();
    }
  } 
  if (!IR9Triggered && cell9SpiralAdded) {

    for (Cell cell : cell9) {
      cell.display();
    } 
    cell9SpiralAdded = false;
  } 
  if (!IR9Triggered && !cell9SpiralAdded) {

    for (Cell cell : cell9) {
      cell.display();
    }
  }
  if (cell9.size() > spiralLim) {
    cell9.clear();
  }

  //SENSOR10
  if (IR10 < IR10threshold) 
    IR10Triggered = true;
  else if (IR10 >= IR10threshold)
    IR10Triggered = false;

  if (IR10Triggered && !cell10SpiralAdded) {
    cell10.add(new Cell(cellWidth, 2*cellWidth, 2*cellHeight, 3*cellHeight));
    Cell cell = cell10.get(cell10.size() - 1);
    cell.generate();

    cell10SpiralAdded = true;
  } 

  if (IR10Triggered && cell10SpiralAdded) {
    for (Cell cell : cell10) {
      cell.display();
    }
  } 
  if (!IR10Triggered && cell10SpiralAdded) {
    for (Cell cell : cell10) {
      cell.display();
    } 
    cell10SpiralAdded = false;
  } 
  if (!IR10Triggered && !cell10SpiralAdded) {
    for (Cell cell : cell10) {
      cell.display();
    }
  }
  if (cell10.size() > spiralLim) {
    cell10.clear();
  }

  //SENSOR11
  if (IR11 < IR11threshold) 
    IR11Triggered = true;
  else if (IR11 >= IR11threshold)
    IR11Triggered = false;

  if (IR11Triggered && !cell11SpiralAdded) {
    cell11.add(new Cell(2*cellWidth, 3*cellWidth, 2*cellHeight, 3*cellHeight));
    Cell cell = cell11.get(cell11.size() - 1);
    cell.generate();

    cell11SpiralAdded = true;
  } 

  if (IR11Triggered && cell11SpiralAdded) {
    for (Cell cell : cell11) {
      cell.display();
    }
  } 
  if (!IR11Triggered && cell11SpiralAdded) {
    for (Cell cell : cell11) {
      cell.display();
    } 
    cell11SpiralAdded = false;
  } 
  if (!IR11Triggered && !cell11SpiralAdded) {
    for (Cell cell : cell11) {
      cell.display();
    }
  }
  if (cell11.size() > spiralLim) {
    cell11.clear();
  }

  //SENSOR12
  if (IR12 < IR12threshold) 
    IR12Triggered = true;
  else if (IR12 >= IR12threshold)
    IR12Triggered = false;

  if (IR12Triggered && !cell12SpiralAdded) {
    cell12.add(new Cell(3*cellWidth, width, 2*cellHeight, 3*cellHeight));
    Cell cell = cell12.get(cell12.size() - 1);
    cell.generate();

    cell12SpiralAdded = true;
  } 

  if (IR12Triggered && cell12SpiralAdded) {
    for (Cell cell : cell12) {
      cell.display();
    }
  } 
  if (!IR12Triggered && cell12SpiralAdded) {
    for (Cell cell : cell12) {
      cell.display();
    } 
    cell12SpiralAdded = false;
  } 
  if (!IR12Triggered && !cell12SpiralAdded) {
    for (Cell cell : cell12) {
      cell.display();
    }
  }
  if (cell12.size() > spiralLim) {
    cell12.clear();
  }
  //SENSOR13
  if (IR13 < IR13threshold) 
    IR13Triggered = true;
  else if (IR13 >= IR13threshold)
    IR13Triggered = false;

  if (IR13Triggered && !cell13SpiralAdded) {

    cell13.add(new Cell(0, cellWidth, 3*cellHeight, height));
    Cell cell = cell13.get(cell13.size() - 1);
    cell.generate();

    cell13SpiralAdded = true;
  } 

  if (IR13Triggered && cell13SpiralAdded) {

    for (Cell cell : cell13) {
      cell.display();
    }
  } 
  if (!IR13Triggered && cell13SpiralAdded) {

    for (Cell cell : cell13) {
      cell.display();
    } 
    cell13SpiralAdded = false;
  } 
  if (!IR13Triggered && !cell13SpiralAdded) {

    for (Cell cell : cell13) {
      cell.display();
    }
  }
  if (cell13.size() > spiralLim) {
    cell13.clear();
  }

  //SENSOR14
  if (IR14 < IR14threshold) 
    IR14Triggered = true;
  else if (IR14 >= IR14threshold)
    IR14Triggered = false;

  if (IR14Triggered && !cell14SpiralAdded) {
    cell14.add(new Cell(cellWidth, 2*cellWidth, 3*cellHeight, height));
    Cell cell = cell14.get(cell14.size() - 1);
    cell.generate();

    cell14SpiralAdded = true;
  } 

  if (IR14Triggered && cell14SpiralAdded) {
    for (Cell cell : cell14) {
      cell.display();
    }
  } 
  if (!IR14Triggered && cell14SpiralAdded) {
    for (Cell cell : cell14) {
      cell.display();
    } 
    cell14SpiralAdded = false;
  } 
  if (!IR14Triggered && !cell14SpiralAdded) {
    for (Cell cell : cell14) {
      cell.display();
    }
  }
  if (cell14.size() > spiralLim) {
    cell14.clear();
  }

  //SENSOR15!!!
  if (IR15 < IR15threshold) 
    IR15Triggered = true;
  else if (IR15 >= IR15threshold)
    IR15Triggered = false;

  if (IR15Triggered && !cell15SpiralAdded) {
    cell15.add(new Cell(2*cellWidth, 3*cellWidth, 3*cellHeight, height));
    Cell cell = cell15.get(cell15.size() - 1);
    cell.generate();

    cell15SpiralAdded = true;
  } 

  if (IR15Triggered && cell15SpiralAdded) {
    for (Cell cell : cell15) {
      cell.display();
    }
  } 
  if (!IR15Triggered && cell15SpiralAdded) {
    for (Cell cell : cell15) {
      cell.display();
    } 
    cell15SpiralAdded = false;
  } 
  if (!IR15Triggered && !cell15SpiralAdded) {
    for (Cell cell : cell15) {
      cell.display();
    }
  }
  if (cell15.size() > spiralLim) {
    cell15.clear();
  }

  //SENSOR16!!!
  if (IR16 < IR16threshold) 
    IR16Triggered = true;
  else if (IR16 >= IR16threshold)
    IR16Triggered = false;

  if (IR16Triggered && !cell16SpiralAdded) {
    cell16.add(new Cell(3*cellWidth, width, 3*cellHeight, height));
    Cell cell = cell16.get(cell16.size() - 1);
    cell.generate();

    cell16SpiralAdded = true;
  } 

  if (IR16Triggered && cell16SpiralAdded) {
    for (Cell cell : cell16) {
      cell.display();
    }
  } 
  if (!IR16Triggered && cell16SpiralAdded) {
    for (Cell cell : cell16) {
      cell.display();
    } 
    cell16SpiralAdded = false;
  } 
  if (!IR16Triggered && !cell16SpiralAdded) {
    for (Cell cell : cell16) {
      cell.display();
    }
  }
  if (cell16.size() > spiralLim) {
    cell16.clear();
  }
}

//Now for the function to communicate with Arudino
void serialEvent(Serial myPort) {
  //The incoming information is a reading from the communication port.
  int inByte = myPort.read();

  if (!firstContact) {       //If there has been no hand extended from Arduino
    if (inByte == 'A') {     //and an A comes in from Arduino,
      myPort.clear();        //clear the port buffer,
      firstContact = true;   //because a hand has been extended.
      myPort.write('A');     //Send an A back to shake.
    }
  } else {                                   //If a handshake has occured,
    serialInArray[serialCount] = inByte;     //fill up that array with the incoming information
    serialCount++;                           //by iterating over the array.
 
    if (serialCount > 15) {                  //When the array is over 15
      IR1 = serialInArray[10];               //define all of the positions of the array according to the wired inputs.
      IR2 = serialInArray[8];                //Yes, I know their messy.
      IR3 = serialInArray[4];                //Yes, it bothers me, too.
      IR4 = serialInArray[2];                //They were once all so pretty and ordered,
      IR5 = serialInArray[11];               //but alas,
      IR6 = serialInArray[12];               //it is easier to change the code,
      IR7 = serialInArray[3];                //than to re-solder 48 wires,
      IR8 = serialInArray[5];                //a third time.
      IR9 = serialInArray[15];
      IR10 = serialInArray[13];
      IR11 = serialInArray[6];
      IR12 = serialInArray[1];
      IR13 = serialInArray[9];
      IR14 = serialInArray[14];
      IR15 = serialInArray[7];
      IR16 = serialInArray[0]; 
      delay(250);                            //Delay to make life easier. It's hard to read numbers as fast as draw updates them. 
      //Print numbers to set thresholds
      //println(IR1 + "\t" + IR2 + "\t" + IR3 + "\t" + IR4 + "\t" + IR5 + "\t" + IR6 + "\t" + IR7 + "\t" + IR8 + "\t" + IR9 + "\t" + IR10 + "\t" + IR11 + "\t" + IR12 + "\t" + IR13 + "\t" + IR14 + "\t" + IR15 + "\t" + IR16);
      myPort.write('A');                     //Keep reaching out that hand
      serialCount = 0;                       //and reset the count for the next batch of values.
    }
  }
}
