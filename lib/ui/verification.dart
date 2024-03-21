import 'package:ecommerce/designs/ResponsiveInfo.dart';
import 'package:flutter/material.dart';
import 'membership.dart';

class Verification extends StatefulWidget {
   Verification() ;

  @override
  _VerificationState createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  TextEditingController usercontroller=new TextEditingController();
  TextEditingController passwordcontroller=new TextEditingController();






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xfff1f5f9),

      body:  Stack(

        children: <Widget>[

          Align(
            alignment: FractionalOffset.topCenter,
            child:  Padding(padding: EdgeInsets.fromLTRB(0, ResponsiveInfo.isMobile(context)?70.0:90.0 , 0, 0),
              child:      Image.asset("assets/images/mail.png",
                width: ResponsiveInfo.isMobile(context)? 60 : 80,height: ResponsiveInfo.isMobile(context)? 60 : 80,fit: BoxFit.fill),


            ),
          ),

          Align(
            alignment: FractionalOffset.topCenter,
            child: Padding(


              padding: EdgeInsets.fromLTRB(ResponsiveInfo.isMobile(context)?10:15,
                  ResponsiveInfo.isMobile(context)?140:170 , ResponsiveInfo.isMobile(context)?10:15, 0),
              child: Column(

                children: [
                  Text( 'Verify your email address', style: TextStyle(color: Colors.black, fontSize: ResponsiveInfo.isMobile(context)?20:25,fontWeight: FontWeight.bold)
                  ),

                  Text( '\n We have just sent an email verification link to your email. Please click on the link to verify your email address', style: TextStyle(color: Colors.black,
                      fontSize: ResponsiveInfo.isMobile(context)?14:16,fontWeight: FontWeight.normal)
                  ),

                  Padding(padding: EdgeInsets.fromLTRB(0, ResponsiveInfo.isMobile(context)?10:15, 0, 0),

                  child:RichText(
                    text: TextSpan(
               /*defining default style is optional */
                      children: <TextSpan>[
                        TextSpan(
                            text: ' If not auto redirected after verification, click on the ',
                            style: TextStyle(color: Colors.black,
                                fontWeight: FontWeight.normal,fontSize: ResponsiveInfo.isMobile(context)?15:17)),
                        TextSpan(
                            text: ' Continue',
                            style: TextStyle(color: Colors.black,
                                fontWeight: FontWeight.bold,fontSize: ResponsiveInfo.isMobile(context)?15:17)),
                        TextSpan(
                            text: ' button',
                            style: TextStyle(color: Colors.black,
                                fontWeight: FontWeight.normal,fontSize: ResponsiveInfo.isMobile(context)?15:17)),
                      ],
                    ),
                  ) ,

                  ),



                  Padding(padding: EdgeInsets.all(ResponsiveInfo.isMobile(context)? 20 : 30),
                    child: Container(
                      width: double.infinity,

                      decoration: BoxDecoration(
                          color: Color(0xff255eab),
                          border: Border.all(color: Color(0xff255eab)),
                          borderRadius: BorderRadius.all(Radius.circular(ResponsiveInfo.isMobile(context)? 10 : 15))

                      ),


                      child:  TextButton(
                        child: Text( 'Continue', style: TextStyle(
                            color: Colors.white, fontSize: ResponsiveInfo.isMobile(context)?14:17,fontWeight: FontWeight.bold),
                        ),
                        onPressed: ()async{

                          Navigator.push(context,
                              MaterialPageRoute(builder:
                                  (context) =>
                                      Membership()
                              )
                          );





                        },

                      ),

                    ),
                  ),

                Padding(padding: EdgeInsets.all(ResponsiveInfo.isMobile(context)? 20 : 30),
                  child:  Container(
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [

                            Padding(
                              padding:  EdgeInsets.only(left: ResponsiveInfo.isMobile(context)?5.0:7.0),
                              child: Text('Didn\'t receive the email ?',style: TextStyle(color: Colors.black87, fontSize: ResponsiveInfo.isMobile(context)?14:17)),
                            ),

                            Padding(
                              padding:  EdgeInsets.only(left:ResponsiveInfo.isMobile(context)?1.0 : 3.0),
                              child: InkWell(
                                  onTap: (){
                                    print('hello');

                                    // Navigator.push(context,
                                    //     MaterialPageRoute(builder:
                                    //         (context) =>
                                    //         Registration()
                                    //     )
                                    // );
                                  },
                                  child: Text('Click to resend',
                                    style: TextStyle(fontSize: ResponsiveInfo.isMobile(context)?14:17, color: Color(0xff2560ac),fontWeight: FontWeight.bold),)),
                            )
                          ],
                        ),
                      )
                  )),


                Padding(padding: EdgeInsets.all(ResponsiveInfo.isMobile(context)? 20 : 30),
                  child: Container(
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [

                            Padding(
                              padding:  EdgeInsets.only(left: ResponsiveInfo.isMobile(context)?5.0:7.0),
                              child: GestureDetector(
                                
                                child: Icon(Icons.arrow_back,color: Color(0xff2560ac),size:ResponsiveInfo.isMobile(context)?20.0:25.0 ,),
                              )
                            ),

                            Padding(
                              padding:  EdgeInsets.only(left:ResponsiveInfo.isMobile(context)?1.0 : 3.0),
                              child: InkWell(
                                  onTap: (){
                                    print('hello');

                                    // Navigator.push(context,
                                    //     MaterialPageRoute(builder:
                                    //         (context) =>
                                    //         Registration()
                                    //     )
                                    // );
                                  },
                                  child: Text('Back to login',
                                    style: TextStyle(fontSize: ResponsiveInfo.isMobile(context)?14:17, color: Color(0xff2560ac),fontWeight: FontWeight.bold),)),
                            )
                          ],
                        ),
                      )
                  ))



                ],

              )




            ),
          )






        ],
      ),


    );
  }

  showLoaderDialog(BuildContext context){
    AlertDialog alert=AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(margin: EdgeInsets.only(left: 7),child:Text("Loading..." )),
        ],),
    );
    showDialog(barrierDismissible: false,
      context:context,
      builder:(BuildContext context){
        return alert;
      },
    );
  }
}
