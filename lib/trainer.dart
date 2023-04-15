import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TrainerScreeen extends StatefulWidget {
  const TrainerScreeen({Key? key}) : super(key: key);

  @override
  State<TrainerScreeen> createState() => _TrainerScreeenState();
}

class _TrainerScreeenState extends State<TrainerScreeen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const ExpansionTile(
                title: Text('Common Behaviors of dogs'),
                // subtitle: Text('Aggressio'),
                children: <Widget>[
                  ListTile(title: Text('Aggresion'),),
                  ListTile(title: Text('Separation anxiety'),),
                  ListTile(title: Text('Excessive barking'),),
                  ListTile(title: Text('Chewing and destructive behavior'),),
                  ListTile(title: Text('Jumping on people'),),
                  ListTile(title: Text('Pulling on leash'),),

                ],
              ),

              ExpansionTile(
                title: Text('Doggo Training'),
                // subtitle: Text('Aggressio'),

                children: <Widget>[
                  ExpansionTile(title: Text('How to sit'),

                    children: [
                      ListTile(title: Text('Aggresion'),),
                    ],
                  ),


                  ExpansionTile(title: Text('How to shake hand'),

                    children: [
                      ListTile(title: Text('Aggresion'),),
                    ],
                  ),


                  ExpansionTile(title: Text('To not jump on random people'),

                    children: [
                      ListTile(title: Text('Aggresion'),),
                    ],
                  ),



                ],
              )
            ]
        ),
      ),
    );
  }
}