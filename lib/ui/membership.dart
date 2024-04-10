import 'package:flutter/material.dart';
import 'package:ecommerce/designs/ResponsiveInfo.dart';
import 'package:ecommerce/ui/dashboard.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ecommerce/designs/ResponsiveInfo.dart';
import 'package:ecommerce/domain/CategoryData.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ecommerce/constants/Constants.dart';
import 'package:ecommerce/ui/payment_page.dart';
import 'package:ecommerce/ui/home.dart';

class Membership extends StatefulWidget {



   Membership() ;

  @override
  _MembershipState createState() => _MembershipState();
}

class _MembershipState extends State<Membership> {


List<String>arr=["Enterpreneur Membership","Distributor Membership","Investor Membership","Producer Membership"];
List<int>arrcolor=[0xff1f5796,0xff956e01,0xff5b918c,0xffb84060];

List<String>amounts=["10000","5000","3000","15000"];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xfff1f5f9),
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {

              Navigator.pop(context);

            }, icon: Icon(Icons.arrow_back)),
        elevation: 0,
        centerTitle: false,
        backgroundColor: Colors.white,
        title: Text(
          "Membership",
          style: TextStyle(
              color: Colors.black,
              fontSize:ResponsiveInfo.isMobile(context)? 15 :18,
              fontFamily: 'poppins',
              fontWeight: FontWeight.bold),
        ),

        actions: [

          TextButton(

            child:Text(
              "Skip",
              style: TextStyle(color: Colors.blue, fontSize: 15),
            ) ,
            onPressed: (){

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MyDashboardPage()),
              );


            },
          )
        ],

      ),

      body:  Stack(

        children: <Widget>[

          Padding(padding: EdgeInsets.all(ResponsiveInfo.isMobile(context)?10:14),

            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
    Padding(padding: EdgeInsets.all(4),
    child: Text( 'Choose membership plan', style: TextStyle(color: Colors.black, fontSize: ResponsiveInfo.isMobile(context)?20:25,fontWeight: FontWeight.bold),


    )),
    Padding(padding: EdgeInsets.all(4),
    child: Text( 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor', style: TextStyle(color: Colors.black54, fontSize: ResponsiveInfo.isMobile(context)?10:13,fontWeight: FontWeight.normal),


    ))
    ],
    )

          ),

          Padding(padding: EdgeInsets.fromLTRB( ResponsiveInfo.isMobile(context)?10:14,ResponsiveInfo.isMobile(context)?90:110,ResponsiveInfo.isMobile(context)?10:14,ResponsiveInfo.isMobile(context)?10:14),

              child: ListView.builder(
                  itemCount: arr.length,
                  shrinkWrap: true,
                  primary: false,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(

                      child:Container(
                        width: double.infinity,
                        height: ResponsiveInfo.isMobile(context)?175:215,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [

                                Padding(padding: EdgeInsets.all(ResponsiveInfo.isMobile(context)?8:12),
                                    child: Text( arr[index],
                                      style: TextStyle(color: Colors.white,
                                          fontSize: ResponsiveInfo.isMobile(context)?20:25,fontWeight: FontWeight.bold),


                                    )),

                                Padding(padding: EdgeInsets.all(ResponsiveInfo.isMobile(context)?8:12),
                                    child: Text( "choose "+arr[index]+" plan ",
                                      style: TextStyle(color: Colors.white,
                                          fontSize: ResponsiveInfo.isMobile(context)?12:14,fontWeight: FontWeight.normal),
                                      maxLines: 2,



                                    ))
                              ],
                            ),flex: 2,),

                            Expanded(child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(padding: EdgeInsets.all(ResponsiveInfo.isMobile(context)?8:12),
                                    child: Text( "Membership Fee \n "+amounts[index]+" Rs",
                                      style: TextStyle(color: Colors.white,
                                          fontSize: ResponsiveInfo.isMobile(context)?12:14,fontWeight: FontWeight.normal),
                                      maxLines: 2,



                                    )),

                                Padding(padding: EdgeInsets.all(ResponsiveInfo.isMobile(context)?8:12),
                                    child: GestureDetector(

                                    child:Container(
                                        padding:  EdgeInsets.all(ResponsiveInfo.isMobile(context)? 3 : 6),

                                        decoration: BoxDecoration(

                                            border: Border.all(color: Colors.white),
                                            borderRadius: BorderRadius.all(Radius.circular(ResponsiveInfo.isMobile(context)? 10 : 15))

                                        ),


                                        child:  Text( "Choose   > ",
                                          style: TextStyle(color: Colors.white,
                                              fontSize: ResponsiveInfo.isMobile(context)?12:14,fontWeight: FontWeight.normal),
                                          maxLines: 2,



                                        )),
                                      onTap: ()async{

                                        final preferenceDataStorage = await SharedPreferences
                                            .getInstance();
                                      String? id=  preferenceDataStorage.getString(Constants.pref_userid);
                                        // preferenceDataStorage.setString(Constants.pref_usertype, Constants.normal_usertype);

                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => PaymentPage(amounts[index], arr[index],id.toString()),
                                          ),
                                        );



                                      },
                                    )




                                )

                              ],
                            ),flex: 1,)


                            
                          ],
                        ),

                      )


                      ,
                      elevation: 10,
                      color: Color(arrcolor[index]),
                    )


                      ;
                  })

          ),

        ],
      ),


    );
  }




}
