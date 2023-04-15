import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nsquad/ad.dart';
import 'package:nsquad/regforad.dart';

class Adopt extends StatefulWidget {
  const Adopt({Key? key}) : super(key: key);

  @override
  State<Adopt> createState() => _AdoptState();
}

class _AdoptState extends State<Adopt> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: 0,
        length: 2, child: Column(
      children: [
        Card(
        color: Color(0xFFF272e38),

      child: TabBar(





            unselectedLabelColor: Colors.grey,
            dividerColor: Colors.black,
            indicatorColor: Colors.black54,

            labelStyle: TextStyle(fontWeight: FontWeight.bold),
            unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),




            tabs: <Widget>[
              Tab(text: 'Adopt a dog'),
              Tab(text: 'Register for adoption'),
            ],
          ),
        ),


    Expanded(
    child: TabBarView(
    children: <Widget>[
    ad(),
    // Content of Tab 2
   regforad()
    ],
    ),)
      ],
    ));}}

