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
import 'package:ecommerce/ui/sales_order_items_page.dart';

class SalesOrderyAdmin extends StatefulWidget {
   SalesOrderyAdmin() ;

  @override
  _SalesOrderyAdminState createState() => _SalesOrderyAdminState();
}

class _SalesOrderyAdminState extends State<SalesOrderyAdmin> {


  List<SalesOrderData>sdata=[];

  String dropdownvalue = 'pending';

  // List of items in our dropdown menu
  var items = [
    'pending',
    'ordered',
    'Delivered'

  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCartCount();

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
          "Orders",
          style: TextStyle(
              color: Colors.black,
              fontSize:ResponsiveInfo.isMobile(context)? 15 :18,
              fontFamily: 'poppins',
              fontWeight: FontWeight.bold),
        ),



      ),

      body: Stack(

        children: [

          (sdata.length>0)?   Align(
            alignment: FractionalOffset.topCenter,
            child: ListView.builder(
                itemCount: sdata.length,
                padding: EdgeInsets.all(ResponsiveInfo.isMobile(context)? 5 : 8),
                itemBuilder: (BuildContext context, int index) {
                  return Card(

                    child: Container(

                      width: double.infinity,
                      height: ResponsiveInfo.isMobile(context)? 150 : 190,
                      child:ListTile(
                        leading:  Icon(Icons.list,size:ResponsiveInfo.isMobile(context)? 20 : 25,color: Colors.black54,),
                        trailing: TextButton(

                          child:Text(
                            "View",
                            style: TextStyle(color: Colors.blueAccent, fontSize: ResponsiveInfo.isMobile(context)? 13:16),
                          ) ,
                          onPressed: (){

                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SalesOrderItemsPage(sdata[index].address_id,sdata[index].id)),
                            );

                          },
                        )

                        ,
                        title: Text(sdata[index].date+"\nTotal Amount :"+sdata[index].amount,      style: TextStyle(color: Colors.black, fontSize: ResponsiveInfo.isMobile(context)? 13:16)),
                        subtitle: DropdownButton(

                          // Initial Value
                          value: sdata[index].order_status,

                          // Down Arrow Icon
                          icon: const Icon(Icons.keyboard_arrow_down,size: 10),

                          // Array list of items
                          items: items.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items),
                            );
                          }).toList(),
                          // After selecting the desired option,it will
                          // change button value to selected value
                          onChanged: (String? newValue)async {

                            await FirebaseFirestore.instance.collection('sales_order').doc(sdata[index].id).update({'order_status':newValue!}).then((value) {


                              setState(() {
                                sdata[index].order_status = newValue!;




                              });


                            });
                            
                            
                            

                          },
                        ),

                      )


                       ,
                    )



                    ,




                  )


                  ;
                }),



          ) :

              Align(
                alignment: FractionalOffset.center,
                child: Text("No data found"),
              )




        ],
      ),

    );
  }




  getCartCount()async{

    final preferenceDataStorage = await SharedPreferences
        .getInstance();
    String? uid=  preferenceDataStorage.getString(Constants.pref_userid);

    final productSnapshot = await FirebaseFirestore.instance.collection('sales_order').get();


    List<dynamic>c=    productSnapshot.docs.toList();



    for(int i=0;i<c.length;i++) {
      QueryDocumentSnapshot ab = c[i];

      var m = ab.data() as Map<String, dynamic>;
      String date=m['date'];
      String total_amount=m['total_amount'];
      String order_status=m['order_status'];

      String address_id=m['address_id'];
      String user_id=m['userid'];
      String id=ab.id;

        SalesOrderData sd = new SalesOrderData(
            id, address_id, total_amount, order_status,
            user_id, date);

        setState(() {
          sdata.add(sd);
        });


    }







  }
}
