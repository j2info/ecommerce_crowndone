import 'package:flutter/material.dart';
import 'package:ecommerce/designs/ResponsiveInfo.dart';

class WalletRequest extends StatefulWidget {
   WalletRequest() ;

  @override
  _WalletRequestState createState() => _WalletRequestState();
}

class _WalletRequestState extends State<WalletRequest> {








  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff1f5f9),
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {

Navigator.pop(context);

            }, icon: Icon(Icons.clear,color: Colors.black,)),
        elevation: 0,
        centerTitle: false,
        backgroundColor: Colors.white,
        title: Text(
          "Withdraw request",
          style: TextStyle(
              color: Colors.black,
              fontSize:ResponsiveInfo.isMobile(context)? 15 :18,
              fontFamily: 'poppins',
              fontWeight: FontWeight.bold),
        ),


      ),

      body: SingleChildScrollView(

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [

            Padding(padding: EdgeInsets.all(ResponsiveInfo.isMobile(context)?10:14),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(padding: EdgeInsets.all(4),
                      child: Text( 'Request form', style: TextStyle(color: Colors.black, fontSize: ResponsiveInfo.isMobile(context)?20:25,fontWeight: FontWeight.bold),


                      )),
                  Padding(padding: EdgeInsets.all(4),
                      child: Text( 'Fill the form and send request', style: TextStyle(color: Colors.black54, fontSize: ResponsiveInfo.isMobile(context)?10:13,fontWeight: FontWeight.normal),


                      ))
                ],
              ),

            ),



            Padding(padding: EdgeInsets.all(ResponsiveInfo.isMobile(context)?10:14),

                child:Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: new TextSpan(
                        // Note: Styles for TextSpans must be explicitly defined.
                        // Child text spans will inherit styles from parent
                        style: new TextStyle(
                          fontSize: ResponsiveInfo.isMobile(context)?12:16,
                          color: Colors.black,
                        ),
                        children: <TextSpan>[
                          new TextSpan(text: 'Amount'),
                          new TextSpan(text: ' * \n', style: new TextStyle(fontWeight: FontWeight.bold,color: Colors.red)),
                        ],
                      ),
                    ),

                    Container(
                      padding:  EdgeInsets.all(ResponsiveInfo.isMobile(context)? 10 : 15),
                      width: double.infinity,
                      height:ResponsiveInfo.isMobile(context)? 55 : 65 ,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black54),
                          borderRadius: BorderRadius.all(Radius.circular(ResponsiveInfo.isMobile(context)? 10 : 15))

                      ),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            border: InputBorder.none,

                            hintText: 'Amount',
                            hintStyle: TextStyle(fontSize:ResponsiveInfo.isMobile(context)? 12 : 14,color: Colors.black26 )
                        ),


                        style: TextStyle(fontSize:ResponsiveInfo.isMobile(context)? 12 : 14,color: Colors.black87 ),

                      ),
                    ),

                    Padding(padding: EdgeInsets.all(4),
                        child: Text( 'Minimum withdrawal amount: ₹1000', style: TextStyle(
                            color: Colors.black54, fontSize: ResponsiveInfo.isMobile(context)?8:11,fontWeight: FontWeight.normal),


                        ))
                  ],
                )

            ),



            Padding(padding: EdgeInsets.all(ResponsiveInfo.isMobile(context)?10:14),

                child:Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: new TextSpan(
                        // Note: Styles for TextSpans must be explicitly defined.
                        // Child text spans will inherit styles from parent
                        style: new TextStyle(
                          fontSize: ResponsiveInfo.isMobile(context)?12:16,
                          color: Colors.black,
                        ),
                        children: <TextSpan>[
                          new TextSpan(text: 'Account number'),
                          new TextSpan(text: ' * \n', style: new TextStyle(fontWeight: FontWeight.bold,color: Colors.red)),
                        ],
                      ),
                    ),

                    Container(
                      padding:  EdgeInsets.all(ResponsiveInfo.isMobile(context)? 10 : 15),
                      width: double.infinity,
                      height:ResponsiveInfo.isMobile(context)? 55 : 65 ,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black54),
                          borderRadius: BorderRadius.all(Radius.circular(ResponsiveInfo.isMobile(context)? 10 : 15))

                      ),

                      // padding: EdgeInsets.symmetric(horizontal: 15,vertical: 50),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            border: InputBorder.none,

                            hintStyle: TextStyle(fontSize:ResponsiveInfo.isMobile(context)? 12 : 14,color: Colors.black26 ),
                            hintText: 'Enter bank account number'),
                        style: TextStyle(fontSize:ResponsiveInfo.isMobile(context)? 12 : 14,color: Colors.black87 ),

                      ),
                    )


                  ],
                )

            ),




            Padding(padding: EdgeInsets.all(ResponsiveInfo.isMobile(context)?10:14),

                child:Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: new TextSpan(
                        // Note: Styles for TextSpans must be explicitly defined.
                        // Child text spans will inherit styles from parent
                        style: new TextStyle(
                          fontSize: ResponsiveInfo.isMobile(context)?12:16,
                          color: Colors.black,
                        ),
                        children: <TextSpan>[
                          new TextSpan(text: 'Bank name'),
                          new TextSpan(text: ' * \n', style: new TextStyle(fontWeight: FontWeight.bold,color: Colors.red)),
                        ],
                      ),
                    ),

                    Container(
                      padding:  EdgeInsets.all(ResponsiveInfo.isMobile(context)? 10 : 15),
                      width: double.infinity,
                      height:ResponsiveInfo.isMobile(context)? 55 : 65 ,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black54),
                          borderRadius: BorderRadius.all(Radius.circular(ResponsiveInfo.isMobile(context)? 10 : 15))

                      ),

                      // padding: EdgeInsets.symmetric(horizontal: 15,vertical: 50),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            border: InputBorder.none,

                            hintStyle: TextStyle(fontSize:ResponsiveInfo.isMobile(context)? 12 : 14,color: Colors.black26 ),
                            hintText: 'Enter bank name'),
                        style: TextStyle(fontSize:ResponsiveInfo.isMobile(context)? 12 : 14 ,color: Colors.black87),

                      ),
                    )


                  ],
                )

            ),



            Padding(padding: EdgeInsets.all(ResponsiveInfo.isMobile(context)?10:14),

                child:Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: new TextSpan(
                        // Note: Styles for TextSpans must be explicitly defined.
                        // Child text spans will inherit styles from parent
                        style: new TextStyle(
                          fontSize: ResponsiveInfo.isMobile(context)?12:16,
                          color: Colors.black,
                        ),
                        children: <TextSpan>[
                          new TextSpan(text: 'IFSC Code'),
                          new TextSpan(text: ' * \n', style: new TextStyle(fontWeight: FontWeight.bold,color: Colors.red)),
                        ],
                      ),
                    ),

                    Container(
                      padding:  EdgeInsets.all(ResponsiveInfo.isMobile(context)? 10 : 15),
                      width: double.infinity,
                      height:ResponsiveInfo.isMobile(context)? 55 : 65 ,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black54),
                          borderRadius: BorderRadius.all(Radius.circular(ResponsiveInfo.isMobile(context)? 10 : 15))

                      ),

                      // padding: EdgeInsets.symmetric(horizontal: 15,vertical: 50),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            // labelText: 'Enter Password',
                            hintStyle: TextStyle(fontSize:ResponsiveInfo.isMobile(context)? 12 : 14,color: Colors.black26 ),
                            hintText: 'Enter IFSC code'),
                        style: TextStyle(fontSize:ResponsiveInfo.isMobile(context)? 12 : 14 ,color: Colors.black87),

                      ),
                    )


                  ],
                )

            ),

            Padding(padding: EdgeInsets.all(ResponsiveInfo.isMobile(context)?10:14),

                child:Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: new TextSpan(
                        // Note: Styles for TextSpans must be explicitly defined.
                        // Child text spans will inherit styles from parent
                        style: new TextStyle(
                          fontSize: ResponsiveInfo.isMobile(context)?12:16,
                          color: Colors.black,
                        ),
                        children: <TextSpan>[
                          new TextSpan(text: 'Bank Address'),
                          new TextSpan(text: ' * \n', style: new TextStyle(fontWeight: FontWeight.bold,color: Colors.red)),
                        ],
                      ),
                    ),

                    Container(
                      padding:  EdgeInsets.all(ResponsiveInfo.isMobile(context)? 10 : 15),
                      width: double.infinity,
                      height:ResponsiveInfo.isMobile(context)? 120 : 150 ,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black54),
                          borderRadius: BorderRadius.all(Radius.circular(ResponsiveInfo.isMobile(context)? 10 : 15))

                      ),

                      // padding: EdgeInsets.symmetric(horizontal: 15,vertical: 50),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            // labelText: 'Enter Password',
                            hintStyle: TextStyle(fontSize:ResponsiveInfo.isMobile(context)? 12 : 14,color: Colors.black26 ),
                            hintText: 'Enter Bank Address'),
                        style: TextStyle(fontSize:ResponsiveInfo.isMobile(context)? 12 : 14 ,color: Colors.black87),

                      ),
                    )


                  ],
                )

            ),



            Padding(padding: EdgeInsets.all(ResponsiveInfo.isMobile(context)? 10 : 15),
              child: Row(
    children: [
      
      Expanded(child: Padding(
    child:Container(
      width: double.infinity,

      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black54),
          borderRadius: BorderRadius.all(Radius.circular(ResponsiveInfo.isMobile(context)? 10 : 15))

      ),


      child:  TextButton(
        child: Text( 'Cancel', style: TextStyle(color: Colors.black, fontSize: ResponsiveInfo.isMobile(context)?12:14,fontWeight: FontWeight.bold),
        ),
        onPressed: ()async{







        },

      ),

    ) ,
        padding: EdgeInsets.all(ResponsiveInfo.isMobile(context)?8:12),
    )


      ,flex: 1,),
      Expanded(child:Padding(
    child: Container(
        width: double.infinity,

        decoration: BoxDecoration(
            color: Color(0xff255eab),
            border: Border.all(color: Color(0xff255eab)),
            borderRadius: BorderRadius.all(Radius.circular(ResponsiveInfo.isMobile(context)? 10 : 15))

        ),


        child:  TextButton(
          child: Text( 'Send Request', style: TextStyle(color: Colors.white, fontSize: ResponsiveInfo.isMobile(context)?12:14,fontWeight: FontWeight.bold),
          ),
          onPressed: ()async{







          },

        ),

      ),
        padding: EdgeInsets.all(ResponsiveInfo.isMobile(context)?8:12),
      ),flex: 1,)
      
      
    ],
    
    )



            ),













          ],



        ),

      ),


    );
  }
}
