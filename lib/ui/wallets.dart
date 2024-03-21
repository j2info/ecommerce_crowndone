import 'package:flutter/material.dart';
import 'package:ecommerce/designs/ResponsiveInfo.dart';
import 'package:ecommerce/ui/wallet_request.dart';

class Wallets extends StatefulWidget {
   Wallets() ;

  @override
  _WalletsState createState() => _WalletsState();
}

class _WalletsState extends State<Wallets> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff1f5f9),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [

          Expanded(child: Column(

            children: [
              Expanded(child:   Padding(

                child:Container(

                  decoration: BoxDecoration(
                  gradient: LinearGradient(
                  begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xff2663ae),
          Color(0xff7C64BC)
        ],
      ),
                      // border: Border.all(color: Color(0xffb98902)),
                      borderRadius: BorderRadius.all(Radius.circular(ResponsiveInfo.isMobile(context)? 10 : 15))

                  ),

                  child:             Padding(padding: EdgeInsets.all(ResponsiveInfo.isMobile(context)?8:12),

                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [

                        Expanded(child:  Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [


                            Padding(padding: EdgeInsets.all(4),
                                child: Text( 'Wallet Balance', style: TextStyle(color: Colors.white,
                                    fontSize: ResponsiveInfo.isMobile(context)?15:18,fontWeight: FontWeight.bold),


                                )),
                            Padding(padding: EdgeInsets.all(4),
                                child:

                                    Text( 'Total amount of money in your wallet', style: TextStyle(color: Colors.white,
                                        fontSize: ResponsiveInfo.isMobile(context)?13:16,fontWeight: FontWeight.normal),

                                    ),


                            ),

                            Padding(padding: EdgeInsets.all(4),
                                child: Text( '₹10,000.00', style: TextStyle(color: Colors.white, fontSize: ResponsiveInfo.isMobile(context)?20:25,fontWeight: FontWeight.bold),


                                ))
                          ],
                        )


                          ,flex: 3,),


                        Expanded(child:    Padding(padding: EdgeInsets.all(8),
                          child: Stack(
                            children: [

                              Align(
                                alignment: FractionalOffset.bottomCenter,
                                child: Image.asset("assets/images/walletbg.png",width: ResponsiveInfo.isMobile(context)? 100 : 130,
                                  height: ResponsiveInfo.isMobile(context)? 100 : 130,),
                              )

                            ],

                          )

                          ,


                        ),flex: 1,),





                      ],


                    ),

                  ),

                )  ,
                padding: EdgeInsets.all(ResponsiveInfo.isMobile(context)?8:12),
              ),flex: 1)

            ,
              Expanded(child: SingleChildScrollView(

                child: Column(
                  children: [

                    Padding(

                      child:Container(
                        height: ResponsiveInfo.isMobile(context)? 80 : 120,

                        decoration: BoxDecoration(
                            color: Color(0xffffffff),
                            border: Border.all(color: Color(0xffffffff)),
                            borderRadius: BorderRadius.all(Radius.circular(ResponsiveInfo.isMobile(context)? 10 : 15))

                        ),
                        child: ListTile(
                          trailing:      Padding(padding: EdgeInsets.all(ResponsiveInfo.isMobile(context)?8:12),
                                child:Container(
                                    padding:  EdgeInsets.all(ResponsiveInfo.isMobile(context)? 6 : 9),

                                    decoration: BoxDecoration(
                                      color: Color(0xff2453a4),

                                        border: Border.all(color: Color(0xff2453a4)),
                                        borderRadius: BorderRadius.all(Radius.circular(ResponsiveInfo.isMobile(context)? 10 : 15))

                                    ),


                                    child:  Text( "Invest now   > ",
                                      style: TextStyle(color: Colors.white,
                                          fontSize: ResponsiveInfo.isMobile(context)?12:14,fontWeight: FontWeight.normal),
                                      maxLines: 2,



                                    ))

                            ),
                            title: Text("Invest more",style: TextStyle(color: Colors.black, fontSize: ResponsiveInfo.isMobile(context)?17:20,fontWeight: FontWeight.bold),),
                        subtitle:Text("Add funds to your wallet",style: TextStyle(color: Colors.black54, fontSize: ResponsiveInfo.isMobile(context)?12:15),) ,

                        ),

                      )  ,
                      padding: EdgeInsets.all(ResponsiveInfo.isMobile(context)?8:12),
                    ),



                    Padding(

                      child:Container(
                        height: ResponsiveInfo.isMobile(context)? 90 : 120,

                        decoration: BoxDecoration(
                            color: Color(0xffffffff),
                            border: Border.all(color: Color(0xffffffff)),
                            borderRadius: BorderRadius.all(Radius.circular(ResponsiveInfo.isMobile(context)? 10 : 15))

                        ),

                        child: ListTile(


                          trailing:      Padding(padding: EdgeInsets.all(ResponsiveInfo.isMobile(context)?8:12),
                              child: GestureDetector(
    child: Container(
        padding:  EdgeInsets.all(ResponsiveInfo.isMobile(context)? 6 : 9),

        decoration: BoxDecoration(
            color: Color(0xff2453a4),

            border: Border.all(color: Color(0xff2453a4)),
            borderRadius: BorderRadius.all(Radius.circular(ResponsiveInfo.isMobile(context)? 10 : 15))

        ),


        child:  Text( " Request   > ",
          style: TextStyle(color: Colors.white,
              fontSize: ResponsiveInfo.isMobile(context)?12:14,fontWeight: FontWeight.normal),
          maxLines: 2,



        )),
                                onTap: (){

                                  Navigator.push(context,
                                      MaterialPageRoute(builder:
                                          (context) =>
                                          WalletRequest()
                                      )
                                  );


                                },

    )



                          ),
                          title: Text("Withdraw request",style: TextStyle(color: Colors.black, fontSize: ResponsiveInfo.isMobile(context)?17:20,fontWeight: FontWeight.bold),),
                          subtitle:Text("Withdraw money from your wallet",style: TextStyle(color: Colors.black54, fontSize: ResponsiveInfo.isMobile(context)?12:15),) ,

                        ),

                      )  ,
                      padding: EdgeInsets.all(ResponsiveInfo.isMobile(context)?8:12),
                    )



                  ],


                ),
              ),flex: 1,)





            ],

          ),flex: 2,),


          Expanded(child: Padding(

    child: Container(

      color: Colors.white,

      child: Column(

        children: [

          Padding(

            child:Container(
              height: ResponsiveInfo.isMobile(context)? 80 : 120,

              decoration: BoxDecoration(
                  color: Color(0xffffffff),
                  border: Border.all(color: Color(0xffffffff)),
                  borderRadius: BorderRadius.all(Radius.circular(ResponsiveInfo.isMobile(context)? 10 : 15))

              ),

              child: ListTile(


                trailing:Padding(padding: EdgeInsets.all(ResponsiveInfo.isMobile(context)?8:12),
                    child:Container(
                        padding:  EdgeInsets.all(ResponsiveInfo.isMobile(context)? 6 : 9),

                        decoration: BoxDecoration(
                            color: Color(0xff2453a4),

                            border: Border.all(color: Color(0xff2453a4)),
                            borderRadius: BorderRadius.all(Radius.circular(ResponsiveInfo.isMobile(context)? 10 : 15))

                        ),


                        child:  Text( " View all > ",
                          style: TextStyle(color: Colors.white,
                              fontSize: ResponsiveInfo.isMobile(context)?12:14,fontWeight: FontWeight.normal),
                          maxLines: 2,



                        ))

                ),
                title: Text("Transaction History",style: TextStyle(color: Colors.black, fontSize: ResponsiveInfo.isMobile(context)?17:20,fontWeight: FontWeight.bold),),
                subtitle:Text("All transactions",style: TextStyle(color: Colors.black54, fontSize: ResponsiveInfo.isMobile(context)?12:15),) ,

              ),

            )  ,
            padding: EdgeInsets.all(ResponsiveInfo.isMobile(context)?8:12),
          ),

       ListView.builder(
                itemCount: 2,
                primary: false,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                      leading:  Icon(Icons.credit_card_sharp),
                      subtitle:Text("12th jan 2024 3.00 am",
                        style: TextStyle(color: Colors.black54, fontSize: ResponsiveInfo.isMobile(context)?12:15),) ,

                      trailing:  Text(
                        "₹2,500.00",

                        style: TextStyle(color: Colors.black,  fontSize: ResponsiveInfo.isMobile(context)?13:15),
                      ),
                      title: Text("Withdrawn",
                        style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: ResponsiveInfo.isMobile(context)?15:17),));
                }) ,




        ],


      ),

    ),
            padding: EdgeInsets.fromLTRB(ResponsiveInfo.isMobile(context)? 10 : 15,  ResponsiveInfo.isMobile(context)? 10 : 15, ResponsiveInfo.isMobile(context)? 10 : 15, 0),
    )



          ,


            flex: 2,)





        ],



      ),


    );
  }
}
