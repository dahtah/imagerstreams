#include <opencv2/highgui/highgui.hpp>
#include <iostream>
#include <Rcpp.h>
#define cimg_plugin1 "cvMat.h"
#include "CImg.h"
#include "wrappers.h"


using namespace Rcpp;
using namespace cv;
using namespace cimg_library;


// [[Rcpp::export]]
XPtr<cv::VideoWriter> open_ostream(std::string file,int width,int height,double frameRate=30)
{
  VideoWriter*  out = new VideoWriter(file.c_str(),CV_FOURCC('J','P','E','G'),frameRate,Size(width,height));
  if ( !out->isOpened() )  
    {
      stop("Cannot open file");
    }
  Rcpp::XPtr<VideoWriter> ptr(out, true) ;
  return ptr;
}

// [[Rcpp::export]]
void write_ostream(Rcpp::XPtr<cv::VideoWriter> str,NumericVector im)
{
  CImg<double> img = as< CImg<double> >(im);
  CImg<unsigned char> cvt(img);
  Mat M = cvt.get_MAT();
  str->write(M);
  return;
}


