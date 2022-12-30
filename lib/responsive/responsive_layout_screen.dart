import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/providers/user_provider.dart';
import 'package:flutter_instagram_clone/utils/global_variables.dart';
import 'package:provider/provider.dart';
class ResponsiveLayout extends StatefulWidget {
    final Widget webScreenLayout;
    final Widget mobileScreenLayout;
    const ResponsiveLayout({Key? key, required this.mobileScreenLayout, required this.webScreenLayout}):super(key: key);

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
  @override
  void initState(){
    super.initState();
    addData();
  }

  void addData()async {
    UserProvider _userProvider=Provider.of<UserProvider>(context,listen:false);
    await _userProvider.refreshUser();
  }
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if(constraints.maxWidth>WEB_SCREEN_SIZE){
          //web screen
          return widget.webScreenLayout;
        }else{
          //mobile screen
          return widget.mobileScreenLayout;
        }
      }
    );
  }
}