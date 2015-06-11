This is an add-on package for [imager](https://github.com/dahtah/imager) to support out-of-memory video processing in R. This package should be considered experimental, meaning it's under-documented, under-tested, and I'm likely to tinker with the API. That said, it's still fun to play with, and which other R package will let you do statistics on what your face looks like on the webcam?

The package is based on [OpenCV](http://opencv.org) and [CImg](http://cimg.eu).

Features:

- read and process video data frame-by-frame, no need to load the entire thing into memory
- capture video from cameras or read from a file
- save results to a video file or pipe to a display 

You need to install OpenCV separately. Under Linux this should be easy, e.g. under Ubuntu/Mint:

	sudo apt-get install libopencv-dev

should pull all the packages you'll need. On other platforms installing OpenCV is a bit more work. 

Once you have the OpenCV headers and shared libraries you can compile and install the package using devtools:

	library(devtools)
	install_github("dahtah/imager")
	install_github("dahtah/imagerstreams")

Sample code:

	library(imagerstreams)
	cam <- opencam() #Open a camera input stream
	frames <- rlply(20,getFrame(cam)) #Grab the next 20 frames
	#Denoise and play
	llply(frames,blur_anisotropic,amplitude=10) %>% imappend("z") %>% play(loop=TRUE)
	close(cam)
