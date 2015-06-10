#include <opencv2/highgui/highgui.hpp>
#include <iostream>
#include <Rcpp.h>
#define cimg_plugin1 "cvMat.h"
#include "CImg.h"
#include "wrappers.h"


using namespace Rcpp;
using namespace cv;
using namespace cimg_library;

//' @export
//[[Rcpp::export]]
NumericVector getFrame(std::string file)
{
  VideoCapture cap(file.c_str());
  if ( !cap.isOpened() )  
    {
      stop("Cannot open file");
    }
  Mat frame;
  bool bSuccess = cap.read(frame); 
  if (!bSuccess) 
    {
      stop("Cannot read frame");
      
    }
  CImg<double> img(frame);
  return wrap(img);
}

//' @export
// [[Rcpp::export]]
XPtr<cv::VideoCapture> open_stream(std::string file)
{
  VideoCapture*  cap = new VideoCapture(file.c_str());
  if ( !cap->isOpened() )  
    {
      stop("Cannot open file");
    }
  Rcpp::XPtr<VideoCapture> ptr(cap, true) ;
  return ptr;
}

//' @export
// [[Rcpp::export]]
XPtr<cv::VideoCapture> open_camera(int device=0)
{
  VideoCapture*  cap = new VideoCapture(device);
  if ( !cap->isOpened() )  
    {
      stop("Cannot open device");
    }
  Rcpp::XPtr<VideoCapture> ptr(cap, true) ;
  return ptr;
}


//' @export
// [[Rcpp::export]]
void close_stream(Rcpp::XPtr<cv::VideoCapture> cap)
{
  cap->release();
  return;
}

//' @export
// [[Rcpp::export]]
void stream_skipto(Rcpp::XPtr<cv::VideoCapture> cap,int frame=1)
{
  cap->set(CV_CAP_PROP_POS_FRAMES,frame-1);
  if (cap->get(CV_CAP_PROP_POS_FRAMES) != frame - 1)
    {
      warning("Couldn't skip to exact frame");
    }
  return;
}


//' @export
// [[Rcpp::export]]
Rcpp::List stream_info(Rcpp::XPtr<cv::VideoCapture> cap)
{
  List out;
  out["width"] = cap->get(CV_CAP_PROP_FRAME_WIDTH);
  out["height"] = cap->get(CV_CAP_PROP_FRAME_HEIGHT);
  out["fps"] = cap->get(CV_CAP_PROP_FPS);
  //  std::string fourcc = cap->get(CV_CAP_PROP_FOURCC);
  out["nframes"] = cap->get(CV_CAP_PROP_FRAME_COUNT);
    return out;
}

//' @export
// [[Rcpp::export]]
Rcpp::List stream_status(Rcpp::XPtr<cv::VideoCapture> cap)
{
  List out;
  out["pos"] = cap->get(CV_CAP_PROP_POS_MSEC);
  out["frame"] = cap->get(CV_CAP_PROP_POS_FRAMES) + 1;
  out["t.rel"] = cap->get(CV_CAP_PROP_POS_AVI_RATIO);
  //  std::string fourcc = cap->get(CV_CAP_PROP_FOURCC);
  return out;
}



//' @export
// [[Rcpp::export]]
NumericVector next_frame(Rcpp::XPtr<cv::VideoCapture> cap)
{
  Mat frame;
  bool bSuccess = cap->read(frame); 
  if (!bSuccess) 
    {
      stop("Cannot read frame");
    }
  CImg<double> img(frame);
  return wrap(img);
}


