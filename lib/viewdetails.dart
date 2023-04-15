import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ViewDetails extends StatelessWidget {
  String url;
  var date;
  String desc;
  String name;
  var phone;
  String location;


  ViewDetails(this.url,this.date,this.desc,this.name,this.phone,this.location);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Container(
            padding: EdgeInsets.all(30),
            child: Image.network(url,
              errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {return Container();},
              fit: BoxFit.cover,),
          ),

          Container(
            margin: EdgeInsets.symmetric(vertical: 15,horizontal: 20),

            child: Row(
              // mainAxisAlignment: MainAxisAlignment.center,


              children: [
                Icon(Icons.person,size: 25,color: Colors.white,),

                Text(' ',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                Text(name,style: TextStyle(fontSize: 18,color: Colors.white),),
              ],
            ),),


            Container(
              margin: EdgeInsets.symmetric(vertical: 15,horizontal: 20),

              child: Flexible(
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    Icon(Icons.location_on_outlined,size: 25,color: Colors.white,),
                    Text(' ',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),

                    // Text(' Location : ',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                    Flexible(child: Text(location,style: TextStyle(fontSize: 18,color: Colors.white),))


                  ],
                ),
              ),
            ),
          


          Container(
            margin: EdgeInsets.symmetric(vertical: 15,horizontal: 20),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.edit_note_rounded,size: 24,color: Colors.white,),
                Text(' ',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                Expanded(child: Text(desc,style: TextStyle(fontSize: 16,color: Colors.white),))


              ],
            ),
          ),


          Container(
            margin: EdgeInsets.symmetric(vertical: 5,horizontal: 45),

            child: Text(desc),
          ),






        ],),
      ),
    );
  }
}
