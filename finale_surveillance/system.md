# Materials

## Electronic Components

1. Arduino Mega
![Arduino Mega Image](https://github.com/bassmonkey620/Intro-to-IM/blob/master/finale_surveillance/referenceMedia/arduinoMega.jpg)
2. GP2Y0A02YK IR distance sensor (20cm-150cm) x 16
3. JST connectors x 16
4. 12V AC-DC power supply
5. USB A to B cable
6. wired stereo speaker x 2
![Speakers Image](https://github.com/bassmonkey620/Intro-to-IM/blob/master/finale_surveillance/referenceMedia/stereoSpeakers.jpg)
7. Epson projector
![Projector Image](https://github.com/bassmonkey620/Intro-to-IM/blob/master/finale_surveillance/referenceMedia/projector.jpg)
8. long HDMI cable
9. HDMI to mini displayport
10. international extension chord 
11. computer with usb, aux, and mini displayport inputs

## Physical Components

1. Shelving unit; ~1m x 2.2m x ~.5m; four shelves
2. black fabric, at least 2 x 2.2m
3. black fabric, roughly 90cm x 60cm x 8
4. white fabric, roughly 2 x 2.2m
5. Projector hanging arm and clamp
6. Plastic rest for Arduino
7. zipties x 16

# System Diagram

![System Diagram](https://github.com/bassmonkey620/Intro-to-IM/blob/master/finale_surveillance/referenceMedia/systemDiagram.jpg)

# Explanation

## Overview and Arduino Code
The indepedent wall is made of two shelving units that stand roughly two meters high. These are placed 1.5 meters from the room wall. There are four shelves on each unti. 16 IR distance sensors are attached to the edges of these shelves with zipties at relatively equal intervals, creating a 4 x 4 grid of sensors. Wires run back into the shelves and connect to the Arduino Mega and solderless breadboard on the second shelf. Two stereo speakers are on opposite ends of the third shelves. The computer, a Microsoft Surface Pro 3 (4GB RAM, 128GB hardrive, i5 processor), sits in between them. On the other side of the independent wall is an Epson projector, powered by ceiling-mounted extension chords. An hdmi cable runs across the ceiling and dangles down into the independent wall. This HDMI cable is connected to an HDMI to mini displayport converter, which is plugged into the computer. The computer connects to the Arudino Mega via a USB-A to USB-B cable. Everything is plugged into and powered from a four-socket international extension chord underneath the shelves (which is plugged into a nearby wall socket). A black stage curtain is pulled out over the outside of the independent wall and wrapped around the end, secured with velcro strips. Binder clips hold a 2m x 2m sheet up on this curtain, on which the visuals are projected. Rectangles of black fabric, roughly 90cm by 60cm, are hung from the top of each shelf, hiding the cables, computer, speakers, and Arduino.

Each IR distance sensor repeatedly measures the distance to to the room wall. In the Arduino program, these measures are translated into an average distance and sent via serial communication to Processing, where they are stored in an array. Handshaking takes place before this to establish connection between the two programs. In Processing, each sensor is responsible for specific audiovisual parameters and has a particular threshold just below the lowest potential average measured distance to the room wall. When an object or individual passes in front of the IR distance sensor, the number sent to Processing drops below this threshold, and a boolean trigger changes from false to true. When an IR sensor is triggered in this way, the particular audiovisual paraemters go into effect.

## Processing Code

### Visuals

The processing sketch is effectively divided into sixteen equal sections. Each section corresponds to an array list of object type Cells (described later) for which each sensor is responsible. There is an additional boolean which checks when a Cell is added to the array list. When an IR distance sensor is triggered, it adds a Cell to the array list, generates a random position to start an object type Spiral (described later) from, and changes the Cell-added boolean to true. When the Cell-added and sensor-triggered booleans are true, every Cell in the array list of Cells for that sensor are updated, effectively generating a Spiral. When the Cell-added boolean is true, but the sensor-triggered boolean is false, the Cell-added bolean is set to false to allow for another spiral to generate if the individual retriggers the sensor while a Spiral is generating in that sensor's Cell. Frthermore, when both the Cell-added boolean and sensor-triggered booleans are booth false, the update contines to occur, allowing spirals to generate and fade after the user moves on from that particular sensor. Finally, if more than five Cells are populated into any areas array list, the array list clears. This prevents the program from being overwhelmeed by objects and lagging. 

A Cell is the highest level of a three-level nest of object classes. The base level is called Dot. Dots are squares that rotate and decrease in opacity with each frame. The second level is called Spiral. Spirals sequentially generate Dots on a pre-defined spiral line. They also rotate in the opposite direction of the Dots they generate. Cells are essentially Spirals with defineable boundaries for their origin. They allow for the processing sketch to be divided into sixteen equal sections, so every sensor can be responsible for a different part of the sketch.

### Audio

The audio loads an mp4 sound file that I created in Audacity and loops it. In draw, the amplitude and playback speed are constantly updated to variables. Each variable is defined by a smoothing function:

current amplitude = (desired amplitude - current amplitude) * amplitude scale factor
current playback speed = (desired playback speed - current playback speed) * playback scale factor

As a defensive measure, if loops prevent the values from going outside of accepted ranges of amplitude (-1 to 1) and playback speed (1 to 2). Also, each is constantly moving towards a default very slowly, allowing for the sound to continue when no one is around and to not jump down to default when someone is standing in between sensors

Each row of sensors is responsible for a particlar playback speed. The lowest row is responsible for the slowest playback speed and the highest row is responsible for the fastest. When a sensor from a particular row is activated, the desire playback speed is set to the playback speed that row is responsible for. Each column of sensors is responsible for a particular amplitude, such that as one moves down the hall, the volume increases. The mechanism is the same as described for playback speed. All of this allows the sound to change gradually rather than abruptly, and makes the interaction not clearer, but much more delightful.
