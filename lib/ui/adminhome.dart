import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'productdetailspage.dart';
import 'productunit.dart';
import 'orderedlist.dart';
import 'pre_orders.dart';


class AdminHomePage extends StatefulWidget {
  @override
  _AdminHomePageState createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.home),
            SizedBox(width: 20),
            Text(
              'Admin Home Page',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.blue,
        elevation: 4.0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 30),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 20.0,
                crossAxisSpacing: 20.0,
                childAspectRatio: 1.5,
                children: [
                  _buildCategoryCard('User', Icons.person, () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => UserListPage()));
                  }),
                  _buildCategoryCard('Product', Icons.shopping_bag, () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => AdminPage()));
                  }),
                  _buildCategoryCard('Orders', Icons.add_shopping_cart, () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => OrderedListScreen()));
                  }),
                  _buildCategoryCard('Units', Icons.category_outlined, () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ProductListScreen()));
                  }),
                  // _buildCategoryCard('Categories', Icons.category_outlined, () {
                  //   Navigator.push(context, MaterialPageRoute(builder: (context) => AdminPage()));
                  // }),
                ],
              ),
            ),

              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PreOrders()), // Navigate to PreOrders page
                  );
                },
                child: Text('PreOrders'), // Text on the button
              ),
            ],

        ),
      ),
    );
  }

  Widget _buildCategoryCard(String title, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 40,
              ),
              SizedBox(height: 10),
              Text(
                title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UserListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User List'),
      ),
      body: UserList(),
    );
  }
}

class UserList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('registration').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        final users = snapshot.data!.docs.map((DocumentSnapshot document) {
          final data = document.data() as Map<String, dynamic>;
          final name = data['name'] as String?;
          final email = data['email'] as String?;
          return {'name': name, 'email': email};
        }).toList();
        return ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index];
            return Card(
              color: Colors.blue.withOpacity(0.1), // Set the color of the card
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                leading: Icon(Icons.person, color: Colors.blue),
                title: Text(
                  user['name'] ?? 'No Name',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                subtitle: Text(
                  user['email'] ?? 'No Email',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                onTap: () {

                },
              ),
            );
          },
        );
      },
    );
  }
}





void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Admin App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AdminHomePage(),
    );
  }
}
class ProductUnitPage extends StatefulWidget {
  final Map<String, dynamic> product;

  const ProductUnitPage({Key? key, required this.product}) : super(key: key);

  @override
  _ProductUnitPageState createState() => _ProductUnitPageState();
}

class _ProductUnitPageState extends State<ProductUnitPage> {
  int availableUnits = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Units - ${widget.product['name']}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Product Details',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(widget.product['imageUrl'] ?? ''),
              ),
              title: Text(widget.product['name'] ?? ''),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.product['description'] ?? ''),
                  Text('Rating: ${widget.product['rating'] ?? 'N/A'}'),
                  Text('\$${widget.product['price'] ?? ''}'),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Available Units',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Enter available units',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {
                        availableUnits = int.tryParse(value) ?? 0;
                      });
                    },
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    // Save the available units to Firestore
                    saveAvailableUnits();
                  },
                  child: Text('Save'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> saveAvailableUnits() async {
    try {
      await FirebaseFirestore.instance.collection('units').doc(widget.product['id']).set({
        'availableUnits': availableUnits,
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Available units saved successfully'),
        duration: Duration(seconds: 2),
      ));
    } catch (error) {
      print('Error saving available units: $error');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to save available units'),
        duration: Duration(seconds: 2),
      ));
    }
  }
}
