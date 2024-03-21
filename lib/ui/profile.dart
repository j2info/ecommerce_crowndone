import 'package:flutter/material.dart';
import 'package:ecommerce/designs/ResponsiveInfo.dart';

class Profile extends StatefulWidget {
   Profile() ;

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff1f5f9),
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {

              Navigator.pop(context);

            }, icon: Icon(Icons.arrow_back,color: Colors.black,)),
        elevation: 0,
        centerTitle: false,
        backgroundColor: Colors.white,
        title: Text(
          "Profile",
          style: TextStyle(
              color: Colors.black,
              fontSize:ResponsiveInfo.isMobile(context)? 15 :18,
              fontFamily: 'poppins',
              fontWeight: FontWeight.bold),
        ),


      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Expanded(child: Stack(

          children: [

            Align(
          alignment: FractionalOffset.topCenter,
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,

          children: [

            Padding(padding:  EdgeInsets.all(ResponsiveInfo.isMobile(context)?12:14),


                child: CircleAvatar(
                  radius: 55.0,
                  backgroundImage:
                  NetworkImage('https://htmlstream.com/preview/unify-v2.6/assets/img-temp/400x450/img5.jpg'),
                  backgroundColor: Colors.transparent,
                )              ),

            Padding(padding:  EdgeInsets.all(ResponsiveInfo.isMobile(context)?8:12),

                child:  Text( 'Madhu varma', style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,
                    fontSize: ResponsiveInfo.isMobile(context)?16:19))

            ),

            Padding(padding:  EdgeInsets.all(ResponsiveInfo.isMobile(context)?8:12),

                child:  Text( 'madhu@gmail.com', style: TextStyle(color: Colors.black54,fontWeight: FontWeight.normal,
                    fontSize: ResponsiveInfo.isMobile(context)?14:17))

            ),

            Padding(padding: EdgeInsets.all(ResponsiveInfo.isMobile(context)?8:12),
                child: GestureDetector(
                  child: Container(
                    width: ResponsiveInfo.isMobile(context)? 120 : 150,
                      padding:  EdgeInsets.all(ResponsiveInfo.isMobile(context)? 6 : 9),

                      decoration: BoxDecoration(
                          color: Color(0xff2453a4),

                          border: Border.all(color: Color(0xff2453a4)),
                          borderRadius: BorderRadius.all(Radius.circular(ResponsiveInfo.isMobile(context)? 10 : 15))

                      ),


                      child: Stack(
    children: [
      Align(
    alignment: FractionalOffset.center,
    child:  Text( "Edit Profile",
      style: TextStyle(color: Colors.white,
          fontSize: ResponsiveInfo.isMobile(context)?12:14,fontWeight: FontWeight.normal),




    ) ,
    )

    ],

    )



                  ),
                  onTap: (){




                  },

                )



            )



          ],

        ) ,
      )
        ],
      )



          ,


            flex: 1,),


          Expanded(child: SingleChildScrollView(

    child: Column(

      children: [

        Padding(padding: EdgeInsets.all(ResponsiveInfo.isMobile(context)?8:12),

        child: Container(
          height:ResponsiveInfo.isMobile(context)? 60 : 75,
          decoration: BoxDecoration(
              color: Color(0xffffffff),
              border: Border.all(color: Color(0xffffffff)),
              borderRadius: BorderRadius.all(Radius.circular(ResponsiveInfo.isMobile(context)? 10 : 15))

          ),
          child: ListTile(
              leading:  Icon(Icons.settings,color: Colors.black,size: ResponsiveInfo.isMobile(context)?20:25),
              trailing: Icon(Icons.arrow_forward_ios_rounded,color: Colors.black,size: ResponsiveInfo.isMobile(context)?20:25,) ,
              title: Text("Settings",style: TextStyle(fontSize:ResponsiveInfo.isMobile(context)?13:17,color: Colors.black ),)),


        ),

        ),

        Padding(padding: EdgeInsets.all(ResponsiveInfo.isMobile(context)?8:12),

          child: Container(
            height:ResponsiveInfo.isMobile(context)? 60 : 75,
            decoration: BoxDecoration(
                color: Color(0xffffffff),
                border: Border.all(color: Color(0xffffffff)),
                borderRadius: BorderRadius.all(Radius.circular(ResponsiveInfo.isMobile(context)? 10 : 15))

            ),
            child: ListTile(
                leading:  Icon(Icons.perm_identity_sharp,color: Colors.black,size: ResponsiveInfo.isMobile(context)?20:25),
                trailing: Icon(Icons.arrow_forward_ios_rounded,color: Colors.black,size: ResponsiveInfo.isMobile(context)?20:25,) ,
                title: Text("Subscription details",style: TextStyle(fontSize:ResponsiveInfo.isMobile(context)?13:17,color: Colors.black ),)),


          ),

        ),

        Padding(padding: EdgeInsets.all(ResponsiveInfo.isMobile(context)?8:12),

          child: Container(
            height:ResponsiveInfo.isMobile(context)? 60 : 75,
            decoration: BoxDecoration(
                color: Color(0xffffffff),
                border: Border.all(color: Color(0xffffffff)),
                borderRadius: BorderRadius.all(Radius.circular(ResponsiveInfo.isMobile(context)? 10 : 15))

            ),
            child: ListTile(
                leading:  Icon(Icons.info_outline,color: Colors.black,size: ResponsiveInfo.isMobile(context)?20:25),
                trailing: Icon(Icons.arrow_forward_ios_rounded,color: Colors.black,size: ResponsiveInfo.isMobile(context)?20:25,) ,
                title: Text("FAQ",style: TextStyle(fontSize:ResponsiveInfo.isMobile(context)?13:17,color: Colors.black ),)),


          ),

        ),

        Padding(padding: EdgeInsets.all(ResponsiveInfo.isMobile(context)?8:12),

          child: Container(
            height:ResponsiveInfo.isMobile(context)? 60 : 75,
            decoration: BoxDecoration(
                color: Color(0xffffffff),
                border: Border.all(color: Color(0xffffffff)),
                borderRadius: BorderRadius.all(Radius.circular(ResponsiveInfo.isMobile(context)? 10 : 15))

            ),
            child: ListTile(
                leading:  Icon(Icons.exit_to_app,color: Colors.black,size: ResponsiveInfo.isMobile(context)?20:25),
                trailing: Icon(Icons.arrow_forward_ios_rounded,color: Colors.black,size: ResponsiveInfo.isMobile(context)?20:25,) ,
                title: Text("Logout",style: TextStyle(fontSize:ResponsiveInfo.isMobile(context)?13:17,color: Colors.black ),)),


          ),

        ),


        Padding(padding: EdgeInsets.all(ResponsiveInfo.isMobile(context)?8:12),

          child: Container(
            height:ResponsiveInfo.isMobile(context)? 60 : 75,
            decoration: BoxDecoration(
                color: Color(0xffffffff),
                border: Border.all(color: Color(0xffffffff)),
                borderRadius: BorderRadius.all(Radius.circular(ResponsiveInfo.isMobile(context)? 10 : 15))

            ),
            child: ListTile(
                leading:  Icon(Icons.delete,color: Colors.black,size: ResponsiveInfo.isMobile(context)?20:25),
                trailing: Icon(Icons.arrow_forward_ios_rounded,color: Colors.black,size: ResponsiveInfo.isMobile(context)?20:25,) ,
                title: Text("Delete Account",style: TextStyle(fontSize:ResponsiveInfo.isMobile(context)?13:17,color: Colors.black ),)),


          ),

        )







      ],

    ),
    )


          ,flex: 1,)



        ],

      ),





    );
  }
}
