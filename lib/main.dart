import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:nsquad/report.dart';
import 'package:nsquad/signin.dart';
import 'package:nsquad/trainer.dart';
import 'package:nsquad/view.dart';

import 'adopt.dart';
import 'dogram.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(


        primarySwatch: Colors.blue,
        appBarTheme: AppBarTheme(
          color: Color(0xFFF272e38)
        ),
        canvasColor: Color(0xFFFe6d8e6)
      ),
      home: MyHomePage(),
    );
  }
}




class MyHomePage extends StatefulWidget {


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {



  int _selectedIndex = 1;
  static  List<Widget> _widgetOptions = <Widget>[
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
        leading: IconButton(onPressed: ()=> _scaffoldKey.currentState?.openDrawer()

            ,icon :Icon(Icons.view_headline_sharp)),

        actions: [IconButton(onPressed: (){}, icon: Icon(Icons.message_outlined))],

      ),

      body:Center(child: _widgetOptions.elementAt(_selectedIndex)),

      drawer: Drawer(

      ),


      bottomNavigationBar: Container(

        child: SnakeNavigationBar.color(
          backgroundColor: Color(0xFFF272e38),
          behaviour: SnakeBarBehaviour.floating,
          snakeShape: SnakeShape.indicator,


          snakeViewColor: Colors.white,
          selectedItemColor: SnakeShape.circle == SnakeShape.indicator ? Colors.black: Colors.white,
          unselectedItemColor: Colors.blueGrey,
          unselectedLabelStyle: TextStyle(fontSize: 0),


          showUnselectedLabels: true,
          showSelectedLabels: true,


          currentIndex: _selectedIndex,
          onTap: (index) => setState(() => _selectedIndex = index),
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.catching_pokemon_outlined),label: 'Dog Manual',backgroundColor: Color(0xFFF07191f)),
            BottomNavigationBarItem(icon: Icon(CupertinoIcons.cube_box),label: 'Adopt',backgroundColor: Color(0xFFF07191f)),
            BottomNavigationBarItem(icon: Icon(Icons.report_gmailerrorred),label: 'Report',backgroundColor: Color(0xFFF07191f)),
            BottomNavigationBarItem(icon: Image.asset('assets/images/dog.png',color: _selectedIndex==2?Colors.white:Colors.grey,fit: BoxFit.fitHeight,width: 20),label: 'View',backgroundColor: Color(0xFFF07191f)),
            BottomNavigationBarItem(icon: Image.asset('assets/images/cat.png',color: _selectedIndex==3?Colors.white:Colors.grey,fit: BoxFit.fitHeight,width: 20),label: 'Dogram',backgroundColor: Color(0xFFF07191f)),
          ],
        ),
      ),
    );
  }
}



















