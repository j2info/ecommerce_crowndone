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
import 'package:ecommerce/ui/cart_page.dart';


class ProductDetailsAdminPage extends StatefulWidget {

  String id;
  String type;

   ProductDetailsAdminPage(this.id,this.type) ;

  @override
  _ProductDetailsAdminPageState createState() =>
      _ProductDetailsAdminPageState(this.id,this.type);
}

class _ProductDetailsAdminPageState extends State<ProductDetailsAdminPage> {


  String id;
  String type;
  _ProductDetailsAdminPageState(this.id,this.type);

  String image="",name="",description="",amount="";

  List<ProductVariants>p=[];
  int selected_index=0;

  int qty=1;

  int a=0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProductDetails();
    getCartCount();
    
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white70,
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            }
        ),
        title: Text(name,style: TextStyle(color: Colors.black,fontSize: 15),),
        centerTitle: false,
        actions: [

          (type.compareTo("admin")!=0)?  Padding(padding: EdgeInsets.all(15),

          child: GestureDetector(

            child:   badge.Badge(
              child: Icon(Icons.shopping_cart,size: 25,color: Colors.black54,),
              badgeContent: Text(a.toString(),style: TextStyle(fontSize: 12),),
            ) ,
            onTap: (){

              Navigator.push(context, MaterialPageRoute(builder: (context) => CartPage()));


            },
          )




          ) : Container()


        ],



      ),
      
      body: SingleChildScrollView(
        
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          
          children: [
            Container(
              height: 200,
              width: double.infinity, // Adjust width as needed
              child: (!image.isEmpty)? Image.network(image,
              width: double.infinity,
                height: 190,
              ) : Container(),
            ),
            Padding(padding: EdgeInsets.all(10),
            child: Text(name,style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),),

            ),

            Padding(padding: EdgeInsets.all(10),
              child: Text(description,style: TextStyle(color: Colors.black,fontSize: 14),maxLines: 7,overflow: TextOverflow.ellipsis),

            ),
            Padding(padding: EdgeInsets.all(10),
              child: Text(amount,style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),),

            ),


            Padding(padding: EdgeInsets.all(10),
              child: Container(

                width: double.infinity,
                height: 60,
child: ListView(
  scrollDirection: Axis.horizontal,
  children: List.generate(
      p.length,
          (i) => GestureDetector(
            child:  Padding(padding: EdgeInsets.all(6),

              child: Container(
                width: 75,
                decoration: BoxDecoration(

                  color: (selected_index==i)?Colors.black54:Colors.white,
                    border: Border.all(color: Color(0xff000000)),
                    borderRadius: BorderRadius.all(Radius.circular(ResponsiveInfo.isMobile(context)? 5 : 10))

                ),
                alignment: Alignment.center,
                child: Text(p[i].unit,style: TextStyle(fontSize:ResponsiveInfo.isMobile(context)? 12 : 15,color:(selected_index==i)? Colors.white:Colors.black54 )),
              ),

            ),
            onTap: ()
            {

              setState(() {

                amount=p[i].price;
                selected_index=i;

              });

            },
          )





  ),
),

              )


              ,

            ),

            (type.compareTo("admin")!=0)? Padding(padding: EdgeInsets.all(10),

              child: Stack(

                children: [

                  Align(
                    alignment: FractionalOffset.center,
                    child: Container(

                      height: ResponsiveInfo.isMobile(context)? 60:75,


                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          Container(child: TextButton(
                            child: Text("-",style: TextStyle(fontSize:ResponsiveInfo.isMobile(context)? 15 : 18,color: Colors.black ),),
                            onPressed: (){

                              if(qty>1)
                                {
                                  setState(() {
                                    qty=qty-1;

                                  });
                                }

                            },
                          ),width:ResponsiveInfo.isMobile(context)? 75:85 ,
                            decoration: BoxDecoration(
                                color: Color(0xffc7ccd3),
                              border: Border.all(color: Color(0xffc7ccd3)),
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(ResponsiveInfo.isMobile(context)? 5 : 7),
                              bottomLeft: Radius.circular(ResponsiveInfo.isMobile(context)? 5 : 7)
                              )

                          ),),

                          Padding(padding: EdgeInsets.only(top:ResponsiveInfo.isMobile(context)? 5 : 7,bottom: ResponsiveInfo.isMobile(context)? 5 : 7,right: 0,left: 0),

                          child:       Container(child:Stack(

                            children: [
                              Align(
                                child:  Padding(

                                  child:Text(qty.toString(),style: TextStyle(fontSize:ResponsiveInfo.isMobile(context)? 15 : 18,color: Colors.black ),) ,
                                  padding: EdgeInsets.all(ResponsiveInfo.isMobile(context)? 5 : 8),
                                ),
                                alignment: FractionalOffset.center,
                              )
                            ],
                          ),

                            decoration: BoxDecoration(

                              border: Border.all(color: Color(0xff000000)),
                            )



                            ,width:ResponsiveInfo.isMobile(context)? 75:85 ,),

                          )

                    ,

                          Container(child: TextButton(
                            child: Text("+",style: TextStyle(fontSize:ResponsiveInfo.isMobile(context)? 15 : 18,color: Colors.white ),),
                            onPressed: (){

                              setState(() {

                                qty=qty+1;


                              });



                            },
                          ),  decoration: BoxDecoration(
                              color: Color(0xff1e293b),
                              border: Border.all(color: Color(0xff1e293b)),
                              borderRadius: BorderRadius.only(topRight: Radius.circular(ResponsiveInfo.isMobile(context)? 5 : 7),
                                  bottomRight: Radius.circular(ResponsiveInfo.isMobile(context)? 5 : 7)
                              )

                          ),width:ResponsiveInfo.isMobile(context)? 75:85 ,),




                        ],

                      ),
                    ),
                  )

                ],
              )

            ) :Container(),

        Padding(padding: EdgeInsets.all(10),

          child: Row(
            children: [

              Expanded(child:(type.compareTo("admin")!=0)? GestureDetector(

                child: Padding(
                  child:Container(
                    width: double.infinity,

                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black54),
                        borderRadius: BorderRadius.all(Radius.circular(ResponsiveInfo.isMobile(context)? 10 : 15))

                    ),


                    child:  TextButton(
                      child: Text( 'Subscribe', style: TextStyle(color: Colors.black, fontSize: ResponsiveInfo.isMobile(context)?12:14,fontWeight: FontWeight.bold),
                      ),
                      onPressed: ()async{







                      },

                    ),

                  ) ,
                  padding: EdgeInsets.all(ResponsiveInfo.isMobile(context)?8:12),
                ),
                onTap: (){

                  // Navigator.pop(context);

                },
              ) : Container()




                ,flex: 1,),
              Expanded(child: (type.compareTo("admin")!=0)? GestureDetector(

                child: Padding(
                  child: Container(
                    width: double.infinity,

                    decoration: BoxDecoration(
                        color: Color(0xff255eab),
                        border: Border.all(color: Color(0xff255eab)),
                        borderRadius: BorderRadius.all(Radius.circular(ResponsiveInfo.isMobile(context)? 10 : 15))

                    ),


                    child:  TextButton(
                      child: Text( 'Add to Cart', style: TextStyle(color: Colors.white, fontSize: ResponsiveInfo.isMobile(context)?12:14,fontWeight: FontWeight.bold),
                      ),
                      onPressed: ()async{

                        showLoaderDialog(context);


                        FirebaseFirestore.instance.collection('cart').get().then((value)async {
                         var b= value.docs.toList();
                         bool isexist=false;
                         final preferenceDataStorage = await SharedPreferences
                             .getInstance();
                         String? uid=  preferenceDataStorage.getString(Constants.pref_userid);
    for(int i=0;i<b.length;i++) {
      QueryDocumentSnapshot ab = b[i];

      var m = ab.data() as Map<String, dynamic>;
      String product_id=m['product_id'];
      String userid=m['userid'];
      if((product_id.compareTo(p[selected_index].id.toString())==0) && (userid.compareTo(uid.toString())==0) )
        {
          isexist=true;
          break;
        }
    }

    if(isexist)
      {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Product already Added to cart'),
          ),
        );

        Navigator.pop(context);

      }
    else{

      var p1=  await FirebaseFirestore.instance.collection('cart').add({
        'product_masterid': id,
        'product_id': p[selected_index].id.toString(),
        'qty': qty.toString(),
        'userid': uid.toString(),

      }).whenComplete(() {

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Product Added to cart'),
          ),
        );

        getCartCount();

        Navigator.pop(context);



      });
    }


                        });













                      },

                    ),

                  ),
                  padding: EdgeInsets.all(ResponsiveInfo.isMobile(context)?8:12),
                ) ,
                onTap: ()async{




                },
              ) :Container()


                ,flex: 1,)


            ],

          ),

        )


            
            
            
            
            
          ],
          
          
          
        ),
        
        
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


  getProductDetails()async
  {
    final productSnapshot = await FirebaseFirestore.instance.collection('product_master').get();
    productSnapshot.docs.forEach((element) {
      if(element.id.compareTo(id)==0) {
        var m = element.data();

        setState(() {
          description = m['description'];
          image = m['image'];
          name = m['name'];
        });
      }

    });


    final productSnapshot1 = await FirebaseFirestore.instance.collection('products').get();

    List<dynamic>c=    productSnapshot1.docs.toList();
    bool a=false;
    for(int i=0;i<c.length;i++)
    {

      QueryDocumentSnapshot ab=c[i];

      var m = ab.data() as Map<String,dynamic>;


      String  id1 = m['id'];
      if(id1.compareTo(id)==0)
      {
        String productid=ab.id;

        String amount1=m['Amount'];
        String units=m['units'].toString().trim();

        setState(() {
          amount=amount1;
        });

        await FirebaseFirestore.instance.collection('units').doc(units).get().then((value) {
          Map<String,dynamic> m1= value.data()!;
          String units_name=m1['name'];
          ProductVariants pp=new ProductVariants(productid,units_name,amount1);

          setState(() {
            p.add(pp);
          });

        });



      }

    }

  }


  getCartCount()async{

    final preferenceDataStorage = await SharedPreferences
        .getInstance();
    String? uid=  preferenceDataStorage.getString(Constants.pref_userid);

    final productSnapshot = await FirebaseFirestore.instance.collection('cart').get();


    List<dynamic>c=    productSnapshot.docs.toList();

a=0;

    for(int i=0;i<c.length;i++) {
      QueryDocumentSnapshot ab = c[i];

      var m = ab.data() as Map<String, dynamic>;
      String userid=m['userid'];
      if(userid.compareTo(uid.toString())==0)
        {

          setState(() {
            a=a+1;

          });
        }


    }


  }


}
