import 'package:flutter/material.dart';
import 'package:ecommerce/designs/ResponsiveInfo.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ecommerce/designs/ResponsiveInfo.dart';
import 'package:ecommerce/domain/CategoryData.dart';
import 'dart:io';
import 'package:ecommerce/ui/home.dart';
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ecommerce/constants/Constants.dart';
import 'package:ecommerce/ui/login.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
   Profile() ;

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  String name="";
  String email="";
  String image="";


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserDetails();
  }

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {

       var _image = File(pickedFile.path);

       // final ref = FirebaseStorage.instance.ref()
       //     .child('product_images')
       //     .child('${DateTime.now()}.jpg');
       // await ref.putFile(_image!);
       // final imageUrl = await ref.getDownloadURL();

       final ref = FirebaseStorage.instance.ref()
           .child('profile_images')
           .child('${DateTime.now()}.jpg');
       await ref.putFile(_image!);
       final imageUrl = await ref.getDownloadURL();

       final preferenceDataStorage = await SharedPreferences
           .getInstance();
       String? id=  preferenceDataStorage.getString(Constants.pref_userid);

       showLoaderDialog(context);

       await FirebaseFirestore.instance.collection('registration').doc(id).update({'image':imageUrl}).then((value) {

         Navigator.pop(context);

         getUserDetails();

       });


    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff1f5f9),
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {

              Navigator.pop(context);

            }, icon: Icon(Icons.arrow_back,color: Colors.black,)),
        elevation: 0,
        centerTitle: false,
        backgroundColor: Colors.white,
        title: Text(
          "Profile",
          style: TextStyle(
              color: Colors.black,
              fontSize:ResponsiveInfo.isMobile(context)? 15 :18,
              fontFamily: 'poppins',
              fontWeight: FontWeight.bold),
        ),


      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Expanded(child: Stack(

          children: [

            Align(
          alignment: FractionalOffset.topCenter,
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,

          children: [

            Padding(padding:  EdgeInsets.all(ResponsiveInfo.isMobile(context)?12:14),


                child: (image.isNotEmpty)?


                CircleAvatar(
                  radius: 55.0,
                  backgroundImage:
                  NetworkImage(image),
                  backgroundColor: Colors.transparent,
                ) : Container(

                  child: Icon(Icons.account_circle,color: Colors.black54,size: 110,),


                )             ),

            Padding(padding:  EdgeInsets.all(ResponsiveInfo.isMobile(context)?8:12),

                child:  Text( name, style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,
                    fontSize: ResponsiveInfo.isMobile(context)?16:19))

            ),

            Padding(padding:  EdgeInsets.all(ResponsiveInfo.isMobile(context)?8:12),

                child:  Text( email, style: TextStyle(color: Colors.black54,fontWeight: FontWeight.normal,
                    fontSize: ResponsiveInfo.isMobile(context)?14:17))

            ),

            Padding(padding: EdgeInsets.all(ResponsiveInfo.isMobile(context)?8:12),
                child: GestureDetector(
                  child: Container(
                    width: ResponsiveInfo.isMobile(context)? 120 : 150,
                      padding:  EdgeInsets.all(ResponsiveInfo.isMobile(context)? 6 : 9),

                      decoration: BoxDecoration(
                          color: Color(0xff2453a4),

                          border: Border.all(color: Color(0xff2453a4)),
                          borderRadius: BorderRadius.all(Radius.circular(ResponsiveInfo.isMobile(context)? 10 : 15))

                      ),


                      child: Stack(
    children: [
      Align(
    alignment: FractionalOffset.center,
    child:  Text( "Edit Profile",
      style: TextStyle(color: Colors.white,
          fontSize: ResponsiveInfo.isMobile(context)?12:14,fontWeight: FontWeight.normal),




    ) ,
    )

    ],

    )



                  ),
                  onTap: (){
                    Widget okButton = TextButton(
                      child: Text("yes"),
                      onPressed: ()async {

                        Navigator.pop(context);
                        _getImage();


                      },
                    );

                    Widget okButton1 = TextButton(
                      child: Text("no"),
                      onPressed: () {

                        Navigator.pop(context);


                      },
                    );

                    // set up the AlertDialog
                    AlertDialog alert = AlertDialog(
                      title: Text("Profile"),
                      content: Text("Do you want to change profile image now ?"),
                      actions: [
                        okButton,
                        okButton1
                      ],
                    );

                    // show the dialog
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return alert;
                      },
                    );





                  },

                )



            )



          ],

        ) ,
      )
        ],
      )



          ,


            flex: 1,),


          Expanded(child: SingleChildScrollView(

    child: Column(

      children: [

        Padding(padding: EdgeInsets.all(ResponsiveInfo.isMobile(context)?8:12),

        child: Container(
          height:ResponsiveInfo.isMobile(context)? 60 : 75,
          decoration: BoxDecoration(
              color: Color(0xffffffff),
              border: Border.all(color: Color(0xffffffff)),
              borderRadius: BorderRadius.all(Radius.circular(ResponsiveInfo.isMobile(context)? 10 : 15))

          ),
          child: ListTile(
              leading:  Icon(Icons.settings,color: Colors.black,size: ResponsiveInfo.isMobile(context)?20:25),
              trailing: Icon(Icons.arrow_forward_ios_rounded,color: Colors.black,size: ResponsiveInfo.isMobile(context)?20:25,) ,
              title: Text("Settings",style: TextStyle(fontSize:ResponsiveInfo.isMobile(context)?13:17,color: Colors.black ),)),


        ),

        ),

        Padding(padding: EdgeInsets.all(ResponsiveInfo.isMobile(context)?8:12),

          child: Container(
            height:ResponsiveInfo.isMobile(context)? 60 : 75,
            decoration: BoxDecoration(
                color: Color(0xffffffff),
                border: Border.all(color: Color(0xffffffff)),
                borderRadius: BorderRadius.all(Radius.circular(ResponsiveInfo.isMobile(context)? 10 : 15))

            ),
            child: ListTile(
                leading:  Icon(Icons.perm_identity_sharp,color: Colors.black,size: ResponsiveInfo.isMobile(context)?20:25),
                trailing: Icon(Icons.arrow_forward_ios_rounded,color: Colors.black,size: ResponsiveInfo.isMobile(context)?20:25,) ,
                title: Text("Subscription details",style: TextStyle(fontSize:ResponsiveInfo.isMobile(context)?13:17,color: Colors.black ),)),


          ),

        ),

        Padding(padding: EdgeInsets.all(ResponsiveInfo.isMobile(context)?8:12),

          child: Container(
            height:ResponsiveInfo.isMobile(context)? 60 : 75,
            decoration: BoxDecoration(
                color: Color(0xffffffff),
                border: Border.all(color: Color(0xffffffff)),
                borderRadius: BorderRadius.all(Radius.circular(ResponsiveInfo.isMobile(context)? 10 : 15))

            ),
            child: ListTile(
                leading:  Icon(Icons.info_outline,color: Colors.black,size: ResponsiveInfo.isMobile(context)?20:25),
                trailing: Icon(Icons.arrow_forward_ios_rounded,color: Colors.black,size: ResponsiveInfo.isMobile(context)?20:25,) ,
                title: Text("FAQ",style: TextStyle(fontSize:ResponsiveInfo.isMobile(context)?13:17,color: Colors.black ),)),


          ),

        ),

        Padding(padding: EdgeInsets.all(ResponsiveInfo.isMobile(context)?8:12),

          child: GestureDetector(

    child: Container(
            height:ResponsiveInfo.isMobile(context)? 60 : 75,
            decoration: BoxDecoration(
                color: Color(0xffffffff),
                border: Border.all(color: Color(0xffffffff)),
                borderRadius: BorderRadius.all(Radius.circular(ResponsiveInfo.isMobile(context)? 10 : 15))

            ),
            child: ListTile(
                leading:  Icon(Icons.exit_to_app,color: Colors.black,size: ResponsiveInfo.isMobile(context)?20:25),
                trailing: Icon(Icons.arrow_forward_ios_rounded,color: Colors.black,size: ResponsiveInfo.isMobile(context)?20:25,) ,
                title: Text("Logout",style: TextStyle(fontSize:ResponsiveInfo.isMobile(context)?13:17,color: Colors.black ),)),


          ),
          onTap: (){

            Widget okButton = TextButton(
              child: Text("yes"),
              onPressed: ()async {

                final preferenceDataStorage = await SharedPreferences
                    .getInstance();
                preferenceDataStorage.setString(Constants.pref_userid, "");
                preferenceDataStorage.setString(Constants.pref_usertype, "");

                Navigator.pop(context);


                Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));



              },
            );

            Widget okButton1 = TextButton(
              child: Text("no"),
              onPressed: () {

                Navigator.pop(context);

              },
            );

            // set up the AlertDialog
            AlertDialog alert = AlertDialog(
              title: Text("Logout"),
              content: Text("Do you want to logout now ?"),
              actions: [
                okButton,
                okButton1
              ],
            );

            // show the dialog
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return alert;
              },
            );


          },
          )

        ),


        Padding(padding: EdgeInsets.all(ResponsiveInfo.isMobile(context)?8:12),

          child: GestureDetector(

    child:     Container(
      height:ResponsiveInfo.isMobile(context)? 60 : 75,
      decoration: BoxDecoration(
          color: Color(0xffffffff),
          border: Border.all(color: Color(0xffffffff)),
          borderRadius: BorderRadius.all(Radius.circular(ResponsiveInfo.isMobile(context)? 10 : 15))

      ),
      child: ListTile(
          leading:  Icon(Icons.delete,color: Colors.black,size: ResponsiveInfo.isMobile(context)?20:25),
          trailing: Icon(Icons.arrow_forward_ios_rounded,color: Colors.black,size: ResponsiveInfo.isMobile(context)?20:25,) ,
          title: Text("Delete Account",style: TextStyle(fontSize:ResponsiveInfo.isMobile(context)?13:17,color: Colors.black ),)),


    ),
            onTap: (){

              Widget okButton = TextButton(
                child: Text("yes"),
                onPressed: ()async {
                  showLoaderDialog(context);

                  final preferenceDataStorage = await SharedPreferences
                      .getInstance();

                  String? id = preferenceDataStorage.getString(Constants.pref_userid);
                  await FirebaseFirestore.instance.collection('registration').doc(id.toString()).delete().then((value) {

                    Navigator.pop(context);
                    preferenceDataStorage.setString(Constants.pref_userid, "");
                    preferenceDataStorage.setString(Constants.pref_usertype, "");

                    Navigator.pop(context);


                    Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));

                  });





                },
              );

              Widget okButton1 = TextButton(
                child: Text("no"),
                onPressed: () {

                  Navigator.pop(context);

                },
              );

              // set up the AlertDialog
              AlertDialog alert = AlertDialog(
                title: Text("Delete Account"),
                content: Text("Do you want to Delete your account now ?"),
                actions: [
                  okButton,
                  okButton1
                ],
              );

              // show the dialog
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return alert;
                },
              );



            },
    )




        )







      ],

    ),
    )


          ,flex: 1,)



        ],

      ),





    );
  }


  getUserDetails()async{

    final preferenceDataStorage = await SharedPreferences
        .getInstance();
    String? id=  preferenceDataStorage.getString(Constants.pref_userid);

    await FirebaseFirestore.instance.collection('registration').doc(id).get().then((value) {


      Map<String,dynamic> m= value.data()!;

      setState(() {




        name=m['name'];
        email=m['email'];
        image=m['image'];




      });





    });



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
