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
print.ostream <- function(str)
    {
        att <- attributes(str)
        if (isdisplay(str))
            {
                msg <- with(att,sprintf("Display. Dim: %i x %i (pix)",width,height))
            }
        ## else if (att$type == "file")
        ##     {
        ##         msg <- with(att,sprintf("Video file %s. Dim %i x %i (pix). Number of frames %i",fname,width,height,nframes))
        ##     }
        print(msg)
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
    }

##' @export
close.ostream <- function(str)
    {
        if (isdisplay(str))
            {
                close_display(str)
            }
    }
