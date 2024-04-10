import 'package:flutter/material.dart';
import 'package:ecommerce/designs/ResponsiveInfo.dart';
import 'UserProductView.dart';
import 'package:flutter/material.dart';
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
import 'package:ecommerce/ui/admin/product_details_admin_page.dart';
import 'package:ecommerce/domain/Products.dart';

class ProductListPage extends StatefulWidget {


   ProductListPage() ;

  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {

  List<Products>list_products=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProductList();

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
          "Products",
          style: TextStyle(
              color: Colors.black,
              fontSize:ResponsiveInfo.isMobile(context)? 15 :18,
              fontFamily: 'poppins',
              fontWeight: FontWeight.bold),
        ),



      ),
      body: Stack(

        children: [

          (list_products.length>0)?    Align(
            alignment: FractionalOffset.topCenter,
            child: ListView(
              scrollDirection: Axis.vertical,
              children: List.generate(
                list_products.length ,
                    (i) => GestureDetector(
                    onTap: (){

                      Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailsAdminPage(list_products[i].id,"user")));


                    },

                    child:
                    Padding(
                        padding: EdgeInsets.all(
                            ResponsiveInfo.isMobile(context) ? 5 : 8),
                        child: SizedBox(
                            width: double.infinity,
                            height: ResponsiveInfo.isMobile(context)
                                ? 120
                                : 160,
                            child: Card(
                              elevation:
                              ResponsiveInfo.isMobile(context) ? 5 : 8,
                              color: Colors.white,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment:
                                CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child:  Padding(
                                        padding: EdgeInsets.all(
                                            ResponsiveInfo.isMobile(context) ? 5 : 8),

                                        child:  Image.network(list_products[i].imagepath
                                          ,
                                          width:  ResponsiveInfo.isMobile(context)
                                              ? 70
                                              : 85,
                                          height:
                                          ResponsiveInfo.isMobile(context)
                                              ? 70
                                              : 85,
                                          fit: BoxFit.fill,
                                        ) ),
                                    flex: 1,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                            padding: EdgeInsets.all(
                                                ResponsiveInfo.isMobile(
                                                    context)
                                                    ? 3
                                                    : 6),
                                            child: Text(
                                              list_products[i].name+" "+list_products[i].unit,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: ResponsiveInfo
                                                      .isMobile(context)
                                                      ? 14
                                                      : 17),
                                            )),
                                        Text(
                                          "Price : "+list_products[i].price,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize:
                                              ResponsiveInfo.isMobile(
                                                  context)
                                                  ? 13
                                                  : 16,
                                              fontWeight: FontWeight.normal),
                                        )
                                      ],
                                    ),
                                    flex: 3,
                                  )
                                ],
                              ),
                            ))) ),
              ),
            ),
          ) : Align(
            alignment: FractionalOffset.center,
            child: Text(
              "No data found",
              style: TextStyle(
                  color: Colors.black,
                  fontSize:ResponsiveInfo.isMobile(context)? 15 :18,
                  fontFamily: 'poppins',
                  fontWeight: FontWeight.bold),
            ),
          )
        ],


      ),


    );
  }


  getProductList() async{

    final productSnapshot = await FirebaseFirestore.instance.collection('product_master').get();

    List<dynamic>c=    productSnapshot.docs.toList();



    for(int i=0;i<c.length;i++) {
      QueryDocumentSnapshot ab = c[i];

      var m = ab.data() as Map<String, dynamic>;

      String id = ab.id;
      String name = m['name'] ?? '';
      String path = m['image'] ?? '';
      String category = m['category'] ?? '';

      setState(() {


          list_products.add(new Products(id,name,path,"",""));



      });
    }


    for(int i=0;i<list_products.length;i++) {

      String productid=list_products[i].id;

      QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance.collection('products').where('id', isEqualTo: productid).get();


      List<dynamic>c1=    querySnapshot.docs.toList();


      if(c1.length>0) {

        QueryDocumentSnapshot ab1 = c1[0];

        var m1 = ab1.data() as Map<String, dynamic>;

        String Amount=m1['Amount'];
        String units=m1['units'];



        setState(() {

          list_products[i].price=Amount;

        });
        FirebaseFirestore.instance.collection('units').doc(units.trim()).get().then((value1) {
          var m3=value1.data()!;
          String unitname=m3['name'];

          setState(() {
            list_products[i].unit=unitname;

          });



        });



      }



    }
  }
}
