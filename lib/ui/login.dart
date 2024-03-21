import 'package:ecommerce/designs/ResponsiveInfo.dart';
import 'package:ecommerce/ui/registration.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/ui/home.dart';

class Login extends StatefulWidget {
   Login() ;

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController usercontroller=new TextEditingController();
  TextEditingController passwordcontroller=new TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xfff1f5f9),

      body:  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[


          Padding(padding: EdgeInsets.all(10),
            child:      Image.asset("assets/images/colorlogo.png",width: ResponsiveInfo.isMobile(context)? 120 : 150,height: ResponsiveInfo.isMobile(context)? 120 : 150,),


          ),

          Padding(
            padding:  EdgeInsets.all(ResponsiveInfo.isMobile(context)? 10 : 15),
            // padding: EdgeInsets.symmetric(horizontal: 15,vertical: 50),
            child: TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Username',
                  hintText: 'Username'),
              controller: usercontroller,
            ),
          ),
          Padding(
            padding:  EdgeInsets.all(ResponsiveInfo.isMobile(context)? 10 : 15),
            //padding: EdgeInsets.symmetric(horizontal: 15),
            child: TextField(

              obscureText: true,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                  hintText: 'Enter secure password'),
              controller: passwordcontroller,
            ),
          ),

          Padding(padding: EdgeInsets.all(ResponsiveInfo.isMobile(context)? 10 : 15),
            child: Container(
    width: double.infinity,
    height: ResponsiveInfo.isMobile(context)?50:65,
    decoration: BoxDecoration(
    color: Color(0xff255eab),
    border: Border.all(color: Color(0xff255eab)),
    borderRadius: BorderRadius.all(Radius.circular(ResponsiveInfo.isMobile(context)? 10 : 15))

    ),
              child:  TextButton(
                child: Text( 'Log in ', style: TextStyle(color: Colors.white, fontSize: ResponsiveInfo.isMobile(context)?12:14),
                ),
                onPressed: ()async{


                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder:
                                (context) =>
                                MyDashboardPage()
                            )
                        );

                },

              ),

            ),
          ),

          SizedBox(
            height: ResponsiveInfo.isMobile(context)?20:25,
          ),
          Container(
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    Padding(
                      padding:  EdgeInsets.only(left: ResponsiveInfo.isMobile(context)?5.0:7.0),
                      child: Text('Don\'t you have an account? ',style: TextStyle(color: Colors.black87, fontSize: ResponsiveInfo.isMobile(context)?14:17)),
                    ),

                    Padding(
                      padding:  EdgeInsets.only(left:ResponsiveInfo.isMobile(context)?1.0 : 3.0),
                      child: InkWell(
                          onTap: (){
                            print('hello');

                            Navigator.push(context,
                                MaterialPageRoute(builder:
                                    (context) =>
                                    Registration()
                                )
                            );
                          },
                          child: Text('Register', style: TextStyle(fontSize: ResponsiveInfo.isMobile(context)?14:17, color: Colors.blue),)),
                    )
                  ],
                ),
              )
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
