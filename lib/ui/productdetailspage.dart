import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:ecommerce/designs/ResponsiveInfo.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Admin Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AdminPage(),
    );
  }
}

class AdminPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Page',style: TextStyle(fontSize: ResponsiveInfo.isMobile(context)?12:14,color: Colors.black),),
      ),
      body: ProductList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddProductPage()),
          );
        },
        child: Icon(Icons.add),
      ),

    );
  }
}

class ProductList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('products').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        final products = snapshot.data!.docs;

        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            final imageUrl = product['image'] as String;
            final name = product['name_description'] as String;
            final price = product['price'] as double;
            final productId = product.id;

            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FullImageScreen(imageUrl: imageUrl)),
                );
              },
              child: Stack(
                children: [
                  Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      color: Colors.black54,
                      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            '\$$price',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 5,
                    right: 5,
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.yellow,),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => EditProductPage(productId: productId)),
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red,),
                          onPressed: () {
                            FirebaseFirestore.instance.collection('products').doc(productId).delete();
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
List<String> hsnCodes = [
  '9100',
  '9619',
  '1513',
  '3401',
  '1701',
  '1903',
  '3306',
  '2106',
  '0905',
  '1513',
  '2001',
  '2508',
  '3304',
  //  HSN codes
];
class AddProductPage extends StatefulWidget {
  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  String _selectedHsnCode = hsnCodes.first;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _itemDescriptionController = TextEditingController(); // Combine controller for item and description
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _hsnCodeController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _extraInput1Controller = TextEditingController();
  final TextEditingController _extraInput2Controller = TextEditingController();
  File? _image;

  bool _manualHsnCodeEntry = false;
  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _addProduct() async {
    if (_formKey.currentState!.validate()) {
      try {
        final ref = FirebaseStorage.instance.ref().child('product_images').child('${DateTime.now()}.jpg');
        await ref.putFile(_image!);
        final imageUrl = await ref.getDownloadURL();

        final productRef = FirebaseFirestore.instance.collection('products').doc(); // Generate a new document reference without specifying an ID
        final productId = productRef.id; // Get the automatically generated ID
        await productRef.set({
          'id': productId, // Set the ID of the product as a field in the document
          'name_description': _itemDescriptionController.text,
          'image': imageUrl,
          'price': double.parse(_priceController.text),
          'hsnCode': _manualHsnCodeEntry ? _hsnCodeController.text : _selectedHsnCode,
          'Qty': _categoryController.text,
          'Discount': _extraInput1Controller.text,
          'Amount': _extraInput2Controller.text,
        });

        final hsnCodeToAdd = _manualHsnCodeEntry ? _hsnCodeController.text : _selectedHsnCode;
        final hsnCodeDoc = FirebaseFirestore.instance.collection('hsnCodes').doc(hsnCodeToAdd);
        final productIds = await hsnCodeDoc.get().then((doc) => doc?.exists ?? false ? List.from(doc!.data()!['products']) : []);
        productIds.add(productId); // Add the product ID to the list
        await hsnCodeDoc.set({'products': productIds});

        _itemDescriptionController.clear();
        _priceController.clear();
        _hsnCodeController.clear();
        _categoryController.clear();
        _extraInput1Controller.clear();
        _extraInput2Controller.clear();
        setState(() {
          _image = null;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Product added successfully'),
          ),
        );
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to add product: $error'),
          ),
        );
      }
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,

          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (_image != null) ...[
                  Container(
                    height: 80,
                    width: double.infinity, // Adjust width as needed
                    child: Image.file(
                      _image!,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 10),
                ],

                ElevatedButton(
                  onPressed: _getImage,
                  child: Text('Add Image'),
                ),
                TextFormField(
                  controller: _itemDescriptionController, // Use combined controller for item and description
                  decoration: InputDecoration(labelText: 'Item & Description'),
                  maxLines: 5,// Update label
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter item and description';
                    }
                    return null;
                  },
                ),
                Row(
                  children: [
                    Checkbox(
                      value: _manualHsnCodeEntry,
                      onChanged: (value) {
                        setState(() {
                          _manualHsnCodeEntry = value!;
                        });
                      },
                    ),
                    Text('Manual Entry HSN/SAC'),
                    SizedBox(width: 10),
                    Expanded(
                      child: _manualHsnCodeEntry
                          ? TextFormField(
                        controller: _hsnCodeController,
                        decoration: InputDecoration(labelText: 'HSN Code'),
                        validator: (value) {
                          if (_manualHsnCodeEntry && value!.isEmpty) {
                            return 'Please enter an HSN/SAC';
                          }
                          return null;
                        },
                      )
                          : DropdownButton<String>(
                        value: _selectedHsnCode,
                        onChanged: (value) {
                          setState(() {
                            _manualHsnCodeEntry = false;
                            _selectedHsnCode = value!;
                          });
                        },
                        items: hsnCodes.map((String hsnCode) {
                          return DropdownMenuItem<String>(
                            value: hsnCode,
                            child: Text(hsnCode),
                          );
                        }).toList(),
                        disabledHint: Text('Select an HSN/SAC'),
                      ),
                    ),
                  ],
                ),
                TextFormField(
                  controller: _categoryController,
                  decoration: InputDecoration(labelText: '  Qty'),
                  // keyboardType: TextInputType.number,
                  validator: (value) {
                    // Validation logic for Category field
                    return null; // Return null if the input is valid
                  },
                ),
                TextFormField(
                  controller: _priceController,
                  decoration: InputDecoration(labelText: 'Rate'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter product price';
                    }
                    return null;
                  },
                ),




                TextFormField(
                  controller: _extraInput1Controller,
                  decoration: InputDecoration(labelText: 'Discount'),
                  // keyboardType: TextInputType.number,
                  validator: (value) {
                    // Validation logic for Extra Input 1 field
                    return null; // Return null if the input is valid
                  },
                ),
                TextFormField(
                  controller: _extraInput2Controller,
                  decoration: InputDecoration(labelText: 'Amount'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    // Validation logic for Extra Input 2 field
                    return null; // Return null if the input is valid
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _addProduct,
                  child: Text('Add Product'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}






class EditProductPage extends StatefulWidget {
  final String productId;

  EditProductPage({required this.productId});

  @override
  _EditProductPageState createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _itemDescriptionController = TextEditingController(); // Combined controller for item and description
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _hsnCodeController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _extraInput1Controller = TextEditingController();
  final TextEditingController _extraInput2Controller = TextEditingController();
  File? _image;

  @override
  void initState() {
    super.initState();
    _fetchProductDetails();
  }

  Future<void> _fetchProductDetails() async {
    try {
      final productSnapshot = await FirebaseFirestore.instance.collection('products').doc(widget.productId).get();
      if (productSnapshot.exists) {
        final productData = productSnapshot.data() as Map<String, dynamic>;
        final nameDescription = productData['name_description'] ?? ''; // Get combined field
        _itemDescriptionController.text = nameDescription;
        _priceController.text = productData['price']?.toString() ?? '';
        _hsnCodeController.text = productData['hsnCode'] ?? '';
        _categoryController.text = productData['Qty'] ?? '';
        _extraInput1Controller.text = productData['Discount'] ?? '';
        _extraInput2Controller.text = productData['Amount'] ?? '';
        setState(() {});
      } else {
        // Handle case where document doesn't exist
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Product not found'),
          ),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to fetch product details: $error'),
        ),
      );
    }
  }

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _editProduct() async {
    if (_formKey.currentState!.validate()) {
      try {
        String imageUrl = '';
        if (_image != null) {
          final ref = FirebaseStorage.instance.ref().child('product_images').child('${DateTime.now()}.jpg');
          await ref.putFile(_image!);
          imageUrl = await ref.getDownloadURL();
        }
        await FirebaseFirestore.instance.collection('products').doc(widget.productId).update({
          'name_description': _itemDescriptionController.text, // Update combined field
          'price': double.parse(_priceController.text),
          'hsnCode': _hsnCodeController.text,
          'category': _categoryController.text,
          'extraInput1': _extraInput1Controller.text,
          'extraInput2': _extraInput2Controller.text,
          if (imageUrl.isNotEmpty) 'image': imageUrl,
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Product updated successfully'),
          ),
        );
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to update product: $error'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (_image != null) ...[
                  Container(
                    height: 80,
                    width: double.infinity, // Adjust width as needed
                    child: Image.file(
                      _image!,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 10),
                ],
                ElevatedButton(
                  onPressed: _getImage,
                  child: Text('Change Image'),
                ),
                TextFormField(
                  controller: _itemDescriptionController, // Use combined controller for item and description
                  decoration: InputDecoration(labelText: 'Item & Description'), // Update label
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter item and description';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _priceController,
                  decoration: InputDecoration(labelText: 'Price'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter product price';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _hsnCodeController,
                  decoration: InputDecoration(labelText: 'HSN Code'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter HSN code';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _categoryController,
                  decoration: InputDecoration(labelText: 'Qty'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    // Validation logic for Qty field
                    return null; // Return null if the input is valid
                  },
                ),
                TextFormField(
                  controller: _extraInput1Controller,
                  decoration: InputDecoration(labelText: 'Discount'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    // Validation logic for Discount field
                    return null; // Return null if the input is valid
                  },
                ),
                TextFormField(
                  controller: _extraInput2Controller,
                  decoration: InputDecoration(labelText: 'Amount'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    // Validation logic for Amount field
                    return null; // Return null if the input is valid
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _editProduct,
                  child: Text('Update Product'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}












class FullImageScreen extends StatelessWidget {
  final String imageUrl;

  FullImageScreen({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Image.network(imageUrl),
      ),
    );
  }
}