
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';






Future<List<Map<String, dynamic>>> getAllDataFromCollection(String collectionPath) async {
  final QuerySnapshot snapshot =
  await FirebaseFirestore.instance.collection(collectionPath).get();

  if (snapshot.docs.isNotEmpty) {
    // Create a list to hold the extracted data
    final List<Map<String, dynamic>> dataList = [];

    // Iterate through all documents in the collection
    snapshot.docs.forEach((doc) {
      // Extract the document data and add it to the list
      final data = doc.data();
      dataList.add(data as Map<String, dynamic>);
    });

    return dataList;
  } else {
    print('No data found in the collection.');
    return [];
  }
}


class DogramScreen extends StatefulWidget {
  const DogramScreen({Key? key}) : super(key: key);

  @override
  State<DogramScreen> createState() => _DogramScreenState();
}

class _DogramScreenState extends State<DogramScreen> {

  Future<List<Map<String, dynamic>>>? _futureData;

  @override
  void initState() {
    super.initState();
    _futureData = getAllDataFromCollection('dogram');
  }


  @override
  Widget build(BuildContext context) {

    setState(() {

    });

    Future<void> _refreshData() async {
      await Future.delayed(Duration(seconds: 2));
      setState(() {
        _futureData;
      });
    }


    return RefreshIndicator(
      onRefresh: _refreshData,
      child: FutureBuilder<List<Map<String, dynamic>>>(
        future: _futureData,
        builder: (BuildContext context,
            AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {

            // Create a list of widgets from the extracted data
            final List<Widget> widgets = snapshot.data!.map((data) {
              // Check if the 'title' and 'description' fields are null
              final user = data['mail'] ?? '';
             final url = data['url'] ?? '';
             final caption = data['Caption'] ?? '';







              return Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  // color: Color(0xFFF062121),
                  // color: Colors.pink,
                  child:
                  InkWell(
                    onTap: (){
                      // selectednews=title;
                      //
                      // Map<String, dynamic> map ;
                      // DateTime dt = (map['timestamp'] as Timestamp).toDate();
                      // print(dt);

                    },
                    child: Column(
                      children: [

                        Container(

                          child: url.isEmpty ? null :Stack(
                              children: [Image.network(url,
                                errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                                  return Container();

                                },

                                fit: BoxFit.cover,),

                              ]

                          ),



                        ),



                        ListTile(

                          tileColor: Color(0xFFF272e38),
                          shape: RoundedRectangleBorder(

                            borderRadius: BorderRadius.vertical(bottom: Radius.circular(7)),

                          ),
                          onTap: (){

                          },

                          title: Text(
                            caption,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),

                          // subtitle: Text(
                          //   location,
                          //   style: TextStyle(color: Colors.white),
                          // ),

                        ),

                      ],
                    ),
                  )
              );
            }).toList();

            return ListView(
              children: widgets,
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return Center(
              child: Text('No data found.'),
            );
          }
        },
      ),
    );
  }
}

