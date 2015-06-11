##' @export
opendisplay <- function(w=640,h=480,title="")
    {
        dsp <- open_display(w,h,title)
        attr(dsp,"class") <- "ostream"
        attr(dsp,"width") <- w
        attr(dsp,"height") <- h
        attr(dsp,"type") <- "display"
        dsp
    }

##' @export
openvideowriter <- function(fname,w=640,h=480)
    {
        str <- open_ostream(fname,w,h)
        attr(str,"class") <- "ostream"
        attr(str,"fname") <- fname
        attr(str,"width") <- w
        attr(str,"height") <- h
        attr(str,"type") <- "writer"
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

##' @export
writeFrame <- function(str,im)
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

##' @export
close.ostream <- function(str)
    {
        if (isdisplay(str))
            {
                close_display(str)
            }
    }
