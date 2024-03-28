import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ecommerce/designs/ResponsiveInfo.dart';
import 'package:ecommerce/domain/CategoryData.dart';
import 'dart:io';

class AddCategory extends StatefulWidget {




   AddCategory() ;

  @override
  _AddCategoryState createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  TextEditingController userController = TextEditingController();

  String filepath="";


  int edit=0;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();




  }



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
        title: Text("Add Category",style: TextStyle(color: Colors.white,fontSize: 12),),
        centerTitle: false,

      ),

      body: Column(

        children: [


          Padding(
            padding: EdgeInsets.all(10),
            child: Container(
              width: 120,
              height: 120,
              child:      Stack(

                children: [

                  Align(
                    alignment: FractionalOffset.center,
                    child:(filepath.isEmpty)?Icon(Icons.image,size: 100,color: Colors.black26,):
                    Image.file(File(filepath),width: 100,height: 100,fit: BoxFit.fill,) ,

                  ),
                  Align(
                    alignment: FractionalOffset.bottomRight,

                    child:FloatingActionButton(
                      mini: true,
                      onPressed: () async{

                        final picker = ImagePicker();
                        final pickedFile = await picker.pickImage(source: ImageSource.gallery);
                        if (pickedFile != null) {
                          setState(() {
                            filepath=pickedFile.path;
                          });
                        }

                      },
                      child: Icon(Icons.add_a_photo),
                    ) ,
                  )






                ],
              ),

            )


          ),
          Padding(
            padding: EdgeInsets.all(ResponsiveInfo.isMobile(context) ? 10 : 15),
            child: TextField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Name',
                hintText: 'Name',
              ),
              controller: userController,
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
                  'Add',
                  style: TextStyle(color: Colors.white, fontSize: ResponsiveInfo.isMobile(context) ? 12 : 14),
                ),
                onPressed: () async {
                  // Call a function to authenticate user

                  if(!filepath.isEmpty)
                    {
                      if(!userController.text.isEmpty)
                      {
                        final ref = FirebaseStorage.instance.ref().child('categoryimages').child('${DateTime.now()}.jpg');
                        await ref.putFile(new File(filepath));
                        final imageUrl = await ref.getDownloadURL();

                        final productRef = FirebaseFirestore.instance.collection('categories').doc();
                        await productRef.set({
                          'name': userController.text, // Set the ID of the product as a field in the document
                          'image_path': imageUrl,


                        }).then((value) {

                          userController.clear();
                          setState(() {
                            filepath="";
                          });
                        });




                      }
                      else{
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Enter Category'),
                        ));

                      }

                    }
                  else{
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Pick file'),
                    ));

                  }

                },
              ),
            ),
          ),

        ],
      ),

    );
  }
}
