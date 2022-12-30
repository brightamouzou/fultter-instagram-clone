
import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/utils/color.dart';

class FormValidationButton extends StatelessWidget{

  bool isLoading=false;
  FormValidationButton(this.isLoading);
  

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return isLoading? Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          alignment: Alignment.center,
          decoration: const ShapeDecoration(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(4))),
            color: blueColor,
          ),
          child: const CircularProgressIndicator(color: primaryColor,),
          ):Container(  
            padding: const EdgeInsets.symmetric(vertical: 12),
            alignment: Alignment.center,
            decoration: const ShapeDecoration(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4))),
              color: blueColor,
            ),
            child: const Text("Se connecter"),
          );

} 
}