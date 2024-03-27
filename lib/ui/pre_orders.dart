import 'package:flutter/material.dart';
import 'package:ecommerce/designs/ResponsiveInfo.dart';
import 'UserProductView.dart';

class PreOrders extends StatefulWidget {
  PreOrders();

  @override
  _PreOrdersState createState() => _PreOrdersState();
}

class _PreOrdersState extends State<PreOrders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff1f5f9),
      body: Stack(
        children: [
          Align(
            alignment: FractionalOffset.topCenter,
            child: SingleChildScrollView(



            child : Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(
                      ResponsiveInfo.isMobile(context) ? 10 : 15),
                  child: Container(
                    padding: EdgeInsets.all(
                        ResponsiveInfo.isMobile(context) ? 10 : 15),
                    width: double.infinity,
                    height: ResponsiveInfo.isMobile(context) ? 55 : 65,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black54),
                        borderRadius: BorderRadius.all(Radius.circular(
                            ResponsiveInfo.isMobile(context) ? 10 : 15))),

                    // padding: EdgeInsets.symmetric(horizontal: 15,vertical: 50),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          suffixIcon: Icon(Icons.search,
                              size: ResponsiveInfo.isMobile(context) ? 20 : 24),
                          // labelText: 'Enter Password',
                          hintStyle: TextStyle(
                              fontSize:
                                  ResponsiveInfo.isMobile(context) ? 14 : 17,
                              color: Colors.black26),
                          hintText: 'Search a product'),
                      style: TextStyle(
                          fontSize: ResponsiveInfo.isMobile(context) ? 14 : 17,
                          color: Colors.black87),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(
                      ResponsiveInfo.isMobile(context) ? 10 : 15),
                  child: ListTile(
                    trailing: Padding(
                        padding: EdgeInsets.all(
                            ResponsiveInfo.isMobile(context) ? 8 : 12),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UserProductView(), // Replace OtherPage with the desired page
                              ),
                            );
                          },

                          child: Container(
                              padding: EdgeInsets.all(
                                  ResponsiveInfo.isMobile(context) ? 6 : 9),
                              decoration: BoxDecoration(
                                  color: Color(0xff2453a4),
                                  border: Border.all(color: Color(0xff2453a4)),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          ResponsiveInfo.isMobile(context)
                                              ? 10
                                              : 15))),
                              child: Text(
                                " See all  > ",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: ResponsiveInfo.isMobile(context)
                                        ? 12
                                        : 14,
                                    fontWeight: FontWeight.normal),
                                maxLines: 2,
                              )),
                          // onTap: () {},
                        )),
                    title: Text(
                      "Top Categories",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: ResponsiveInfo.isMobile(context) ? 17 : 20,
                          fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      "Check out our top category list",
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: ResponsiveInfo.isMobile(context) ? 12 : 15),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(
                      ResponsiveInfo.isMobile(context) ? 10 : 15),
                  child: SingleChildScrollView(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(
                              ResponsiveInfo.isMobile(context) ? 8 : 12),
                          child: Image.asset(
                            "assets/images/cat1.png",
                            width: ResponsiveInfo.isMobile(context) ? 75 : 90,
                            height: ResponsiveInfo.isMobile(context) ? 75 : 90,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(
                              ResponsiveInfo.isMobile(context) ? 8 : 12),
                          child: Image.asset(
                            "assets/images/cat2.png",
                            width: ResponsiveInfo.isMobile(context) ? 75 : 90,
                            height: ResponsiveInfo.isMobile(context) ? 75 : 90,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(
                              ResponsiveInfo.isMobile(context) ? 8 : 12),
                          child: Image.asset(
                            "assets/images/cat3.png",
                            width: ResponsiveInfo.isMobile(context) ? 75 : 90,
                            height: ResponsiveInfo.isMobile(context) ? 75 : 90,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(
                              ResponsiveInfo.isMobile(context) ? 8 : 12),
                          child: Image.asset(
                            "assets/images/cat4.png",
                            width: ResponsiveInfo.isMobile(context) ? 75 : 90,
                            height: ResponsiveInfo.isMobile(context) ? 75 : 90,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(
                      ResponsiveInfo.isMobile(context) ? 10 : 15),
                  child: ListTile(
                    trailing: Padding(
                        padding: EdgeInsets.all(
                            ResponsiveInfo.isMobile(context) ? 8 : 12),
                        child: GestureDetector(
                          child: Container(
                              padding: EdgeInsets.all(
                                  ResponsiveInfo.isMobile(context) ? 6 : 9),
                              decoration: BoxDecoration(
                                  color: Color(0xff2453a4),
                                  border: Border.all(color: Color(0xff2453a4)),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          ResponsiveInfo.isMobile(context)
                                              ? 10
                                              : 15))),
                              child: Text(
                                " See all  > ",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: ResponsiveInfo.isMobile(context)
                                        ? 12
                                        : 14,
                                    fontWeight: FontWeight.normal),
                                maxLines: 2,
                              )),
                          onTap: () {},
                        )),
                    title: Text(
                      "Featured Products",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: ResponsiveInfo.isMobile(context) ? 17 : 20,
                          fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      "Check out our top picks.",
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: ResponsiveInfo.isMobile(context) ? 12 : 15),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(
                      ResponsiveInfo.isMobile(context) ? 10 : 15),
                  child: SizedBox(
                    height: ResponsiveInfo.isMobile(context) ? 200 : 230,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: List.generate(
                        3,
                        (i) => Padding(
                            padding: EdgeInsets.all(
                                ResponsiveInfo.isMobile(context) ? 5 : 8),
                            child: SizedBox(
                                width: ResponsiveInfo.isMobile(context)
                                    ? 150
                                    : 180,
                                child: Card(
                                  elevation:
                                      ResponsiveInfo.isMobile(context) ? 5 : 8,
                                  color: Colors.white,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Image.asset(
                                          "assets/images/productimg.png",
                                          width: double.infinity,
                                          height:
                                              ResponsiveInfo.isMobile(context)
                                                  ? 70
                                                  : 85,
                                        ),
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
                                                  "Lubeck Honey Plus Herbs",
                                                  style: TextStyle(
                                                      color: Colors.black54,
                                                      fontSize: ResponsiveInfo
                                                              .isMobile(context)
                                                          ? 12
                                                          : 15),
                                                )),
                                            Text(
                                              "₹19.99",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize:
                                                      ResponsiveInfo.isMobile(
                                                              context)
                                                          ? 17
                                                          : 20,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        ),
                                        flex: 1,
                                      )
                                    ],
                                  ),
                                ))),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(
                      ResponsiveInfo.isMobile(context) ? 10 : 15),
                  child: ListTile(
                    title: Text(
                      "Limited Time Offers!",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: ResponsiveInfo.isMobile(context) ? 17 : 20,
                          fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      "Check out our offers.",
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: ResponsiveInfo.isMobile(context) ? 12 : 15),
                    ),
                  ),
                ),


                Padding(
                  padding: EdgeInsets.all(
                      ResponsiveInfo.isMobile(context) ? 10 : 15),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      "https://img.global.news.samsung.com/in/wp-content/uploads/2020/10/big-bilion.jpg",
                      height: ResponsiveInfo.isMobile(context) ?250.0 : 280.0,
                      width: double.infinity,
                    ),
                  ),
                )



              ],
            ),
            )



          )
        ],
      ),
    );
  }
}
