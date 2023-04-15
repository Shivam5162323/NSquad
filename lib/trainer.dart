import 'package:flutter/cupertino.dart';

class TrainerScreeen extends StatefulWidget {
  const TrainerScreeen({Key? key}) : super(key: key);

  @override
  State<TrainerScreeen> createState() => _TrainerScreeenState();
}

class _TrainerScreeenState extends State<TrainerScreeen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Text('trainer'),
      ),
    );
  }
}
