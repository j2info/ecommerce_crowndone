import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ecommerce/designs/ResponsiveInfo.dart';
import 'package:ecommerce/domain/CategoryData.dart';
import 'dart:io';
import 'package:ecommerce/ui/admin/Addproductdetailspage.dart';
import 'package:ecommerce/ui/admin/product_details_admin_page.dart';


class ProductlistPage extends StatefulWidget {
   ProductlistPage() ;

  @override
  _ProductlistPageState createState() => _ProductlistPageState();
}

class _ProductlistPageState extends State<ProductlistPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(


      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black87,
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            }
        ),
        title: Text("Product List",style: TextStyle(color: Colors.white,fontSize: 12),),
        centerTitle: false,
        actions: [

          Padding(padding: EdgeInsets.all(15),

            child: GestureDetector(
              child: Icon(Icons.add,color: Colors.white,size: ResponsiveInfo.isMobile(context)?30:35),

              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => AddProductPage()));

              },

            ),
          )




        ],


      ),

      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('product_master').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              width: double.infinity,
              height: double.infinity,
              child:Center(
                child: CircularProgressIndicator(),
              ) ,
            )

            ;
          }

          List<CategoryData>list=[];

          snapshot.data!.docs.forEach((DocumentSnapshot document)async {
            Map<String, dynamic>? data = document.data() as Map<String, dynamic>?;

            if (data != null) {
              String id = document.id;
              String name = data['name'] ?? '';
              String path = data['image'] ?? '';

              list.add(new CategoryData(id,name,path));



            }
          });



          return Stack(

            children: [

              Align(
                alignment: FractionalOffset.topCenter,
                child:ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      child:Card(

                        child:Container(
                            width: double.infinity,
                            height: 250,
                            child: Column(
                              children: [

                                Expanded(child: Image.network(list[index].imagepath,width: double.infinity,height: 190,fit: BoxFit.fill),flex: 2,)
                                ,
                                Expanded(child: Padding(

                                  child: Row(

                                    children: [

                                      Expanded(child:  Text(list[index].name,style: TextStyle(color: Colors.black, fontSize: 15),) ,flex: 1,),

                                      Expanded(child: Row(

                                        children: [
                                          Padding(padding: EdgeInsets.all(5),
                                            child: TextButton(

                                              child:Text(
                                                "Edit",
                                                style: TextStyle(color: Colors.green, fontSize: 15),
                                              ) ,
                                              onPressed: (){

                                                Widget okButton = TextButton(
                                                  child: Text("yes"),
                                                  onPressed: ()async {





                                                    Navigator.pop(context);






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
                                                  title: Text("Edit Product"),
                                                  content: Text("Do you want to edit this product details?"),
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
                                            ),

                                          ),
                                          Padding(padding: EdgeInsets.all(5),
                                          child: TextButton(

                                            child:Text(
                                              "Delete",
                                              style: TextStyle(color: Colors.green, fontSize: 15),
                                            ) ,
                                            onPressed: (){

                                              Widget okButton = TextButton(
                                                child: Text("yes"),
                                                onPressed: ()async {

                                                  final productSnapshot = await FirebaseFirestore.instance.collection('products').get();

                                                  productSnapshot.docs.forEach((element) {
                                                    var m=element.data();

                                                    String productmasterid=m['id'];
                                                    if(productmasterid.compareTo(list[index].id)==0)
                                                    {
                                                      FirebaseFirestore.instance.collection('products').doc(element.id).delete();

                                                    }





                                                  });



                                                  FirebaseFirestore.instance.collection('product_master').doc(list[index].id).delete();

                                                  setState(() {

                                                    list.removeAt(index);
                                                  });


                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                    SnackBar(
                                                      content: Text('Product Deleted Successfully'),
                                                    ),
                                                  );



                                                  Navigator.pop(context);






                                                },
                                              );

                                              Widget okButton1 = TextButton(
                                                child: Text("no"),
                                                onPressed: () { },
                                              );

                                              // set up the AlertDialog
                                              AlertDialog alert = AlertDialog(
                                                title: Text("Delete Product"),
                                                content: Text("Do you want to delete product ?"),
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
                                          ),

                                          )

                                        ],
                                      )


                                       ,flex: 1,),


                                    ],

                                  ),
                                  padding: EdgeInsets.all(10),
                                )


                                  ,flex: 1,)




                              ],

                            )
                        )


                        ,
                        elevation: 8,
                      ) ,
                      onTap: ()
                      {

                        Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailsAdminPage(list[index].id,"admin")));
                      },
                    )




                    ;
                  },
                ) ,
              ),




            ],
          )


          ;
        },
      ),


    );
  }
}
