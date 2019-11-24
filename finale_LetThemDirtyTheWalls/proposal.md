Description
Let Them Dirty the Walls generates art from the movement of physical bodies through space. Participants move through  a hallway open at both ends (2m X 1.5m X 2.2M), with one wall independent of the structure of the space. One wall features embedded infrared sensors and a speaker. As participants move through the hallway, the infrared sensors detect their presence, and a continuous sound playing from the speaker changes, indicating to the participant that movement causes a change. On the other side of the independent wall and out of view of the participants, a projection of a black background with the piece’s title in white font displays to the rest of the room. As the participants move, the infrared sensors communicate their location to a processing sketch, which populates dynamic graphics in areas corresponding to the position of the participants. As time passes, these graphics will fade to make room for the other movements.

*List of parts*
Arduino parts:
  Arduino Uno x 3-4
  digital active infrared sensors x 18-24
  computer with 3-4 USB inputs
	breadboards
	solid core wire
	speaker x 3-4 (one for each arduino)
	May need tin foil/black rubber/pvc to direct sensors
Independent wall parts:
	Cardboard boxes OR shelf unit OR classroom barriers OR I build one…:’(
	Black fabric (to black external light)
	Whtie fabric (to project on)
	Projector
	Fastener/adhesive (to hold sensors)
	
 *Arduino Code*
  Make arduino wait until handshaking has occurred
  Remember the function to send a trigger byte to processing
  For each infrared sensor:
    detect the state of the infrared sensor
    send the state of the infrared sensor to processing
    if a particular sensor is activated,  play a particular tone (or a particular mp3 file)
*Processing Code*
Make the background black with white text: “Let them dirty the walls.”
Communication with Arduino (call & response):
  Import serial library
  For each active port, declare port
    Create serial portArray for each active port
    Start serial count for each active port for handshaking
    Declare and set boolean for handshaking
    Declare booleans to be manipulated by the arduino (boolean IRTriggered1, IRTriggered2,...)
  For each port, set up serialEvent function 
    Read the incoming bytes
    If handshaking has not occurred, reset buffer and keep requesting trigger for handshaking.
    Otherwise, let’s change those variables:
      add the last IR sensor state to the array
      If the serial array size is greater than one less than the number of IR sensors tied to       the Arduino sending to this port, then set the corresponding IRTriggered booleans             according to the incoming readings.
      Request new readings and reset.
Generative Artwork:
  Create a class for graphic objects. (Maybe reuse galaxy hexagons?)
  Declare an array of those objects.
  If an IR sensor boolean is triggered:
    add objects (1 or many) to that array.
    then set x, y coordinates to random range of the chosen quadrant for that IR sensor
      Overlapping is okay
ProjectionMapping
  Use SurfaceMapper GUI (link!)

*Learning/Concern Questions*
What is the range of the active IR sensors?
How do I use the SM GUI?
Where does the projector need to be mounted?
Will I need to power each distance sensor independently?

