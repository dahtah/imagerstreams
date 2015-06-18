This is an add-on package for [imager](https://github.com/dahtah/imager) to support out-of-memory video processing in R. This package should be considered experimental, meaning it's under-documented, under-tested, and I'm likely to tinker with the API. That said, it's still fun to play with, and which other R package will let you do statistics on what your face looks like on the webcam?

The package is based on [OpenCV](http://opencv.org) and [CImg](http://cimg.eu).

## Features

- read and process video data frame-by-frame, no need to load the entire thing into memory
- capture video from cameras or read from a file
- save results to a video file or pipe to a display 


## Sample code

	library(imagerstreams)
	cam <- opencam() #Open a camera input stream
	frames <- rlply(20,getFrame(cam)) #Grab the next 20 frames
	#Denoise and play
	llply(frames,blur_anisotropic,amplitude=10) %>% imappend("z") %>% play(loop=TRUE)
	close(cam)

## How to install

Imager-streams relies on OpenCV, which is Linux-friendly and everything-else-unfriendly. Unfortunately I don't know what to do about this problem at this stage. I'll try to provide binaries in the future (if possible). 
The package installs successfully on Linux and Mac OS X. It should run on Windows but I haven't tested it yet and you'll need to update Makevars.win. If you do manage to make it run please let me know.

### Linux, Mac OS X

You need to install OpenCV first. Under Ubuntu/Mint:

	sudo apt-get install libopencv-dev

should pull all the packages you'll need. For instructions on how to install OpenCV on OS X, see [here](http://mac-opencv-projects.blogspot.fr/2014/01/installing-opencv-on-mac-os-x-1091.html).

Once you have the OpenCV headers and shared libraries you can compile and install the package using devtools:

	library(devtools)
	install_github("dahtah/imager")
	install_github("dahtah/imagerstreams")

### Windows

The following instuctions are just my best guess on how one should go about this. Grab the latest version of OpenCV, then make your own MinGW-compatible libraries following the instructions given [here](http://stackoverflow.com/questions/26397657/compiling-mingw-libs-for-opencv-under-windows). Mingw ships with Rtools, so there should be no need to install it separately.

Download the package, and add a file called Makevars.win in the src/ directory with the following contents:

	PKG_CPPFLAGS += -I"C:\opencv\build\include" 
	PKG_LIBS +=  -L"C:\opencv\build\x86\mingw\lib"-lgdi32 -lopencv_core245 -lopencv_highgui245 $(RCPP_LDFLAGS)

The trailing digits are for version 2.4.5, replace with the appropriate figure. If needed replace C:\opencv with the actual directory you put OpenCV in. You should now be able to run R CMD install or devtools::install. 

