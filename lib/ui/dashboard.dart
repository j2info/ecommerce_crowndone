import 'package:flutter/material.dart';
import 'package:ecommerce/designs/ResponsiveInfo.dart';

class Dashboard extends StatefulWidget {
   Dashboard();

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        
        children: [
          
          Expanded(child: Padding(

          child:Container(

            decoration: BoxDecoration(
                color: Color(0xff464646),
                border: Border.all(color: Color(0xff464646)),
                borderRadius: BorderRadius.all(Radius.circular(ResponsiveInfo.isMobile(context)? 10 : 15))

            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [
                Padding(padding:  EdgeInsets.all(ResponsiveInfo.isMobile(context)?12:17),

    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [

        Icon(Icons.person_outline,color: Colors.white,),
                    Text( '   Madhu varma', style: TextStyle(color: Colors.white, fontSize: ResponsiveInfo.isMobile(context)?12:14))

      ],

    )
    ),


                Padding(padding:  EdgeInsets.all(ResponsiveInfo.isMobile(context)?12:14),


                    child: Image.asset("assets/images/qr.png",
                      width:ResponsiveInfo.isMobile(context)?150:180,height:ResponsiveInfo.isMobile(context)?150:180 ,fit: BoxFit.fill,)
                ),


    Padding(padding:  EdgeInsets.all(ResponsiveInfo.isMobile(context)?12:14),


    child:Text( 'Membership number: 123566898999', style: TextStyle(color: Colors.white, fontSize: ResponsiveInfo.isMobile(context)?12:14)

    )),


                Padding(padding:  EdgeInsets.all(ResponsiveInfo.isMobile(context)?8:10),


                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text( 'Membership type', style: TextStyle(color: Colors.white, fontSize: ResponsiveInfo.isMobile(context)?12:14)

                        ),

                        Text( 'Enterprenuer', style: TextStyle(color: Colors.white, fontSize: ResponsiveInfo.isMobile(context)?12:14)

                        )
                      ],
                    )

                   ),


                Padding(padding:  EdgeInsets.all(ResponsiveInfo.isMobile(context)?8:10),


                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text( 'Date of Membership', style: TextStyle(color: Colors.white, fontSize: ResponsiveInfo.isMobile(context)?12:14)

                        ),

                        Text( '30 January 2024', style: TextStyle(color: Colors.white, fontSize: ResponsiveInfo.isMobile(context)?12:14)

                        )
                      ],
                    )

                ),

                Padding(padding:  EdgeInsets.all(ResponsiveInfo.isMobile(context)?8:10),


                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text( 'Investment allotment date', style: TextStyle(color: Colors.white, fontSize: ResponsiveInfo.isMobile(context)?12:14)

                        ),

                        Text( '30 January 2024', style: TextStyle(color: Colors.white, fontSize: ResponsiveInfo.isMobile(context)?12:14)

                        )
                      ],
                    )

                ),


                Padding(padding:  EdgeInsets.all(ResponsiveInfo.isMobile(context)?8:10),


                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text( 'Allotment number', style: TextStyle(color: Colors.white, fontSize: ResponsiveInfo.isMobile(context)?12:14)

                        ),

                        Text( '123123/515', style: TextStyle(color: Colors.white, fontSize: ResponsiveInfo.isMobile(context)?12:14)

                        )
                      ],
                    )

                )




              ],
            ),


          ) ,
            padding: EdgeInsets.all(ResponsiveInfo.isMobile(context)?8:12),
      )

          ,flex: 3,),

          Expanded(child: Padding(

    child:Container(

      decoration: BoxDecoration(
          color: Color(0xffb98902),
          border: Border.all(color: Color(0xffb98902)),
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
                    child: Text( '5 % Cash back \n on products', style: TextStyle(color: Colors.white, fontSize: ResponsiveInfo.isMobile(context)?20:25,fontWeight: FontWeight.bold),


                    )),
                Padding(padding: EdgeInsets.all(4),
                    child: Row(

                      children: [

                        Text( 'Update your membership', style: TextStyle(color: Colors.white,
                            fontSize: ResponsiveInfo.isMobile(context)?13:16,fontWeight: FontWeight.normal),

                        ),

                        Image.asset("assets/images/arrowcircleright.png",width: ResponsiveInfo.isMobile(context)? 35 : 50,
                          height: ResponsiveInfo.isMobile(context)? 35 : 50,)



                      ],
                    )


                    )
              ],
            )


              ,flex: 3,),
            Container(width: 1,
            height: double.infinity,
            color: Colors.white,),

            Expanded(child:    Padding(padding: EdgeInsets.all(8),
              child: Stack(
              children: [

                Align(
              alignment: FractionalOffset.center,
    child: Image.asset("assets/images/Icon.png",width: ResponsiveInfo.isMobile(context)? 60 : 70,
      height: ResponsiveInfo.isMobile(context)? 60 : 70,),
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
    )
            ,flex: 1,)
          
          
        ],
      ),

    );
  }
}
