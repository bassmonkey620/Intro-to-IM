/*Arduino code for my introduction to Interactive Media final project
  IR sensor code from https://www.makerguides.com */

//import sharp library
#include <SharpIR.h>
// Define model and input pins:
#define IRPin1 A0
#define IRPin2 A1
#define IRPin3 A2
#define IRPin4 A3
#define IRPin5 A4
#define IRPin6 A5
#define IRPin7 A6
#define IRPin8 A7
#define IRPin9 A8
#define IRPin10 A9
#define IRPin11 A10
#define IRPin12 A11
#define IRPin13 A12
#define IRPin14 A13
#define IRPin15 A14
#define IRPin16 A15

/* Model :
  GP2Y0A02YK0F --> 20150
  GP2Y0A21YK0F --> 1080
  GP2Y0A710K0F --> 100500
  GP2YA41SK0F --> 430
*/

#define model 20150

// Create variables to store the distance:
int dis1;
int dis2;
int dis3;
int dis4;
int dis5;
int dis6;
int dis7;
int dis8;
int dis9;
int dis10;
int dis11;
int dis12;
int dis13;
int dis14;
int dis15;
int dis16;

//create instance of Sharp IR class for each sensor
SharpIR sensor1 = SharpIR(IRPin1, model);
SharpIR sensor2 = SharpIR(IRPin2, model);
SharpIR sensor3 = SharpIR(IRPin3, model);
SharpIR sensor4 = SharpIR(IRPin4, model);
SharpIR sensor5 = SharpIR(IRPin5, model);
SharpIR sensor6 = SharpIR(IRPin6, model);
SharpIR sensor7 = SharpIR(IRPin7, model);
SharpIR sensor8 = SharpIR(IRPin8, model);
SharpIR sensor9 = SharpIR(IRPin9, model);
SharpIR sensor10 = SharpIR(IRPin10, model);
SharpIR sensor11 = SharpIR(IRPin11, model);
SharpIR sensor12 = SharpIR(IRPin12, model);
SharpIR sensor13 = SharpIR(IRPin13, model);
SharpIR sensor14 = SharpIR(IRPin14, model);
SharpIR sensor15 = SharpIR(IRPin15, model);
SharpIR sensor16 = SharpIR(IRPin16, model);

//initialize inByte for serial communication
int inByte = 0;

void setup() {
  //start serial communication at a baud rate of 9600
  Serial.begin(9600);
  //do nothing when no handshaking has occured
  while (!Serial) {
    ;
  }
  //try to handshake with processing
  establishContact();
}

void loop() {
  if (Serial.available() > 0) { //If there is space to store information,

    inByte = Serial.read();      //store the incoming information.

    //Get a distance measurement from each sensor,
    dis1 = sensor1.distance();
    dis2 = sensor2.distance();
    dis3 = sensor3.distance();
    dis4 = sensor4.distance();
    dis5 = sensor5.distance();
    dis6 = sensor6.distance();
    dis7 = sensor7.distance();
    dis8 = sensor8.distance();
    dis9 = sensor9.distance();
    dis10 = sensor10.distance();
    dis11 = sensor11.distance();
    dis12 = sensor12.distance();
    dis13 = sensor13.distance();
    dis14 = sensor14.distance();
    dis15 = sensor15.distance();
    dis16 = sensor16.distance();
    //and send those distances through the serial port.
    Serial.write(dis1);
    Serial.write(dis2);
    Serial.write(dis3);
    Serial.write(dis4);
    Serial.write(dis5);
    Serial.write(dis6);
    Serial.write(dis7);
    Serial.write(dis8);
    Serial.write(dis9);
    Serial.write(dis10);
    Serial.write(dis11);
    Serial.write(dis12);
    Serial.write(dis13);
    Serial.write(dis14);
    Serial.write(dis15);
    Serial.write(dis16);
  }
}
//function for handshaking
void establishContact() {
  //If there is no space for communication
  while (Serial.available() <= 0) {
    Serial.print('A'); //reach out a hand for contact
    delay(300);        //every .3 seconds.
  }
}
