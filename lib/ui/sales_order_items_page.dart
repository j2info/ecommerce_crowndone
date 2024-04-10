import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ecommerce/designs/ResponsiveInfo.dart';
import 'package:ecommerce/domain/CategoryData.dart';
import 'dart:io';
import 'package:ecommerce/domain/ProductVariants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ecommerce/constants/Constants.dart';
import 'package:badges/badges.dart' as badge;
import 'package:ecommerce/domain/CartData.dart';
import 'package:ecommerce/domain/Address.dart';
import 'package:ecommerce/ui/address_list.dart';
import 'package:ecommerce/ui/home.dart';
import 'package:ecommerce/domain/SalesOrderData.dart';
import 'package:ecommerce/domain/SalesOrderItems.dart';
import 'package:ecommerce/ui/qr/qrcode_data.dart';

class SalesOrderItemsPage extends StatefulWidget {
  String addressid;
  String orderid;



   SalesOrderItemsPage(this.addressid,this.orderid) ;

  @override
  _SalesOrderItemsPageState createState() => _SalesOrderItemsPageState(this.addressid,this.orderid);
}

class _SalesOrderItemsPageState extends State<SalesOrderItemsPage> {

  String addressid;
  String orderid;

  double totalamount=0;

  List<SalesOrderItems>cartdata=[];

  String address="";


  TextEditingController amountcontroller = TextEditingController();

  _SalesOrderItemsPageState(this.addressid,this.orderid);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getCartCount();
    getAddressList();

  }


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
          "Ordered Items",
          style: TextStyle(
              color: Colors.black,
              fontSize:ResponsiveInfo.isMobile(context)? 15 :18,
              fontFamily: 'poppins',
              fontWeight: FontWeight.bold),
        ),

        actions: [

          Padding(padding: EdgeInsets.all(ResponsiveInfo.isMobile(context)?10:15),

          child: GestureDetector(


            onTap: ()async{



              Map results =
                  await Navigator.of(context).push(new MaterialPageRoute<dynamic>(
                builder: (BuildContext context) {
                  return new QRViewExample();
                },
              ));

              if (results != null && results.containsKey('added')) {
                var acc_selected = results['added'].toString();









              }


            },
            child: Icon(Icons.barcode_reader, color: Colors.black54,size: ResponsiveInfo.isMobile(context)?25:35),
          ),


          )

        ],



      ),

      body: Stack(

        children: [


          Align(
            child:
            Container(
                width: double.infinity,
                height: ResponsiveInfo.isMobile(context)?100:130 ,
                color: Color(0xffe8e8e8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [

                    Padding(padding: EdgeInsets.all(7),
                      child:    Text( "Address" ,style: TextStyle(fontSize:ResponsiveInfo.isMobile(context)? 13 : 15,color: Colors.black ),),
                    ),

                    Padding(padding: EdgeInsets.all(8),
                      child:
                      Text( address ,style: TextStyle(fontSize:ResponsiveInfo.isMobile(context)? 13 : 15,color: Colors.black ),)
                      ,



                    )
                  ],
                )





            ),
            alignment: FractionalOffset.topCenter,
          ),

          (cartdata.length>0)?  Align(
            child:  Padding(
                padding: EdgeInsets.only(left: 0,right: 0,bottom:ResponsiveInfo.isMobile(context)?75:100,top: ResponsiveInfo.isMobile(context)?110:140 ),
                child: ListView.builder(
                    itemCount: cartdata.length,
                    itemBuilder: (BuildContext context, int i) {
                      return Container(
                        width: double.infinity,
                        height:ResponsiveInfo.isMobile(context)?150:180 ,

                        child: Card(
                            elevation: 8,
                            child:Row(

                              children: [

                                Expanded(child:(cartdata[i].image.isNotEmpty)?
                                Padding(padding: EdgeInsets.all(10),

                                  child: Image.network(cartdata[i].image,),
                                )

                                    : Container(),flex: 1,),

                                Expanded(child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,

                                  children: [
                                    (cartdata[i].name.isNotEmpty && cartdata[i].unitname.isNotEmpty)? Text(cartdata[i].name+" "+cartdata[i].unitname ,style: TextStyle(fontSize:ResponsiveInfo.isMobile(context)? 13 : 15,color: Colors.black ),) :

                                    Text("" ,style: TextStyle(fontSize:ResponsiveInfo.isMobile(context)? 13 : 15,color: Colors.black ),),

                                    (cartdata[i].unitprice.isNotEmpty)? Text("Unit Price : "+  cartdata[i].unitprice ,style: TextStyle(fontSize:ResponsiveInfo.isMobile(context)? 13 : 15,color: Colors.black ),) :
                                    Text("" ,style: TextStyle(fontSize:ResponsiveInfo.isMobile(context)? 13 : 15,color: Colors.black ),),

                                    Text(
                                     "\n Quantity : "+cartdata[i].qty,
                                      style: TextStyle(fontSize: ResponsiveInfo.isMobile(context)? 13 : 15),
                                    ),









                                  ],
                                )






                                )


                              ],
                            )





                        ),
                      );
                    })

            ),
            alignment: FractionalOffset.topCenter,
          ) : Align(
            alignment: FractionalOffset.center,
            child: Padding(padding: EdgeInsets.all(5),
              child:     Text( "No data found" ,style: TextStyle(fontSize:ResponsiveInfo.isMobile(context)? 13 : 15,color: Colors.black ),),



            ) ,
          ),

          Align(
            child:
            (cartdata.length>0)? Container(
              width: double.infinity,
              height: ResponsiveInfo.isMobile(context)?70:90 ,
              color: Color(0xffe8e8e8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Padding(padding: EdgeInsets.all(5),
                    child:     Text( "Total Amount : "+ totalamount.toString() ,style: TextStyle(fontSize:ResponsiveInfo.isMobile(context)? 13 : 15,color: Colors.black ),),



                  ),

                  Padding(padding: EdgeInsets.all(5),
                      child: TextButton(

                        child: Text( "Pay now" ,style: TextStyle(fontSize:ResponsiveInfo.isMobile(context)? 13 : 15,color: Colors.blue ),),
                        onPressed: (){

                          AlertDialog alert = AlertDialog(
                            title:Container(),
                            content:  Container(
                              width: double.infinity,
                              height: ResponsiveInfo.isMobile(context)?200 : 300,
                              child: SingleChildScrollView(

                                child: Column(

                                  children: [

                                    Padding(
                                        padding: EdgeInsets.all(ResponsiveInfo.isMobile(context) ? 10 : 15),
                                        child:Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                                padding: EdgeInsets.all(ResponsiveInfo.isMobile(context) ? 10 : 15),
                                                child: TextButton(

                                                  child: Text( 'Pay Online', style: TextStyle(color: Colors.blue, fontSize: ResponsiveInfo.isMobile(context)?12:14)

                                                  ),
                                                  onPressed: (){
                                                    Navigator.pop(context);

                                                    showOnlinePayment();
                                                  },
                                                )


                                            ),

                                            Padding(
                                                padding: EdgeInsets.all(ResponsiveInfo.isMobile(context) ? 10 : 15),
                                                child: TextButton(

                                                  child: Text( '>', style: TextStyle(color: Colors.blue, fontSize: ResponsiveInfo.isMobile(context)?12:14)

                                                  ),
                                                  onPressed: (){
                                                    Navigator.pop(context);
                                                    showOnlinePayment();
                                                  },
                                                )


                                            ),




                                        ],)


                                    ),

                                    Padding(
                                        padding: EdgeInsets.all(ResponsiveInfo.isMobile(context) ? 10 : 15),
                                        child:Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                                padding: EdgeInsets.all(ResponsiveInfo.isMobile(context) ? 10 : 15),
                                                child: TextButton(

                                                  child: Text( 'Cash On Delivery', style: TextStyle(color: Colors.blue, fontSize: ResponsiveInfo.isMobile(context)?12:14)

                                                  ),
                                                  onPressed: (){

                                                    showCashOnDeliveryPage();
                                                  },
                                                )


                                            ),

                                            Padding(
                                                padding: EdgeInsets.all(ResponsiveInfo.isMobile(context) ? 10 : 15),
                                                child: TextButton(

                                                  child: Text( '>', style: TextStyle(color: Colors.blue, fontSize: ResponsiveInfo.isMobile(context)?12:14)

                                                  ),
                                                  onPressed: (){

                                                    showCashOnDeliveryPage();
                                                  },
                                                )


                                            ),




                                          ],)


                                    ),


                                  ],
                                ),
                              ),

                            ),





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

            ) : Container(),
            alignment: FractionalOffset.bottomCenter,
          )

        ],
      ),



    );
  }


  showCashOnDeliveryPage()async
  {
    AlertDialog alert = AlertDialog(
      title:Container(),
      content:  Container(
        width: double.infinity,
        height: ResponsiveInfo.isMobile(context)?280:380,
        child: SingleChildScrollView(

          child: Column(

            children: [

              Padding(
                padding: EdgeInsets.all(ResponsiveInfo.isMobile(context) ? 10 : 15),
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter Amount',
                    hintText: 'Enter Amount',
                  ),
                  controller: amountcontroller,
                ),
              ),

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
                      'Confirm',
                      style: TextStyle(color: Colors.white, fontSize: ResponsiveInfo.isMobile(context) ? 12 : 14),
                    ),
                    onPressed: () async {
                      // Call a function to authenticate user

                      if(amountcontroller.text.isNotEmpty) {

                        if(amountcontroller.text.compareTo(totalamount.toString())==0) {
                          Navigator.pop(context);
                          showLoaderDialog(context);
                          final productRef = FirebaseFirestore.instance
                              .collection(
                              'sales_order').doc(orderid);
                          await productRef.set({
                            'order_status': 'Success',
                            'payment_status': 'Success',
                            'payment_type':'cash on delivery'
                          }).then((value) {
                            Navigator.pop(context);
                          });
                        }
                        else{

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Enter the correct amount'),
                            ),
                          );

                        }
                      }
                      else{
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Enter the correct amount'),
                          ),
                        );


                      }



                    },
                  ),
                ),
              ),

            ],
          ),
        ),

      ),





    );

// show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }


  showOnlinePayment()async
  {
    AlertDialog alert = AlertDialog(
      title:Container(),
      content:  Container(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(

          child: Column(

            children: [

              Padding(
                  padding: EdgeInsets.all(ResponsiveInfo.isMobile(context) ? 10 : 15),
                  child: Text( 'Scan this QR code in your UPI app.and pay the amount', style: TextStyle(color: Colors.black, fontSize: ResponsiveInfo.isMobile(context)?12:14)

                  )
              ),
              Padding(
                  padding: EdgeInsets.all(ResponsiveInfo.isMobile(context) ? 10 : 15),
                  child: Image.asset("assets/images/upiqr.png",
                    width:ResponsiveInfo.isMobile(context)?150:180,height:ResponsiveInfo.isMobile(context)?150:180 ,fit: BoxFit.fill,)
              ),
              Padding(
                  padding: EdgeInsets.all(ResponsiveInfo.isMobile(context) ? 10 : 15),
                  child: Text( 'Amount to pay : '+totalamount.toString(), style: TextStyle(color: Colors.black, fontSize: ResponsiveInfo.isMobile(context)?12:14)

                  )
              ),

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
                      'Payment Completed',
                      style: TextStyle(color: Colors.white, fontSize: ResponsiveInfo.isMobile(context) ? 12 : 14),
                    ),
                    onPressed: () async {
                      // Call a function to authenticate user


                      Navigator.pop(context);
                      showLoaderDialog(context);
                      final productRef = FirebaseFirestore.instance.collection(
                          'sales_order').doc(orderid);
                      await productRef.set({
                        'order_status':'Success',
                        'payment_status':'Success',
                        'payment_type':'online'
                      }).then((value) {
                        Navigator.pop(context);


                      });





                    },
                  ),
                ),
              ),

            ],
          ),
        ),

      ),





    );

// show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
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
  getCartCount()async{

    final preferenceDataStorage = await SharedPreferences
        .getInstance();
    String? uid=  preferenceDataStorage.getString(Constants.pref_userid);

    final productSnapshot = await FirebaseFirestore.instance.collection('sales_orders').get();


    List<dynamic>c=    productSnapshot.docs.toList();

    cartdata.clear();

    for(int i=0;i<c.length;i++) {
      QueryDocumentSnapshot ab = c[i];

      var m = ab.data() as Map<String, dynamic>;
      String userid=m['user_id'];
      String product_id=m['product_id'];
      String productmaster_id=m['product_master_id'];
      String qty=m['qty'];
      String order_id=m['order_id'];
      String cartid=ab.id;

      if(order_id.trim().compareTo(orderid)==0)
      {

        SalesOrderItems c1=    SalesOrderItems(cartid, userid.trim(), qty, "", "", "", "",product_id,productmaster_id,order_id);
        setState(() {
          cartdata.add(c1);

        });

      }


    }


    for(int j=0;j<cartdata.length;j++)
    {

      String product_id=cartdata[j].product_id;
      String productmaster_id=cartdata[j].productmaster_id;

      FirebaseFirestore.instance.collection('products').doc(product_id).get().then((value) {
        var m1=value.data()!;
        String unitprice=m1['Amount'];
        String units=m1['units'];

        for(int k=0;k<cartdata.length;k++) {
          if (productmaster_id.compareTo(cartdata[k].productmaster_id) ==
              0) {

            setState(() {
              cartdata[k].unitprice=unitprice;
            });

            calculateTotal();
          }
        }

        FirebaseFirestore.instance.collection('units').doc(units.trim()).get().then((value1) {
          var m3=value1.data()!;
          String unitname=m3['name'];

          for(int k=0;k<cartdata.length;k++) {
            if (productmaster_id.compareTo(cartdata[k].productmaster_id) ==
                0) {

              setState(() {
                cartdata[k].unitname=unitname;
              });

              calculateTotal();
            }
          }

          FirebaseFirestore.instance.collection('product_master').doc(productmaster_id).get().then((value2) {
            var m2=value2.data()!;
            String name=m2['name'];
            String image=m2['image'];

            for(int k=0;k<cartdata.length;k++) {
              if (productmaster_id.compareTo(cartdata[k].productmaster_id) ==
                  0) {

                setState(() {
                  cartdata[k].name=name;
                  cartdata[k].image=image;

                });

                calculateTotal();
              }
            }



          });

        });




      });
    }




  }



  getAddressList()async
  {
    final preferenceDataStorage = await SharedPreferences
        .getInstance();
    String? uid=  preferenceDataStorage.getString(Constants.pref_userid);

    final productSnapshot = await FirebaseFirestore.instance.collection('addresslist').doc(addressid).get().then((value) {

      Map<String, dynamic> m=    value.data()!;

      String userid=m['userid'];
      String address1=m['address'];

      setState(() {

address=address1;


      });

    });







  }




  calculateTotal()
  {

    double t=0;

    for(int k=0;k<cartdata.length;k++) {

      int q=0;

      if(cartdata[k].qty.isNotEmpty)
      {
        q=int.parse(cartdata[k].qty);

        if(cartdata[k].unitprice.isNotEmpty)
        {

          double p=double.parse(cartdata[k].unitprice);
          t=t+(p*q);


        }

      }

    }

    setState(() {

      totalamount=t;
    });

  }
}
