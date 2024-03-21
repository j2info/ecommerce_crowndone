import 'package:flutter/cupertino.dart';

class ResponsiveInfo{


 static bool isMobile(BuildContext context)
{

  bool a=false;
  double width = MediaQuery.of(context).size.shortestSide;

  if(width<600)
    {
      a=true;
    }
  else{
    a=false;
  }

  return a;

}


 // static bool isTab(BuildContext context)
 // {
 //
 //   bool a=false;
 //   double width = MediaQuery.of(context).size.width;
 //
 //   if(width<1024)
 //   {
 //     a=true;
 //   }
 //   else{
 //     a=false;
 //   }
 //
 //   return a;
 //
 // }
 //
 //
 // static bool isSmallMobile(BuildContext context)
 // {
 //
 //   bool a=false;
 //   double width = MediaQuery.of(context).size.width;
 //
 //   if(width<=380)
 //   {
 //     a=true;
 //   }
 //   else{
 //     a=false;
 //   }
 //
 //   return a;
 //
 // }





}