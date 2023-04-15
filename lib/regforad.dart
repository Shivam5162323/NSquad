// import 'package:flutter/cupertino.dart';
//
// class regforad extends StatefulWidget {
//
//   @override
//   State<regforad> createState() => _regforadState();
// }
//
// class _regforadState extends State<regforad> {
//   @override
//   Widget build(BuildContext context) {
//     return  Column(children: [
//       Text('adopt')
//     ],)    ;
//   }
// }







import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class regforad extends StatefulWidget {
  @override
  State<regforad> createState() => _regforadState();
}

class _regforadState extends State<regforad> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late DateTime _selectedDate = DateTime.now();
  final _owner = TextEditingController();
  final _user = TextEditingController();
  final _age = TextEditingController();
  final _desc = TextEditingController();
  final _phone = TextEditingController();
  final _name = TextEditingController();
  final _location = TextEditingController();
  final _i1 = TextEditingController();
  final _i2 = TextEditingController();
  final _i3 = TextEditingController();
  final _breed = TextEditingController();

  String generateDocumentId(String email) {
    // int randomNumber = random.nextInt(10000);
    String documentId = '$email$_counter';
    return documentId;
  }

  Future<void> addNews() {
    String documentId = generateDocumentId('abc@gmail.com');
    DocumentReference users =
    FirebaseFirestore.instance.collection('adoption').doc(documentId);

    // print(_drivelink);
    // Call the user's CollectionReference to add a new user
    return users
        .set({

      'age': _age.text, // Stokes and Sons
      'desc': _desc.text, // Stokes and Sons
      'date': _selectedDate, // 42
      'mail': _user.text,
      'owner': _owner.text,
      'counter': _counter,
      'breed': _breed.text,
      'location': _location.text,
      'i1': _i1.text,
      'i2': _i2.text,
      'i3': _i3.text
      // 42
    })
        .then((value) => print("dog Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  int _counter = 0;

  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  void _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter = prefs.getInt('counter') ?? 0;
    });
  }

  void _incrementCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter++;
      prefs.setInt('counter', _counter);
    });
  }

  void clearTextField() {
    _location.clear();
    _name.clear();
    _phone.clear();
    _i1.clear();
    _i2.clear();
    _i3.clear();
    _age.clear();
    _breed.clear();
    _owner.clear();

    _desc.clear();
  }



  String dropdownvalue = 'Male';

  // List of items in our dropdown menu
  var items = [
    'Male',
    'Female'
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.always,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [


                // Text('Breed',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                TextFormField(

                  decoration: InputDecoration(label: Text('Breed',style: TextStyle(color: Colors.black,fontSize: 18),),icon: Icon(Icons.label_important_outline,color: Colors.black,),labelStyle: TextStyle(fontSize: 18)),
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      overflow: null),
                  controller: _breed,
                  autofocus: true,
                  keyboardType: TextInputType.name,
                  // // decoration: InputDecoration(border: ),
                  // validator: (value) {
                  //   if (value == '') {
                  //     return 'This field cant be empty';
                  //   }
                  // },
                ),

                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                ),




                TextFormField(

                  decoration: InputDecoration(label: Text('Age (in months)',style: TextStyle(color: Colors.black,fontSize: 18),),icon: Icon(Icons.calendar_month_outlined,color: Colors.black,),labelStyle: TextStyle(fontSize: 18)),
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      overflow: null),
                  controller: _age,
                  keyboardType: TextInputType.name,
                  // // decoration: InputDecoration(border: ),
                  // validator: (value) {
                  //   if (value == '') {
                  //     return 'This field cant be empty';
                  //   }
                  // },
                ),

                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                ),
                
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.male),


                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,


                    children: [
                      Text('Gender',style: TextStyle(fontSize: 18),),
                      Container(margin: EdgeInsets.symmetric(horizontal: 60),),
                      DropdownButton(
                          value: dropdownvalue,


                        items: items.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),


                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownvalue = newValue!;
                          });
                        },

                      ),
                    ],
                  )
                    ,
                    Row()
                ],),


                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                ),


                TextFormField(

                  decoration: InputDecoration(label: Text('Name of Owner',style: TextStyle(color: Colors.black,fontSize: 18),),icon: Icon(Icons.person,color: Colors.black,),labelStyle: TextStyle(fontSize: 18)),
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      overflow: null),
                  controller: _owner,
                  keyboardType: TextInputType.name,
                  // // decoration: InputDecoration(border: ),
                  // validator: (value) {
                  //   if (value == '') {
                  //     return 'This field cant be empty';
                  //   }
                  // },
                ),

                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                ),








                TextFormField(
                  decoration: InputDecoration(label: Text('Phone No',style: TextStyle(color: Colors.black,fontSize: 18),),icon: Icon(Icons.phone,color: Colors.black,),labelStyle: TextStyle(fontSize: 18)),
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      overflow: null),
                  controller: _phone,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[0-9.,]')),
                  ],

                  // decoration: InputDecoration(border: ),
                  maxLength: 10,
                  maxLengthEnforcement: null,
                  buildCounter: (BuildContext context,
                      {int? currentLength,
                        int? maxLength,
                        bool? isFocused}) =>
                  null,

                  // validator: (value) {
                  //   if (value == '') {
                  //     return 'This field cant be empty';
                  //   }
                  // },
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                ),






                TextFormField(

                  decoration: InputDecoration(label: Text('Location',style: TextStyle(color: Colors.black,fontSize: 18),),icon: Icon(Icons.location_on_outlined,color: Colors.black,),labelStyle: TextStyle(fontSize: 18)),
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      overflow: null),
                  controller: _location,
                  keyboardType: TextInputType.name,
                  // // decoration: InputDecoration(border: ),
                  // validator: (value) {
                  //   if (value == '') {
                  //     return 'This field cant be empty';
                  //   }
                  // },
                ),








                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                ),



                TextFormField(

                  decoration: InputDecoration(label: Text('Dog Image Link 1',style: TextStyle(color: Colors.black,fontSize: 18),),icon: Icon(Icons.photo_size_select_actual_outlined,color: Colors.black,),labelStyle: TextStyle(fontSize: 18)),
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      overflow: null),
                  controller: _i1,
                  keyboardType: TextInputType.name,
                  // // decoration: InputDecoration(border: ),
                  // validator: (value) {
                  //   if (value == '') {
                  //     return 'This field cant be empty';
                  //   }
                  // },
                ),



                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                ),




                TextFormField(

                  decoration: InputDecoration(label: Text('Dog Image Link 2',style: TextStyle(color: Colors.black,fontSize: 18),),icon: Icon(Icons.photo_size_select_actual_outlined,color: Colors.black,),labelStyle: TextStyle(fontSize: 18)),
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      overflow: null),
                  controller: _i2,
                  keyboardType: TextInputType.name,
                  // // decoration: InputDecoration(border: ),
                  // validator: (value) {
                  //   if (value == '') {
                  //     return 'This field cant be empty';
                  //   }
                  // },
                ),



                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                ),

                TextFormField(

                  decoration: InputDecoration(label: Text('Dog Image Link 3',style: TextStyle(color: Colors.black,fontSize: 18),),icon: Icon(Icons.photo_size_select_actual_outlined,color: Colors.black,),labelStyle: TextStyle(fontSize: 18)),
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      overflow: null),
                  controller: _i3,
                  keyboardType: TextInputType.name,
                  // // decoration: InputDecoration(border: ),
                  // validator: (value) {
                  //   if (value == '') {
                  //     return 'This field cant be empty';
                  //   }
                  // },
                ),



                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                ),





                // Text('Write somethig about your dog...'),
                // Card(
                //   // shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(7)),side: BorderSide(width: 1,color: Colors.white54)),
                //
                //   // color: Colors.white12,
                //   child: Padding(
                //     padding: const EdgeInsets.symmetric(horizontal: 7),
                //     child: TextFormField(
                //       // validator: (value) {
                //       //   if (value == '') {
                //       //     return 'This field cant be empty';
                //       //   }
                //       // },
                //
                //       controller: _desc,
                //       // minLines: 1,
                //
                //       style: TextStyle(color: Colors.black),
                //       cursorColor: Colors.white54,
                //       textCapitalization: TextCapitalization.sentences,
                //       // dragStartBehavior: DragStartBehavior.start,
                //
                //       autofocus: false,
                //       // focusNode: _focusnode,
                //       maxLines: null,
                //       // controller: _desc,
                //
                //       // keyboardType: TextInputType.text,
                //     ),
                //   ),
                // ),












                TextFormField(

                  decoration: InputDecoration(label: Text('Tell us about your dog',style: TextStyle(color: Colors.black,fontSize: 18),),icon: Icon(Icons.location_on_outlined,color: Colors.black,),labelStyle: TextStyle(fontSize: 18)),
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      overflow: null),
                  controller: _desc,
                  maxLines: null,
                  keyboardType: TextInputType.name,
                  textCapitalization: TextCapitalization.sentences,
                        minLines: 1,
                  // autofocus: true,
                  textInputAction: TextInputAction.newline,


                  // dragStartBehavior: DragStartBehavior.start,
                  // // decoration: InputDecoration(border: ),
                  // validator: (value) {
                  //   if (value == '') {
                  //     return 'This field cant be empty';
                  //   }
                  // },
                ),



                Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                ),

                // SizedBox(
                //   width: double.infinity,
                //   child: ElevatedButton(
                //     onPressed: () async {
                //
                //       addNews();
                //       setState(() {
                //         // _counter++;
                //         _incrementCounter();
                //       });
                //     },
                //     child: Text('Submit report'),
                //     //     child: loginEmailPasswordButon,
                //   ),
                // ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(),
                        onPressed: () {
                          setState(() {
                            // addNews();
                            // clearTextField();

                            showDialog(
                                context: context,
                                builder: (context) {
                                  return Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 20,
                                        vertical:
                                        MediaQuery.of(context).size.height *
                                            0.4),
                                    child: Dialog(

                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(7)),
                                      insetPadding: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 8),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 8),
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              'Are you sure u want to submit this information for dog adoption?',
                                              style: TextStyle(color: Colors.white),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                              children: [
                                                ElevatedButton(
                                                  onPressed: () {
                                                    // addNews();
                                                    // clearTextField();
                                                    setState(() {
                                                      addNews();
                                                      setState(() {
                                                        _incrementCounter();
                                                      });
                                                      clearTextField();
                                                      _incrementCounter();

                                                      Navigator.pop(context);

                                                      showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return GestureDetector(
                                                              child: Container(
                                                                margin: EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                    40,
                                                                    vertical:
                                                                    300),
                                                                child: Dialog(
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                          7)),
                                                                  insetPadding: EdgeInsets
                                                                      .symmetric(
                                                                      vertical:
                                                                      10,
                                                                      horizontal:
                                                                      8),
                                                                  child: Padding(
                                                                    padding: EdgeInsets
                                                                        .symmetric(
                                                                        vertical:
                                                                        10,
                                                                        horizontal:
                                                                        8),
                                                                    child: Column(
                                                                      mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceEvenly,
                                                                      children: [
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                          children: [
                                                                            Icon(
                                                                              Icons
                                                                                  .done_all,
                                                                              color:
                                                                              Colors.lightGreen,
                                                                              size:
                                                                              23,
                                                                            ),
                                                                            Text(
                                                                              ' News Submitted',
                                                                              style:
                                                                              TextStyle(fontSize: 18,color: Colors.white),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        Text(
                                                                            'Thank you for your patience!',style: TextStyle(color: Colors.white),),
                                                                        Text(
                                                                            'Info of your dog is uploaded to database..',style: TextStyle(color: Colors.white),)
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  elevation: 10,
                                                                  backgroundColor:
                                                                  Colors
                                                                      .black54,
                                                                  alignment:
                                                                  Alignment
                                                                      .center,
                                                                ),
                                                              ),
                                                            );
                                                          });
                                                    });
                                                  },
                                                  child: Text('Yes'),
                                                ),
                                                ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text('No')),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      elevation: 10,
                                      backgroundColor: Colors.black54,
                                      alignment: Alignment.center,
                                    ),
                                  );
                                });
                          });
                        },
                        child: Text('Submit Dog info')),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

