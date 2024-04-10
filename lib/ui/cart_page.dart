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

class CartPage extends StatefulWidget {
   CartPage();

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {


  List<CartData>cartdata=[];
  double totalamount=0;
  List<Address>adr=[];

int selectedindex=0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getCartCount();
    getAddressList();

  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
      // You can do some work here.
      // Returning true allows the pop to happen, returning false prevents it.
      return true;
    },
    child:


      Scaffold(
backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,

        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            }
        ),
        title: Text("My Cart",style: TextStyle(color: Colors.black,fontSize: 15),),
        centerTitle: false,




      ),

      body: Padding(padding: EdgeInsets.all(ResponsiveInfo.isMobile(context)?5:7 ),

      child: Stack(

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

                  Padding(padding: EdgeInsets.all(6),
                  child:    Text( "Address" ,style: TextStyle(fontSize:ResponsiveInfo.isMobile(context)? 13 : 15,color: Colors.black ),),
                  ),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center
                    ,

                    children: [
                      Expanded(child: Padding(padding: EdgeInsets.all(5),
                        child: (adr.length>0)?Text( adr[selectedindex].addressdata ,style: TextStyle(fontSize:ResponsiveInfo.isMobile(context)? 13 : 15,color: Colors.black ),maxLines: 2,) :
                        Text( "No Address Found" ,style: TextStyle(fontSize:ResponsiveInfo.isMobile(context)? 13 : 15,color: Colors.black ),)
                        ,



                      ),flex: 2,)
                      ,

                      Expanded(child:  Padding(padding: EdgeInsets.all(5),
                          child: TextButton(

                            child: Text( (adr.length>0)?"Change" : "Add" ,style: TextStyle(fontSize:ResponsiveInfo.isMobile(context)? 13 : 15,color: Colors.blue ),),
                            onPressed: ()async{

                              Map results =
                              await Navigator.of(context).push(new MaterialPageRoute<dynamic>(
                                builder: (BuildContext context) {
                                  return new AddressList();
                                },
                              ));

                              if (results != null && results.containsKey('added')) {
                                var acc_selected = results['added'];

                                int code = acc_selected as int;
                                if (code !=-1) {

                                  setState(() {
                                    // is_studentclicked = false;
                                    // isstaffclicked = false;
                                    // isvisitorclicked = false;
                                    selectedindex=code;

                                    getAddressList();
                                  });
                                }
                              }

                            },
                          )

                      ),flex: 1,)





                    ],
                  ),
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

                                Card(
                                  elevation: 5.0,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: <Widget>[

                                        GestureDetector(

                                          child: Icon(Icons.remove, color: Colors.black87,size:ResponsiveInfo.isMobile(context)? 20 : 25 ,),

                                    onTap: ()async{
                                            
                                            String qty=cartdata[i].qty;
                                            int p=int.parse(qty);
                                            
                                            if(p>1)
                                              {
                                                p=p-1;
                                                setState(() {
                                                  cartdata[i].qty=p.toString();
                                                });

                                                showLoaderDialog(context);

                                                FirebaseFirestore.instance.collection('cart').doc(cartdata[i].id).update({"qty":p.toString()}).then((value) {
                                                  Navigator.pop(context);
                                                  calculateTotal();
                                                });
                                              
                                              }


                                    },
                                        ),
                                        Text(
                                          cartdata[i].qty,
                                          style: TextStyle(fontSize: ResponsiveInfo.isMobile(context)? 13 : 15),
                                        ),
                                        GestureDetector(
                                          child: Icon(Icons.add, color: Colors.black87,size: ResponsiveInfo.isMobile(context)? 20 : 25,),

                                          onTap: ()async{

                                            String qty=cartdata[i].qty;
                                            int p=int.parse(qty);

                                              p=p+1;
                                              setState(() {
                                                cartdata[i].qty=p.toString();
                                              });

                                              showLoaderDialog(context);

                                            FirebaseFirestore.instance.collection('cart').doc(cartdata[i].id).update({"qty":p.toString()}).then((value) {
                                              Navigator.pop(context);
                                              calculateTotal();
                                            });

                                            
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                Stack(

                                  children: [

                                    Align(
                                      alignment: FractionalOffset.topRight,
                                      child: TextButton(
                                        onPressed: ()async{


                                          Widget okButton = TextButton(
                                            child: Text("yes"),
                                            onPressed: ()async {

                                              showLoaderDialog(context);
                                              FirebaseFirestore.instance.collection('cart').doc(cartdata[i].id).delete().then((value) {

                                                setState(() {
                                                  cartdata.removeAt(i);

                                                });
                                                calculateTotal();
                                                Navigator.pop(context);
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
                                            title: Text(""),
                                            content: Text("Do you want to delete this product from cart ?"),
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

                                        child:  Text("Delete" ,style: TextStyle(fontSize:ResponsiveInfo.isMobile(context)? 13 : 15,color: Colors.black ),),
                                      ),
                                    )


                                  ],
                                )







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

                      child: Text( "Confirm Order" ,style: TextStyle(fontSize:ResponsiveInfo.isMobile(context)? 13 : 15,color: Colors.blue ),),
                      onPressed: (){

                        Widget okButton = TextButton(
                          child: Text("yes"),
                          onPressed: ()async {

                            Navigator.pop(context);

                            final preferenceDataStorage = await SharedPreferences
                                .getInstance();
                            String? uid=  preferenceDataStorage.getString(Constants.pref_userid);
                            showLoaderDialog(context);

                            DateTime dt=new DateTime.now();

                            final productRef = FirebaseFirestore.instance.collection(
                                'sales_order').doc();
                            await productRef.set({
                              'address_id': adr[selectedindex].id,
                              'userid': uid.toString(),
                              'date':dt.day.toString()+"-"+dt.month.toString()+"-"+dt.year.toString(),
                              'total_amount':totalamount.toString(),
                              'order_status':'pending',
                              'payment_status':'pending',
                              'payment_type':'none'
                            }).then((value) {
                              Navigator.pop(context);

                              String salesorder_id=productRef.id;


                              for(int i=0;i<cartdata.length;i++) {

                                showLoaderDialog(context);

                                FirebaseFirestore.instance
                                    .collection(
                                    'sales_orders').doc().set({
                                  'product_id':cartdata[i].product_id,
                                  'product_master_id':cartdata[i].productmaster_id,
                                  'qty':cartdata[i].qty,
                                  'order_id':salesorder_id,
                                  'unit_price':cartdata[i].unitprice,
                                  'user_id':uid.toString()
                                }).then((value) {

                                  Navigator.pop(context);
                                  showLoaderDialog(context);
                                  FirebaseFirestore.instance
                                      .collection(
                                      'cart').doc(cartdata[i].id).delete().then((value) {
                                    Navigator.pop(context);

                                    if(i==cartdata.length-1)
                                    {


                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(builder: (context) => MyDashboardPage()),
                                      );
                                    }

                                  });





                                });
                              }






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
                          title: Text("Profile"),
                          content: Text("Do you want to confirm this order ?"),
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

            ) : Container(),
            alignment: FractionalOffset.bottomCenter,
          )

        ],




      ),

      )



    ) );
  }


  getCartCount()async{

    final preferenceDataStorage = await SharedPreferences
        .getInstance();
    String? uid=  preferenceDataStorage.getString(Constants.pref_userid);

    final productSnapshot = await FirebaseFirestore.instance.collection('cart').get();


    List<dynamic>c=    productSnapshot.docs.toList();

    cartdata.clear();

    for(int i=0;i<c.length;i++) {
      QueryDocumentSnapshot ab = c[i];

      var m = ab.data() as Map<String, dynamic>;
      String userid=m['userid'];
      String product_id=m['product_id'];
      String productmaster_id=m['product_masterid'];
      String qty=m['qty'];
      String cartid=ab.id;

      if(userid.trim().compareTo(uid.toString())==0)
      {

        CartData c1=    CartData(cartid, userid.trim(), qty, "", "", "", "",product_id,productmaster_id);
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

    final productSnapshot = await FirebaseFirestore.instance.collection('addresslist').get();


    List<dynamic>c=    productSnapshot.docs.toList();


    adr.clear();

    for(int i=0;i<c.length;i++) {
      QueryDocumentSnapshot ab = c[i];

      var m = ab.data() as Map<String, dynamic>;
      String userid=m['userid'];
      String address=m['address'];
      if(userid.trim().compareTo(uid.toString())==0)
        {

          setState(() {

            // if(k==1)
            //   {
                adr.add(new Address(ab.id, address,1));
            //   }
            // else{
            //
            //   adr.add(new Address(ab.id, address,0));
            // }



          });

        }



    }

    for(int i=0;i<adr.length;i++) {
      setState(() {

        adr[selectedindex].selected=1;
      });

    }


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
