import 'package:flutter/material.dart';
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

class PaymentPage extends StatefulWidget {

  String paymentamount;
  String membershiptype;
  String id;

   PaymentPage(this.paymentamount,this.membershiptype,this.id) ;

  @override
  _PaymentPageState createState() => _PaymentPageState(this.paymentamount,this.membershiptype,this.id);
}

class _PaymentPageState extends State<PaymentPage> {


  String paymentamount;
  String membershiptype;
  String id;
  _PaymentPageState(this.paymentamount,this.membershiptype,this.id);





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
          "Payment",
          style: TextStyle(
              color: Colors.black,
              fontSize:ResponsiveInfo.isMobile(context)? 15 :18,
              fontFamily: 'poppins',
              fontWeight: FontWeight.bold),
        ),



      ),

      body: Column(

    children: [

    Padding(

    child:Container(

    decoration: BoxDecoration(
    color: Color(0xfffefefe),
    border: Border.all(color: Color(0xfffefefe)),
    borderRadius: BorderRadius.all(Radius.circular(ResponsiveInfo.isMobile(context)? 10 : 15))

    ),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.center,

    children: [

      Padding(padding:  EdgeInsets.all(ResponsiveInfo.isMobile(context)?12:14),


          child:Text( 'Scan this QR code in your UPI app.and pay the amount', style: TextStyle(color: Colors.black, fontSize: ResponsiveInfo.isMobile(context)?12:14)

          )),

    Padding(padding:  EdgeInsets.all(ResponsiveInfo.isMobile(context)?12:14),


    child: Image.asset("assets/images/upiqr.png",
    width:ResponsiveInfo.isMobile(context)?150:180,height:ResponsiveInfo.isMobile(context)?150:180 ,fit: BoxFit.fill,)
    ),
      Padding(padding:  EdgeInsets.all(ResponsiveInfo.isMobile(context)?12:14),


          child:Text( 'Amount : '+paymentamount, style: TextStyle(color: Colors.black, fontSize: ResponsiveInfo.isMobile(context)?12:14)

          )),
      Padding(padding:  EdgeInsets.all(ResponsiveInfo.isMobile(context)?12:14),


          child:Text( 'Membership Type : '+membershiptype, style: TextStyle(color: Colors.black, fontSize: ResponsiveInfo.isMobile(context)?12:14)

          )),

      Padding(
        padding: EdgeInsets.all(ResponsiveInfo.isMobile(context) ? 10 : 15),
        child: Container(
          width: double.infinity,
          height: ResponsiveInfo.isMobile(context) ? 50 : 65,
          decoration: BoxDecoration(
            color: Color(0xff255eab),
            border: Border.all(color: Color(0xff255eab)),
            borderRadius: BorderRadius.all(Radius.circular(ResponsiveInfo.isMobile(context) ? 10 : 15)),
          ),
          child: TextButton(
            child: Text(
              'Payment completed',
              style: TextStyle(color: Colors.white, fontSize: ResponsiveInfo.isMobile(context) ? 12 : 14),
            ),
            onPressed: () async {

              if(membershiptype.compareTo("Wallet Amount")==0)
                {

                  showLoaderDialog(context);

                  DateTime dtnow = new DateTime.now();
                  String stdate = dtnow.day.toString() + "-" +
                      dtnow.month.toString() + "-" + dtnow.year.toString()+" "+dtnow.hour.toString()+":"+dtnow.minute.toString();
                  await FirebaseFirestore.instance.collection('wallet_balance').add({'amount': paymentamount,
                    'date': stdate,
                    'type': "invest",
                    'user_id': id}).whenComplete(() {

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Amount added to wallet successfully'),
                      ),
                    );

                    Navigator.pop(context);


                  });


                }
              else {
                DateTime dtnow = new DateTime.now();
                String stdate = dtnow.day.toString() + "-" +
                    dtnow.month.toString() + "-" + dtnow.year.toString();

                String enddate = dtnow.day.toString() + "-" +
                    (dtnow.month + 1).toString() + "-" + dtnow.year.toString();

                Random random = new Random();
                int randomNumber = random.nextInt(1000000);

                String alotno = random.nextInt(900).toString() + "/" +
                    random.nextInt(100).toString() + "/" +
                    random.nextInt(500).toString();

                showLoaderDialog(context);

                await FirebaseFirestore.instance.collection('registration').doc(
                    id).update({'isverified': true,
                  'membertype': membershiptype,
                  'amount': paymentamount,
                  'startDate': stdate,
                  'membershipno': randomNumber.toString(),
                  'allotment_type': alotno,
                  'endDate': enddate}).whenComplete(() {
                  Navigator.pop(context);

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => MyDashboardPage()),
                  );
                });
              }




            },
          ),
        ),
      )







    ],
    ),


    ) ,
    padding: EdgeInsets.all(ResponsiveInfo.isMobile(context)?8:12),
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
