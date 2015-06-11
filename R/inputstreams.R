##' @export
opencam <- function(device=0)
    {
        cam <- open_camera(device)
        attr(cam,"class") <- "istream"
        attr(cam,"type") <- "camera"
        attr(cam,"device") <- device
        cam
    }

##' @export
openvideo <- function(fname)
    {
        str <- open_stream(fname)
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

getBlock <- function(str,nFrames)
    {
        next_block(str,nFrames)
    }
    
