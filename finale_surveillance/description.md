# Introduction
This is my final project for my Introduction to Interactive Media class. Conceptually, it inverts surveillance in two proimary ways. Normally, anonymous individuals sit in enclosed spaces, surveiling group and public spaces from a private space. In this istallation, the indidivudal in an enclosed space is surveilled by the public. Furthermore, instead of using the surveillance data for means of prosecution or exploitation, this data is translated into pleasing visuals.

From the start, I knew I wanted to do something with the human body moving through space. For inspiration, I started going through previous year's projects and moved on to the portfolios of the professors in the Interacitve Media program at NYUAD, as well as those of several in the ITP program at NYU New York. Two of Professor Aaron Sherwood's projects ([1](http://aaron-sherwood.com/works/micro/), [2](http://aaron-sherwood.com/works/firewall/)), as well as discussions around data privacy and surveillance in my Communications & Technololgy class ended up providing the main inspiration for my project. After bringing several brainstormed projects into conversations with professors and peers, I settled on creating a hallway with a series of invisible tripwires. When tripped, a continuous sound changes, providing feedback to the individual in the space that their movement causes change. Simultaneously, the position of the person in the hallway is translated into a pleasing visual displayed for the public on the outside of the hallway.

Special thanks to Lab Manager and Instructor Ume Hussein, Instructor Jack Du, Professor Michael Shiloh, Professor Aaron Sherwood, Mari Calderon, Adham Chakohi, Instructor Judi Olsen, and Professor Matthew Karau. Without the support of their technical suggestions and the support resources, this project would have died on the page. I also want to thank my peers who came to user test and pushed me to keep working on it even I was burnt out: Sofia, Yoon, Tala, and Kyle.

# Process

As stated earlier, I started with an early-stage research cycle of brainstorming-researching-discussing-brainstorming-researching-etc. Once I settle on the concept, I jumped into talks with the lab manager and instructor and professors as soona as possible to secure space and materials. I must have sent two dozen emails in the first several days just to ensure I would have everything. I did not want to be in the final hour missing a something dumb like fabric to project on. In between emails, I started working.

## Sensors

I started by figuring out the most urgent unkown: what sensor would I use to detect motion. I spoke to senior Mari Calderon, who had put together a series of sensors that detected footsteps and played musical notes as people walked up stairs. She had used ultrasonic distance sensors, but admitted that she should have used Infrared Distance sensors instead. Apparently, they were more consistent and easier to work with. I proceeded to check out two Sharp IR distance sensors, model [GP2Y0A710K0F](https://www.adafruit.com/product/1568) with a range between 2 and 5 meters. I then used the code from [this guide](https://www.makerguides.com/sharp-gp2y0a710k0f-ir-distance-sensor-arduino-tutorial/) and trash cans to figure out exactly how the sensors worked.

![Trash Can Testing](https://github.com/bassmonkey620/Intro-to-IM/edit/master/finale_surveillance/referenceMedia/trashCanTests.jpg)

Once I had that figured out, I talked to the lab manager about checking out at least 16 in order to adequately cover the entire space. The lab did not have enough of the 2 to 5 meter range ones, but they did have plenty of 20cm to 150cm ones, model [GP2Y0A02YK](https://www.adafruit.com/product/1031). Luckily, the Sharp library for IR sensors has code for all the models, and the width of the hallway was 1.5 meters. I simply checked out these and then tested them to ensure they worked in the same way. They did. Before I could move to install, though, I had to solve the problem of inputs. The Arduino Uno I had only had five analog inputs. I needed 16. Luckily, Professor Shiloh had an Arduino Mega, so I was able to wire them all and test it all out.

PICTURE

In the final version, each sensor detects the approximate distance to the wall, sending that number to processing, which takes it and compares it to a threshold. As long as that distance is over the threshold, nothing happens. As soon as an object comes between the wall and the sensor, that number drops below the threshold, triggering the production of a spiral and a change in the audio. The thresholds were determined by watching the numbers processing received from the Arduino once I had the initial install completed. Each distance sensor had to be individually tuned because even though the numbers received were average distances of several measurements of the sensor, there was still a range between ten and thirty that I had to set the threshold below.

## Visuals

When I was waiting for responses, approval for the space (asking for 1.5m x 2m x 2.2m of space for an Intro project was a risk), and responses to inquiries for materials, I started working on the visuals. I had noticed during my tesselations project that if I put the rotate function inside of a particular if loop, then instead of a spinning grid, a crazy spiral would start spinning. I wondered if I could code a series of spirals that would behave like water droplets on a still lake, appearing and disappearing as each IR sensor was triggered. After several days of playing with it, I ended up with spirals that would appear and disappear on their on.

SCREENSHOT

Each spiral that appears in consists of a three nested object classes. The first class is simply a square which I can access the opacity of, called Dot. While a small thing, accessing the opacity at this level allows for the spirals to disappear a little bit with every frame. Dots also rotate in the opposite direction of the spiral. The second class is called spiral, and consists of drawing a Dot, changing position along the path of a spiral, drawing another Dot, and so on, up to a limited number of dots. The third class, Called cells, defines an area on the sketch and randomly generates a Spiral in that area.For the final code, I created sixteen array lists of Cells with defined areas that divided the space of the sketch into sixteen even spaces, with each space corresponding to a particular sensor.

## Audio

After the visuals were finished, I moved on to the audio. After a bit of rummaging around the internet for interesting sounds, I settled on creating a simple pianno arpeggio loop using [free mp4 files from the University of Iowa](http://theremin.music.uiowa.edu/MISpiano.html) and the open source audio mixing program [Audacity](https://www.audacityteam.org/). 
SCREENSHOT
The final audio file plays this sequence (base not for each chord bolded): **A4**-C5-E5-A5-E5-**F4**-A4-C5-F5-C5-**G4**-B4-D5-G5-D5-**E4**-G4-B4-E5-B4. Once I had the file made, I started playing around with the Sound library in processing, and ultimately decided to use the different rows and columns of sensors to change playback speed and volume. In the end, however, the audio ended up being the greatest headache.

## Initial Build

With the visuals, sensors, and audio worked out, I moved to install as soon as the exhibition space was reserved. For the walls, I used two shelving units provided by Professor Michael Shiloh. Intitially, one had five shelves and one had four, and none of them were evenly spaced, so I had had to take them apart and put them back together.

PICTURE OF SHELVES x 2

I then figured out where to position each sensor on the shelves and where I would put my Arduino and solderless breadboard. With these positions determined, I measured distances and soldered solid-core wire extensions onto each sensor's three wires that were a bit longer than needed. I then installed these with zipties. 

PICTURE OF INITIAL BUILD

After that, I set up the speakers I would be working with and started to do different tests with different audio effects. I initially tried to have each row responsible from playback speed and each column responsible for volume. However, this did not work out because the way I had it coded meant for awkward, difficult to understand jumps between playback speeds and volumes. With only the volume, the interaction was much clearer, but still incredibly jumpy and a bit confusion. The jumpiness was caused by the fact that I set the amplitude and playback speed to change to a set value as soon as a sensor was activated. I wanted a gradual shift but had not idea how to do that at the time. With a deadline coming, I scrapped the playback effect, pulled the curtain over the outside of the independent wall, and set up a projector to project the visuals onto that curtain. I also cut the wires to nearly exact lengths and cabled the wires for each sensor together with duct tape. It was not time for user testing.

## User Testing

I asked four friends who I knew would not spare my feeling to come user test the installation. Two are from non-IM majors and had no experience with physical computing and interactive art. The other two had been in the Interactive Media program for at least a semester. The first and last user testing sessions were indidivual, while the one in between had both one non-IM major and one IM major. For each session, I had a user walk into the hallway and move around. After a few minutes, I would have then come out and watch the visuals while I (or the other user) walk into the space. We would then talk about the interaction. After a few initial questions, I would explain the concept and ask about improvements or changes they would make.

INSERT VIDEO FROM FIRST SESSION

With the first user, I notice how she tried to reach into the wall several times. With our conversation after, she said that the wires made the sensors really obvious and that didn't make sesne with the concept of surveillance. Cameras and microphones usually blend into the background unless you look for them. She also talked about the inversion of the public-private relationship typical of surveillance (described in the introduction).

INSERT VIDEO FROM SECOND SESSION

During the second session, I realized I have to hide the wires. One user reached into the wall and started playing with some equipment I left out and the other said she wanted to play them like guitar strings because of the background melody. I also started to realize a trend. Both users understood the project when the went from the inside to the outside, but not when they went from the outside to the inside. Once I explained the concept and the technical aspects behind the interaction, they both suggested that I increase the contrast between an old spiral and a new spiral so that the link between spiral generation and user position was more clear. This could be done by speeding up their appearance and disappearance, increasing the number populated, or changing the color.
After these first two sessions, I cut and installed fabric to cover each shelf and hide the wires. I held off on implementing the other feedback from the second session, but ultimately sped up the appearance and disappearance of the spirals because increasing the number populated caused lag and changing the color was simply messy. The third session, hence, had covered wires but no change in the visuals.

INSERT VIDEO FROM THIRD SESSION

After the thrid session, the user told me that I needed to have a much clearer idication from the audio for the interaction. After that, I experimented and returned to having the rows responsible for the playback. I also increased the contrast between different levels of volume, setting the default extremely low so that the user walked in and immediately noticed a difference. It sounded unsatisfying, but at least it was clear something was changing, I thought.

## Last Minute Changes

With two hours to go before presenting the project to the class, the Lab Manager, Ume Hussein, and Professor Sherwood checked in with me. After looking at the visuals, Ume offered me a white sheet to project on. After hearing the jumpy audio, Professor Sherwood explained and gave me a smoothing formula to provide transistions in my audio. While this is explained in the code, essentially, instead of having each sensor responsible for changing the level of volume and playback speed, I have each sensor responsible for a different target volume and playback speed, and have the program constantly move toward those targets. This worked much better, and ultimately saved what was an unsatisfying interaction. With the sheet installed and the smoothing formula implemented, it was time for the showcase.

IMAGE FROM SHOWCASE
TWO VIDEOS from SHOWCASE

## Main Learnings

Comment as you program. It's not fun going back through a long program at the end and describing everything.

If you can, talk to the people whose projects inspired you from the start. They probably can anticipate problems you'll encoutner better than you can, and they'll already have solutions.

Learn to take better documentation videos.

Don't be afraid to ask for what you need. Just be clear and make sure everything is justified by a valid conceptual or physical constraint.

Measure wire lengths before you soldering anything. Doing 48 wires twice is terrible.
