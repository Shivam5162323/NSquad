import 'package:flutter/cupertino.dart';
import 'package:nsquad/main.dart';
import 'package:provider/provider.dart';

import './firebaseuser.dart';
import './handler.dart';

class Wrapper extends StatelessWidget{

  @override
  Widget build(BuildContext context) {

    final user =  Provider.of<FirebaseUser?>(context);

    if(user == null)
    {
      return Handler();
    }else
    {
      return MyHomePage();
    }

  }
}
