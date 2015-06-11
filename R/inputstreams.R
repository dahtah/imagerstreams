##' Open camera device
##'
##' Open camera device as an input stream ('istream') object
##' 
##' @param device device number
##' @return an istream object
##' @export
opencam <- function(device=0)
    {
        cam <- open_camera(device)
        attr(cam,"class") <- "istream"
        attr(cam,"type") <- "camera"
        attr(cam,"device") <- device
        cam
    }

##' Open video file as input stream
##'
##' Input streams are designed to be processed frame-by-frame, to avoid having to load the entire video into memory. This function opens a video file (mpeg, avi, etc.) and makes it available to R as input stream, to be queried e.g. using getFrame. 
##' Which file formats are supported probably depends on your OS and on how OpenCV was compiled. 
##' 
##' @param fname file name
##' @return an input stream (istream)
##' @seealso getFrame
##' @export
openvideo <- function(fname)
    {
        str <- open_stream(path.expand(fname))
        attr(str,"class") <- "istream"
        attr(str,"type") <- "file"
        attr(str,"fname") <- fname
        str
    }

isfile <- function(str)
    {
        attr(str,"type") == "file"
    }

iscam <- function(str)
    {
        attr(str,"type") == "camera"
    }

##' Total number of frames in video stream
##'
##' @param str an input stream
##' @export
nframes <- function(str)
    {
        if (isfile(str))
            {
                stream_info(str)$nframes
            }
        else
            {
                NA
            }
    }

##' @export
print.istream <- function(str)
    {
        att <- c(attributes(str),stream_info(str))
        if (att$type == "camera")
            {
                msg <- with(att,sprintf("Camera: device %i. Dim: %i x %i (pix)",device,width,height))
            }
        else if (att$type == "file")
            {
                msg <- with(att,sprintf("Video file %s. Dim %i x %i (pix). Number of frames %i",fname,width,height,nframes))
            }
        print(msg)
    }

##' @export
close.istream <- function(con,...)
    {
        close_stream(con)
    }

##' Jump to a certain frame in a video
##'
##' Depending on file format and on mysterious OpenCV behaviour you may or may not succeed in jumping to the exact location you want
##'
##' @param str an input stream
##' @param frame a frame number (default 1)
##' @export
goto <- function(str,frame=1)
    {
        if (isfile(str))
            {
                if (frame<1 | frame > nframes(str))
                    {
                        paste("Frame index should be between 1 and",nframes(str)) %>% stop
                    }
                stream_skipto(str,frame)
            }
        else
            {
                warning("goto has no effect on this device")
            }

    }

##' Grab frame from video stream
##'
##' getFrame grabs the current frame from video stream str and moves str forward by one frame. Note that *this function has side effects*, so that calling it twice generally results in two different return values.
##' 
##' @param str an input stream
##' @param skip skip the next *skip* frames (default 0)
##' @export
getFrame <- function(str,skip=0)
    {
        s <- 0
        while (s < skip)
            {
                next_frame(str)
                s <- s+1
            }
        next_frame(str)
    }


##' Grab frame block from video stream
##'
##' getBlock grabs the next k frames as a block, meaning as a single CImg image with depth k. Note that like getFrame *this function has side effects*, so that calling it twice generally results in two different return values.
##' 
##' @param str an input stream
##' @param nFrames how many frames to grab
##' @return a cimg object of depth nFrames or less (if there are fewer than nFrames frames remaining in the stream)
##' @export
getBlock <- function(str,nFrames)
    {
        next_block(str,nFrames)
    }
    
