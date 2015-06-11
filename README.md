This is an add-on package for imager to support out-of-memory video processing in R. Currently below alpha software.

You need to install OpenCV separately. Under Linux this should be easy, e.g. under Ubuntu/Mint:

	sudo apt-get install libopencv-dev

should pull all the packages you'll need. On other platforms installing OpenCV is a bit more work. 

Once you have the OpenCV headers and shared libraries you can compile and install the package using devtools:

	library(devtools)
	install_github("dahtah/imagerstreams")

