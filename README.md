# chdk
Scripts for the Canon Hack Development Kit (CHDK). The 
CHDK is an alternative operating system for Canon Cameras, which is stored on the SD card and provides additional fuctionality. For the Venus transit in 2012 I got a Canon G12 and as I was already interested in timelapses, but had to take each image manually with my previous camera, hence I explored that part of the CHDK. The scripts were used until 2018, when the camera started to fail. The variable names and comments are in German, as I didn't think about putting the scripts on Github then.

### zeitkurz.bas
A simple script that kept the focus at a fixed position and then just took picture after picture, with, when the exposure time was short, a frame rate of about 0.5 fps.

### zeitanp.bas
A more sophisticated script that allowed to change the frame rate and which would modify the camera settings to keep the histogram more or less stable by either change the exposure time, iris, or ISO.
