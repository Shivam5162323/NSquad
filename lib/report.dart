import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReportInjuredDog extends StatefulWidget {
  @override
  State<ReportInjuredDog> createState() => _ReportInjuredDogState();
}

class _ReportInjuredDogState extends State<ReportInjuredDog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late DateTime _selectedDate = DateTime.now();
  final _user = TextEditingController();
  final _desc = TextEditingController();
  final _phone = TextEditingController();
  final _name = TextEditingController();
  final _location = TextEditingController();
  final _url = TextEditingController();

  String generateDocumentId(String email) {
    // int randomNumber = random.nextInt(10000);
    String documentId = '$email$_counter';
    return documentId;
  }

  Future<void> addNews() {
    String documentId = generateDocumentId('abc@gmail.com');
    DocumentReference users =
        FirebaseFirestore.instance.collection('report').doc(documentId);

    // print(_drivelink);
    // Call the user's CollectionReference to add a new user
    return users
        .set({
          'desc': _desc.text, // Stokes and Sons
          'date': _selectedDate, // 42
          'mail': _user.text,
          'counter': _counter,
          'name': _name.text,
          'location': _location.text,
          'url': _url.text
          // 42
        })
        .then((value) => print("User Added"))
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
    _url.clear();
    // _newsname.clear();
    _desc.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 35),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.always,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Name of user'),
                Card(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 7),
                    child: TextFormField(
                      decoration: InputDecoration(border: InputBorder.none),
                      controller: _name,
                      validator: (value) {
                        if (value == '') {
                          return 'This field cant be empty';
                        }
                      },
                    ),
                  ),
                ),

                Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                ),

                Text('Phone number'),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 7),
                    child: TextFormField(
                      decoration: InputDecoration(border: InputBorder.none),

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

                      validator: (value) {
                        if (value == '') {
                          return 'This field cant be empty';
                        }
                      },
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                ),

                Text('Location'),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 7),
                    child: TextFormField(
                      decoration: InputDecoration(border: InputBorder.none),

                      controller: _location,
                      keyboardType: TextInputType.name,
                      // decoration: InputDecoration(border: ),
                      validator: (value) {
                        if (value == '') {
                          return 'This field cant be empty';
                        }
                      },
                    ),
                  ),
                ),

                Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                ),

                Text('Image link'),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 7),
                    child: TextFormField(
                      decoration: InputDecoration(border: InputBorder.none),

                      controller: _url,
                      keyboardType: TextInputType.name,
                      // decoration: InputDecoration(border: ),
                      validator: (value) {
                        if (value == null) {
                          return 'This field cant be empty';
                        }
                      },
                    ),
                  ),
                ),

                Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                ),

                Text('Describe the issue'),
                Card(
                  // shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(7)),side: BorderSide(width: 1,color: Colors.white54)),

                  // color: Colors.white12,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 7),
                    child: TextFormField(
                      validator: (value) {
                        if (value == '') {
                          return 'This field cant be empty';
                        }
                      },

                      controller: _desc,
                      // minLines: 1,
                      decoration: const InputDecoration(
                          hintText: 'Describe the issue.....',
                          // labelText: 'Description:',
                          hintStyle: TextStyle(color: Colors.grey)),
                      style: TextStyle(color: Colors.black),
                      cursorColor: Colors.white54,
                      textCapitalization: TextCapitalization.sentences,
                      // dragStartBehavior: DragStartBehavior.start,

                      autofocus: false,
                      // focusNode: _focusnode,
                      maxLines: null,
                      // controller: _desc,

                      // keyboardType: TextInputType.text,
                    ),
                  ),
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

                ElevatedButton(
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
                                          'Are you sure u want to submit this news?',
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
                                                                              TextStyle(fontSize: 18),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Text(
                                                                        'Thank you for your patience!'),
                                                                    Text(
                                                                        'Keep checking your mail for further contact')
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
                    child: Text('Submit issue')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
