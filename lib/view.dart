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



class ViewDogsScreen extends StatefulWidget {
  @override
  State<ViewDogsScreen> createState() => _ViewDogsScreenState();
}

class _ViewDogsScreenState extends State<ViewDogsScreen> {
  Future<List<Map<String, dynamic>>>? _futureData;

  @override
  void initState() {
    super.initState();
    _futureData = getAllDataFromCollection('report');
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
              final name = data['name'] ?? '';
              final description = data['desc'] ?? '';
              final date = data['date'] ?? '';
              final location = data['location'] ?? '';
              final phone = data['phone'] ?? '';
              final url = data['url'] ?? '';
              // final formlink = data['formlink'] ?? '';
              final reportcode=data['reportcode'] ?? '';
              // final details= data['details'] ?? '';






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

                        // Container(

                        //   child: url.isEmpty ? null :Stack(
                        //       children: [Image.network(url,
                        //         errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                        //           return Container();
                        //
                        //         },
                        //
                        //         fit: BoxFit.cover,),
                        //         // Align(
                        //         //   alignment: Alignment.topRight,
                        //         //   child: Container(
                        //         //     padding: EdgeInsets.all(8),
                        //         //     child: Text(
                        //         //       // date,
                        //         //       "",
                        //         //       style: TextStyle(
                        //         //           color: Colors.grey,
                        //         //           fontSize: 12,
                        //         //           fontWeight: FontWeight.bold),
                        //         //     ),
                        //         //   ),
                        //         // ),
                        //       ]
                        //
                        //   ),
                        //url,
                        //
                        //
                        //                                 ,),
                        // ),



                        ListTile(
                          leading: url==''?

                          ClipOval(
                            child: CircleAvatar(
                              radius: 40,
                              backgroundImage: NetworkImage(
                                // scale: double.infinity,

                                  'https://as1.ftcdn.net/v2/jpg/05/91/21/40/1000_F_591214013_4f9zJwhwtwc1ystqdaDgEUCrAcGYovy8.jpg'),
                            ),
                          ):ClipOval(
                            child: CircleAvatar(
                              radius: 40,
                              backgroundImage: NetworkImage(
                                // scale: double.infinity,

                                  url),
                            ),
                          ),
                          tileColor: Color(0xFFF272e38),
                          shape: RoundedRectangleBorder(

                            borderRadius: BorderRadius.circular(7),

                          ),
                          onTap: (){

                          },

                          title: Text(
                            name,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          //         trailing: url.isEmpty ? Text(
                          // // date,
                          //
                          // style: TextStyle(
                          // color: Colors.grey,
                          // fontSize: 12,
                          // fontWeight: FontWeight.bold),
                          // ):null,
                          subtitle: Text(
                            location,
                            style: TextStyle(color: Colors.white),
                          ),
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
