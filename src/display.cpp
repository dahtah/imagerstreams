#include <Rcpp.h>
#include "CImg.h"
#include "wrappers.h"


using namespace Rcpp;
using namespace cimg_library;


//' @export
// [[Rcpp::export]]
XPtr<cimg_library::CImgDisplay> open_display(int width,int height,std::string title="")
{
  CImgDisplay*  dsp = new CImgDisplay(width,height,title.c_str());
  Rcpp::XPtr<CImgDisplay> ptr(dsp, true) ;
  return ptr;
}

//' @export
// [[Rcpp::export]]
void close_display(Rcpp::XPtr<cimg_library::CImgDisplay> dsp)
{
  dsp->close();
  return;
}

//' @export
// [[Rcpp::export]]
void display_show(Rcpp::XPtr<cimg_library::CImgDisplay> dsp,NumericVector im)
{
  CImg<double> img = as< CImg<double> >(im);
  dsp->display(img);
  return;
}

