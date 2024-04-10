import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/designs/ResponsiveInfo.dart';
import 'package:ecommerce/ui/verification.dart';
import 'package:flutter/material.dart';

class Registration extends StatefulWidget {
  Registration();

  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  late var p1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff1f5f9),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(ResponsiveInfo.isMobile(context) ? 10 : 14),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Image.asset(
                        "assets/images/colorlogo.png",
                        width: ResponsiveInfo.isMobile(context) ? 120 : 150,
                        height: ResponsiveInfo.isMobile(context) ? 120 : 150,
                      ),
                    ),
                    flex: 1,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(4),
                          child: Text(
                            'Get onboard',
                            style: TextStyle(color: Colors.black, fontSize: ResponsiveInfo.isMobile(context) ? 20 : 25, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(4),
                          child: Text(
                            'Create Profile to start your journey',
                            style: TextStyle(color: Colors.black54, fontSize: ResponsiveInfo.isMobile(context) ? 10 : 13, fontWeight: FontWeight.normal),
                          ),
                        )
                      ],
                    ),
                    flex: 4,
                  )
                ],
              ),
            ),

            // TextFields for user registration details
            // Full Name
            buildTextField("Full Name", _nameController),
            // Email Address
            buildTextField("Email Address", _emailController),
            // Phone Number
            buildTextField("Phone Number", _phoneController,ismobile:true),
            // Password
            buildTextField("Password", _passwordController, isPassword: true),

            // Signup Button
            Padding(
              padding: EdgeInsets.all(ResponsiveInfo.isMobile(context) ? 10 : 15),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xff255eab),
                  border: Border.all(color: Color(0xff255eab)),
                  borderRadius: BorderRadius.all(Radius.circular(ResponsiveInfo.isMobile(context) ? 10 : 15)),
                ),
                child: TextButton(
                  onPressed: () async {
                    // Save user details to Firestore
                    await saveUserDetails();

                  },
                  child: Text(
                    'Signup',
                    style: TextStyle(color: Colors.white, fontSize: ResponsiveInfo.isMobile(context) ? 12 : 14, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.all(ResponsiveInfo.isMobile(context)? 10 : 15),
                child:Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(child: Container(
                      width: double.infinity,
                      height: ResponsiveInfo.isMobile(context)? 1 : 2,
                      color: Colors.black26,

                    ),flex: 3,),
                    Text(' Or ',style: TextStyle(color: Colors.black87, fontSize: ResponsiveInfo.isMobile(context)?14:17)),



                    Expanded(child: Container(
                      width: double.infinity,
                      height: ResponsiveInfo.isMobile(context)? 1 : 2,
                      color: Colors.black26,

                    ),flex: 3,)


                  ],


                )

            ),


            Padding(padding: EdgeInsets.all(ResponsiveInfo.isMobile(context)? 10 : 15),
              child: Container(


                  width: double.infinity,
                  height:ResponsiveInfo.isMobile(context)? 55 : 65 ,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black54),
                      borderRadius: BorderRadius.all(Radius.circular(ResponsiveInfo.isMobile(context)? 10 : 15))

                  ),


                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,

                    children: [

                      Padding(padding: EdgeInsets.all(5),
                        child:      Image.asset("assets/images/google.png",width: ResponsiveInfo.isMobile(context)? 30 : 40,height: ResponsiveInfo.isMobile(context)? 30 : 40,),


                      ),

                      TextButton(
                        child: Text( 'Continue with Google', style: TextStyle(color: Colors.black, fontSize: ResponsiveInfo.isMobile(context)?15:17,fontWeight: FontWeight.bold),
                        ),
                        onPressed: ()async{

                          // if(usercontroller.text.toString().isNotEmpty)
                          // {
                          //   if(passwordcontroller.text.toString().isNotEmpty)
                          //   {
                          //
                          //     showLoaderDialog(context);
                          //
                          //     String urlmethode=Constants.baseurl+Constants.login;
                          //
                          //     ApiServices apiservices=new ApiServices();
                          //     Map mp = new HashMap();
                          //     mp['username'] = usercontroller.text;
                          //     mp['password'] = passwordcontroller.text;
                          //     String? data= await  apiservices.postmethod(context, mp, urlmethode);
                          //
                          //     Navigator.pop(context);
                          //
                          //     var a=jsonDecode(data.toString());
                          //
                          //
                          //     UserdetailsEntity userdetails=UserdetailsEntity.fromJson(a);
                          //
                          //     if(userdetails.status==1)
                          //     {
                          //
                          //       final preferenceDataStorage = await SharedPreferences
                          //           .getInstance();
                          //
                          //
                          //       preferenceDataStorage.setString(Constants.userkey, data.toString());
                          //
                          //       Navigator.pushReplacement(context,
                          //           MaterialPageRoute(builder:
                          //               (context) =>
                          //               Home()
                          //           )
                          //       );
                          //
                          //
                          //     }
                          //     else{
                          //
                          //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          //         content: Text('Login Failed'),
                          //       ));
                          //     }
                          //
                          //
                          //   }
                          //   else{
                          //
                          //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          //       content: Text('Enter password'),
                          //     ));
                          //
                          //   }
                          //
                          //
                          //
                          // }
                          // else{
                          //
                          //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          //     content: Text('Enter username'),
                          //   ));
                          //
                          // }





                        },

                      ),
                    ],
                  )




              ),
            ),


            Padding(padding: EdgeInsets.all(ResponsiveInfo.isMobile(context)? 10 : 15),
              child: Container(


                  width: double.infinity,
                  height:ResponsiveInfo.isMobile(context)? 55 : 65 ,
                  decoration: BoxDecoration(
                      color: Color(0xff3877f2),
                      border: Border.all(color: Color(0xff3877f2)),
                      borderRadius: BorderRadius.all(Radius.circular(ResponsiveInfo.isMobile(context)? 10 : 15))

                  ),


                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,

                    children: [

                      Padding(padding: EdgeInsets.all(5),
                        child:      Image.asset("assets/images/fb.png",width: ResponsiveInfo.isMobile(context)? 30 : 40,height: ResponsiveInfo.isMobile(context)? 30 : 40,),


                      ),

                      TextButton(
                        child: Text( 'Continue with Facebook', style: TextStyle(color: Colors.white, fontSize: ResponsiveInfo.isMobile(context)?15:17,fontWeight: FontWeight.bold),
                        ),
                        onPressed: ()async{

                          // if(usercontroller.text.toString().isNotEmpty)
                          // {
                          //   if(passwordcontroller.text.toString().isNotEmpty)
                          //   {
                          //
                          //     showLoaderDialog(context);
                          //
                          //     String urlmethode=Constants.baseurl+Constants.login;
                          //
                          //     ApiServices apiservices=new ApiServices();
                          //     Map mp = new HashMap();
                          //     mp['username'] = usercontroller.text;
                          //     mp['password'] = passwordcontroller.text;
                          //     String? data= await  apiservices.postmethod(context, mp, urlmethode);
                          //
                          //     Navigator.pop(context);
                          //
                          //     var a=jsonDecode(data.toString());
                          //
                          //
                          //     UserdetailsEntity userdetails=UserdetailsEntity.fromJson(a);
                          //
                          //     if(userdetails.status==1)
                          //     {
                          //
                          //       final preferenceDataStorage = await SharedPreferences
                          //           .getInstance();
                          //
                          //
                          //       preferenceDataStorage.setString(Constants.userkey, data.toString());
                          //
                          //       Navigator.pushReplacement(context,
                          //           MaterialPageRoute(builder:
                          //               (context) =>
                          //               Home()
                          //           )
                          //       );
                          //
                          //
                          //     }
                          //     else{
                          //
                          //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          //         content: Text('Login Failed'),
                          //       ));
                          //     }
                          //
                          //
                          //   }
                          //   else{
                          //
                          //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          //       content: Text('Enter password'),
                          //     ));
                          //
                          //   }
                          //
                          //
                          //
                          // }
                          // else{
                          //
                          //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          //     content: Text('Enter username'),
                          //   ));
                          //
                          // }





                        },

                      ),
                    ],
                  )




              ),
            ),


            // Other UI elements...
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String labelText, TextEditingController controller, {bool isPassword = false,bool ismobile = false} ) {
    return Padding(
      padding: EdgeInsets.all(ResponsiveInfo.isMobile(context) ? 10 : 14),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: new TextSpan(
              style: new TextStyle(
                fontSize: ResponsiveInfo.isMobile(context) ? 12 : 16,
                color: Colors.black,
              ),
              children: <TextSpan>[
                new TextSpan(text: labelText),
                new TextSpan(text: ' * \n', style: new TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(ResponsiveInfo.isMobile(context) ? 10 : 15),
            width: double.infinity,
            height: ResponsiveInfo.isMobile(context) ? 55 : 65,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black54),
              borderRadius: BorderRadius.all(Radius.circular(ResponsiveInfo.isMobile(context) ? 10 : 15)),
            ),
            child: TextField(
              controller: controller,
              obscureText: isPassword,
              keyboardType: (ismobile)? TextInputType.phone : TextInputType.text ,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Enter $labelText',
                hintStyle: TextStyle(fontSize: ResponsiveInfo.isMobile(context) ? 12 : 14, color: Colors.black26),
              ),
              style: TextStyle(fontSize: ResponsiveInfo.isMobile(context) ? 12 : 14, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> saveUserDetails() async {
    String name = _nameController.text.trim();
    String email = _emailController.text.trim();
    String phone = _phoneController.text.trim();
    String password = _passwordController.text;

    if(name.isNotEmpty) {
      if(email.isNotEmpty) {
        if(phone.isNotEmpty) {

          if(password.isNotEmpty) {

            if(password.length>=8) {
      // Add user details to Firestore

            showLoaderDialog(context);

            final productSnapshot = await FirebaseFirestore.instance.collection('registration').get();

        List<dynamic>c=    productSnapshot.docs.toList();
            bool a=false;
        for(int i=0;i<c.length;i++)
          {

            QueryDocumentSnapshot ab=c[i];

            var m = ab.data() as Map<String,dynamic>;


            String  email1 = m['email'];
            if(email.compareTo(email1)==0)
            {
              a=true;

            }

          }




                if(!a)
                  {

                    p1=  await FirebaseFirestore.instance.collection('registration').add({
                      'name': name,
                      'email': email,
                      'phone': phone,
                      'password': password,
                      'timestamp': DateTime.now(),
                      'isverified': false,
                      'image':""
                    }).whenComplete(() {

                      Navigator.pop(context);

                      _nameController.clear();
                      _emailController.clear();
                      _phoneController.clear();
                      _passwordController.clear();

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Verification(p1.id)),
                      );

                    });
                  }
                else{
Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('This email ID is already registered'),
                    ),
                  );
                }















      // Clear text fields after saving
            }
            else{

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Your Password should contain atleast 8 characters'),
                ),
              );
            }




          }
          else{

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Enter password'),
              ),
            );
          }

        }
        else{

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Enter phone'),
            ),
          );
        }

      }
      else{

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Enter email'),
          ),
        );
      }



    }
    else{

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Enter name'),
        ),
      );
    }

  }


  showLoaderDialog(BuildContext context){
    AlertDialog alert=AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(margin: EdgeInsets.only(left: 7),child:Text("Loading..." ,style: TextStyle(fontSize: 12,color: Colors.black),)),
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
