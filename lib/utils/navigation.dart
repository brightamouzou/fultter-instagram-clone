import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class CustomNavigation extends StatelessWidget {
  final StatefulWidget  _target;
  const CustomNavigation(this._target,{super.key});

  @override
  Widget build(BuildContext context) {
    return _target;
  }
}

 navigationReplace(StatefulWidget target, BuildContext initialContext){

      // add your code here.
      Navigator.of(initialContext)
          .pushReplacement(MaterialPageRoute(builder: (context) => target));
}

navigationPush(StatefulWidget target, BuildContext initialContext){

    // add your code here.

  


}
