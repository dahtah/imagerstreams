##' @export
run.demo <- function(duration=60)
    {
        dsp <- open_display(640,480,"Original image")
        dsp2 <- open_display(640,480,"2nd order edge filter")
        dsp3 <- open_display(640,480,"Median blur")
        t0 <- Sys.time()
        cam <- open_camera()
        while ((Sys.time() - t0) < duration)
            {
                im <- next_frame(cam)
                display_show(dsp,im)
                display_show(dsp2,deriche(im,axis="x",sigma=1,order=2))
                display_show(dsp3,medianblur(im,5,0))
            }
        close_display(dsp)
        close_display(dsp2)
        close_display(dsp3)
        close_stream(cam)
    }


