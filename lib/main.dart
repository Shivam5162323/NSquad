import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:nsquad/report.dart';
import 'package:nsquad/signin.dart';
import 'package:nsquad/signup.dart';
import 'package:nsquad/trainer.dart';
import 'package:nsquad/view.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'adopt.dart';
import 'authHome.dart';
import 'dogram.dart';
import 'firebaseuser.dart';

var email;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  email = prefs.getString('email');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     title: 'Flutter Demo',
  //     debugShowCheckedModeBanner: false,
  //     theme: ThemeData(
  //
  //
  //       primarySwatch: Colors.blue,
  //       appBarTheme: AppBarTheme(
  //         color: Color(0xFFF272e38)
  //       ),
  //       canvasColor: Color(0xFFFe6d8e6)
  //     ),
  //     home: MyHomePage(),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      // value: AuthService.FirebaseUser,
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.blue,
            appBarTheme: AppBarTheme(color: Color(0xFFF272e38)),
            canvasColor: Color(0xFFFe6d8e6)),

        // themeMode: ThemeMode.dark,
        home: email == null ? AuthHomeScreen() : MyHomePage(),
      ),
    );
  }
}

class AuthHomeScreen extends StatelessWidget {
  const AuthHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/d2.jpg'), fit: BoxFit.cover),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                  padding: EdgeInsets.all(76),
                  decoration: BoxDecoration(
                    // color: Colors.black54,
                    // image: DecorationImage(
                    //     image: AssetImage('assets/images/newspaper.jpg'),
                    //     fit: BoxFit.contain),

                    borderRadius: BorderRadius.circular(18),
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  child: Column(
                    children: [
                      Image.asset('assets/images/d.png'),
                      Text(
                        'NSquad',
                        style: TextStyle(
                            fontFamily: 'Darker',
                            fontSize: 50,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  )),
              Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignInScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                        elevation: 18,
                        padding: EdgeInsets.symmetric(
                            horizontal: 75.0, vertical: 10.0),
                        backgroundColor: Colors.black54,
                        shape: StadiumBorder(
                            side: BorderSide(width: 2, color: Colors.white))),
                    child: Text('Sign in',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                        elevation: 18,
                        padding: EdgeInsets.symmetric(
                            horizontal: 75.0, vertical: 10.0),
                        backgroundColor: Colors.white70,
                        shape: StadiumBorder(side: BorderSide(width: 2))),
                    child: Text(
                      'Sign up',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 18),
                    child: Row(children: <Widget>[
                      Expanded(
                          child: Divider(
                        color: Colors.black,
                        thickness: 1.3,
                      )),
                      Text(
                        "  or  ",
                        style: TextStyle(color: Colors.black),
                      ),
                      Expanded(
                          child: Divider(
                        color: Colors.black,
                        thickness: 1.3,
                      )),
                    ]),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                        elevation: 18,
                        padding: EdgeInsets.symmetric(
                            horizontal: 75.0, vertical: 10.0),
                        backgroundColor: Colors.orange,
                        shape: StadiumBorder(side: BorderSide(width: 2))),
                    child: Text(
                      'Sign up as NGO',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _auth = FirebaseAuth.instance;

  var ttl;

  int _selectedIndex = 2;
  static List<Widget> _widgetOptions = <Widget>[
    //wids
    TrainerScreeen(),
    Adopt(),
    ReportInjuredDog(),
    ViewDogsScreen(),
    DogramScreen(),
  ];

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottom/Inset: false,
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(_selectedIndex==2?'Report':''),
        centerTitle: true,
        leading: IconButton(
            onPressed: () => _scaffoldKey.currentState?.openDrawer(),
            icon: Icon(Icons.view_headline_sharp)),

        // title: _selectedIndex==0?,

        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7)),
                      elevation: 16,
                      child: Container(
                        color: Color(0xFFF272e38),
                        padding: EdgeInsets.all(10),
                        child: ListView(
                          shrinkWrap: true,
                          children: <Widget>[
                            Column(
                              children: [
                                Card(
                                  color:Colors.black,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Flexible(
                                            child: Text(
                                                'Go Nirvana Foundation Mansarovar,Jaipur ',style: TextStyle(color: Colors.white))),
                                        TextButton(
                                            onPressed: () {
                                              launchUrlString("tel:+99364921507");
                                            },
                                            child: Text('+99364921507'))
                                      ],
                                    ),
                                  ),
                                ),




                                Card(
                                  color: Colors.black,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Flexible(
                                            child: Text(
                                                'Vc5 Ngo, Amer road,Jaipur ',style: TextStyle(color: Colors.white),)),
                                        TextButton(
                                            onPressed: () {
                                              launchUrlString("tel:07942684062");
                                            },
                                            child: Text('07942684062'))
                                      ],
                                    ),
                                  ),
                                ),






                                Card(
                                  color: Colors.black,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(

                                      children: [
                                        Flexible(
                                            child: Text(
                                                'Mahavir Ahinsa Sanskar Jagruti Sanstha vikhroli east, Mummbai ',style: TextStyle(color: Colors.white))),
                                        TextButton(
                                            onPressed: () {
                                              launchUrlString("tel:9819412567");
                                            },
                                            child: Text('9819412567'))
                                      ],
                                    ),
                                  ),
                                ),






                                Card(
                                  color: Colors.black,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Flexible(
                                            child: Text('Peta Indian Juhu, Mumbai ',style: TextStyle(color: Colors.white))),
                                        TextButton(
                                            onPressed: () {
                                              launchUrlString("tel:07942684591");
                                            },
                                            child: Text('07942684591'))
                                      ],
                                    ),
                                  ),
                                ),






                                Card(
                                  color: Colors.black,
                                  child: Padding(

                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Flexible(
                                            child: Text(
                                                ' Karuna Animal Shelter Hebbal, Bangalore ',style: TextStyle(color: Colors.white))),
                                        TextButton(
                                            onPressed: () {
                                              launchUrlString("tel:7947151500");
                                            },
                                            child: Text('7947151500'))
                                      ],
                                    ),
                                  ),
                                ),






                                Card(
                                  color: Colors.black,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Flexible(
                                            child: Text(
                                                'Karuna Animal Shelter, Jp Nagar 8th phase, Bangalore',style: TextStyle(color: Colors.white))),
                                        TextButton(
                                            onPressed: () {
                                              launchUrlString("tel:07947151547");
                                            },
                                            child: Text('07947151547'))
                                      ],
                                    ),
                                  ),
                                ),











                              ],
                            )
                          ], //launchUrl("tel:+99364921507");
                        ),
                      ),
                    );
                  },
                );
              },
              icon: Icon(Icons.call))
        ],
      ),

      body: Center(child: _widgetOptions.elementAt(_selectedIndex)),

      drawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'NSquad',
              style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'dyna'),
            ),
            Image.asset('assets/images/d.png'),
            Card(
              child: Container(
                width: double.infinity,
                child:
                    TextButton(onPressed: () {}, child: Text('Reported Dogs')),
              ),
            ),
            Card(
              child: Container(
                width: double.infinity,
                child: TextButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              backgroundColor: Color(0xFFF062121),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              title: Text(
                                'Are you sure you want to log out?',
                                style: TextStyle(color: Colors.white),
                              ),
                              icon: Icon(
                                Icons.output,
                                color: Colors.white,
                              ),
                              content: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  ElevatedButton(
                                    onPressed: () async {
                                      await _auth.signOut();
                                      // print(u1);
                                      SharedPreferences prefs =
                                          await SharedPreferences.getInstance();
                                      prefs.remove('email');
                                      // print(u1);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AuthHomeScreen()));
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          side: BorderSide(color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      backgroundColor: Colors.red,
                                    ),
                                    child: Text('Yes',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context, rootNavigator: true)
                                          .pop('dialog');
                                    },
                                    child: Text(
                                      'No',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          side: BorderSide(color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      backgroundColor: Colors.green,
                                    ),
                                  )
                                ],
                              ),
                            );
                          });
                    },
                    child: Text('Logout')),
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: Container(
        child: SnakeNavigationBar.color(
          backgroundColor: Color(0xFFF272e38),
          behaviour: SnakeBarBehaviour.floating,
          snakeShape: SnakeShape.indicator,
          snakeViewColor: Colors.white,
          selectedItemColor: SnakeShape.circle == SnakeShape.indicator
              ? Colors.black
              : Colors.white,
          unselectedItemColor: Colors.blueGrey,
          unselectedLabelStyle: TextStyle(fontSize: 0),
          showUnselectedLabels: true,
          showSelectedLabels: true,
          currentIndex: _selectedIndex,
          onTap: (index) => setState(() => _selectedIndex = index),
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.catching_pokemon_outlined),
                label: 'Manual',
                backgroundColor: Color(0xFFF07191f)),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.cube_box),
                label: 'Adopt',
                backgroundColor: Color(0xFFF07191f)),
            BottomNavigationBarItem(
                icon: Icon(Icons.report_gmailerrorred),
                label: 'Report',
                backgroundColor: Color(0xFFF07191f)),
            BottomNavigationBarItem(
                icon: Image.asset('assets/images/dog.png',
                    color: _selectedIndex == 2 ? Colors.white : Colors.grey,
                    fit: BoxFit.fitHeight,
                    width: 20),
                label: 'View',
                backgroundColor: Color(0xFFF07191f)),
            // BottomNavigationBarItem(icon: Image.asset('assets/images/cat.png',color: _selectedIndex==3?Colors.white:Colors.grey,fit: BoxFit.fitHeight,width: 20),label: 'Dogram',backgroundColor: Color(0xFFF07191f)),
          ],
        ),
      ),
    );
  }
}
