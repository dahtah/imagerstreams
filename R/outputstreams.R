##' Open CImg display as output stream
##'
##' CImg comes with its own little display library, and this function opens a CImg window as an output stream, meaning you'll be able to "write" frames to the stream and they'll be displayed. Useful for debugging an analysis before saving the results to a proper stream
##' @param width: width, in pixels
##' @param height: height, in pixels
##' @return an output stream (of class "ostream")
##' @export
opendisplay <- function(width=640,height=480,title="")
    {
        dsp <- open_display(w,h,title)
        attr(dsp,"class") <- "ostream"
        attr(dsp,"width") <- width
        attr(dsp,"height") <- height
        attr(dsp,"type") <- "display"
        attr(str,"open") <- TRUE
        dsp
    }

##' Open an output stream to a video file
##'
##' An output stream to a video file lets you save results to the hard drive frame-by-frame.
##' For the moment all video streams are stored in the avi format with JPEG encoding.
##' Use writeFrame to write a frame to the stream. Use rm(stream) to close the stream explicitly.
##' 
##' @param fname file to store the input in
##' @param width width in pixels
##' @param height height in pixels
##' @param frameRate frame rate in frames/sec 
##' @seealso writeFrame
##' @export
openvideowriter <- function(fname,width=640,height=480,frameRate=30)
    {
        str <- open_ostream(path.expand(fname),width,height,frameRate)
        attr(str,"class") <- "ostream"
        attr(str,"fname") <- fname
        attr(str,"width") <- width
        attr(str,"height") <- height
        attr(str,"type") <- "writer"
        attr(str,"open") <- TRUE
        str
    }



##' @export
print.ostream <- function(str)
    {
        att <- attributes(str)
        if (isdisplay(str))
            {
                msg <- with(att,sprintf("Display. Dim: %i x %i (pix)",width,height))
            }
        if (iswriter(str))
            {
                msg <- with(att,sprintf("Video output to file: %s. Dim: %i x %i (pix)",fname,width,height))
            }

        
        ## else if (att$type == "file")
        ##     {
        ##         msg <- with(att,sprintf("Video file %s. Dim %i x %i (pix). Number of frames %i",fname,width,height,nframes))
        ##     }
        print(msg)
    }

iswriter <- function(str)
    {
        attr(str,"type") == "writer"
    }

isdisplay <- function(str)
    {
        attr(str,"type") == "display"
    }

##' Write a frame to an output stream
##' 
##' If the output stream is a file, this is an actual write operation. If it's a display stream, then the frame will be displayed.
##' @param str 
##' @param im
##' @export
writeFrame <- function(str,im)
    {
        if (!attr(str,"open"))
            {
                stop("Stream is closed")
            }
        else
            {
                
                if (isdisplay(str))
                    {
                        display_show(str,im)
                    }
                else if (iswriter(str))
                    {
                        write_ostream(str,im)
                    }
            }
    }

##' @export
close.ostream <- function(str)
    {
        if (isdisplay(str))
            {
                close_display(str)
                attr(str,"open") <- FALSE
            }
        if (iswriter(str))
            {
                close_ostream(str)
                attr(str,"open") <- FALSE
            }

    }
