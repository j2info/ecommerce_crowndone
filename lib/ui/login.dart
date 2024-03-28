import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/designs/ResponsiveInfo.dart';
import 'package:ecommerce/ui/adminhome.dart';
import 'package:ecommerce/ui/dashboard.dart';
import 'package:ecommerce/ui/registration.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ecommerce/constants/Constants.dart';

class Login extends StatefulWidget {
  Login();

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xfff1f5f9),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: Image.asset(
              "assets/images/colorlogo.png",
              width: ResponsiveInfo.isMobile(context) ? 120 : 150,
              height: ResponsiveInfo.isMobile(context) ? 120 : 150,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(ResponsiveInfo.isMobile(context) ? 10 : 15),
            child: TextField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Username',
                hintText: 'Username',
              ),
              controller: userController,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(ResponsiveInfo.isMobile(context) ? 10 : 15),
            child: TextField(
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
                hintText: 'Enter secure password',
              ),
              controller: passwordController,
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
                  'Log in',
                  style: TextStyle(color: Colors.white, fontSize: ResponsiveInfo.isMobile(context) ? 12 : 14),
                ),
                onPressed: () async {
                  // Call a function to authenticate user
                  authenticateUser();
                },
              ),
            ),
          ),
          SizedBox(
            height: ResponsiveInfo.isMobile(context) ? 20 : 25,
          ),
          Container(
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: ResponsiveInfo.isMobile(context) ? 5.0 : 7.0),
                    child: Text('Don\'t you have an account? ', style: TextStyle(color: Colors.black87, fontSize: ResponsiveInfo.isMobile(context) ? 14 : 17)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: ResponsiveInfo.isMobile(context) ? 1.0 : 3.0),
                    child: InkWell(
                      onTap: () {
                        print('hello');
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Registration()));
                      },
                      child: Text('Register', style: TextStyle(fontSize: ResponsiveInfo.isMobile(context) ? 14 : 17, color: Colors.blue)),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void authenticateUser() async {
    String name = userController.text.trim();
    String password = passwordController.text.trim();

    if (name.isEmpty || password.isEmpty) {
      // Handle case where name or password is empty
      return;
    }

    // Check if user is admin
    bool isAdmin = await checkAdmin(name, password);
    if (isAdmin) {
      // Navigate to admin page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AdminHomePage()),
      );
    } else {
      // Check if user exists in registration collection
      bool isValidUser = await checkUserCredentials(name, password);
      if (isValidUser) {
        // Navigate to regular user page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Dashboard()),
        );
      } else {
        userController.clear();
        passwordController.clear();
        // Show dialog box for invalid credentials
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Invalid Credentials"),
              content: Text("The username or password is incorrect."),
              actions: <Widget>[
                TextButton(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    }
  }

  Future<bool> checkAdmin(String name, String password) async {
    // Initialize Firebase if not already initialized
    await Firebase.initializeApp();

    // Check if name or password is null
    if (name == null || password == null) {
      return false;
    }

    // Query Firestore to check if the user exists and get their userType
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance.collection('users').where('email', isEqualTo: name).where('password', isEqualTo: password).get();

    // If query returns a document, check if it's an admin
    if (querySnapshot.docs.isNotEmpty) {
      // String userType = querySnapshot.docs.first.data()['usertype'];
   String userid=   querySnapshot.docs.first.id;

   final preferenceDataStorage = await SharedPreferences
       .getInstance();
   preferenceDataStorage.setString(Constants.pref_userid, userid);
   preferenceDataStorage.setString(Constants.pref_usertype, Constants.admin_usertype);
   return true;
      // return userType == '31aAARMH4Mbu0gy6HlJ4';
    }

    // If no document found, return false
    return false;
  }

  Future<bool> checkUserCredentials(String name, String password) async {
    // Initialize Firebase if not already initialized
    await Firebase.initializeApp();

    // Query Firestore to check if the user exists in registration collection
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance.collection('registration').where('email', isEqualTo: name).where('password', isEqualTo: password).get();

    // If query returns a document, user credentials are valid
    if (querySnapshot.docs.isNotEmpty) {

      String userid=   querySnapshot.docs.first.id;

      final preferenceDataStorage = await SharedPreferences
          .getInstance();
      preferenceDataStorage.setString(Constants.pref_userid, userid);
      preferenceDataStorage.setString(Constants.pref_usertype, Constants.normal_usertype);


      return true;
    }

    // If no document found, user credentials are invalid
    return false;
  }
}
