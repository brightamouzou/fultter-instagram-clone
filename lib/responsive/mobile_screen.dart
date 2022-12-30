import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_instagram_clone/providers/user_provider.dart';
import 'package:flutter_instagram_clone/utils/color.dart';
import 'package:flutter_instagram_clone/utils/global_variables.dart';
import 'package:provider/provider.dart';
import 'package:flutter_instagram_clone/models/user.dart' as models;

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  _MobileScreenLayoutState createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  late PageController pageController;
  var _page = 0;
  var _pagesIcons = [
    Icons.home,
    Icons.search,
    Icons.add_circle,
    Icons.favorite,
    Icons.person,
  ];

  void nagiateToWantedPage(int page) {
    pageController.jumpToPage(page);
  }

  onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    @override
    void dispose() {
      super.dispose();
      pageController.dispose();
    }


    models.User user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      body: PageView(
        children: homeScreenItems,
        controller: pageController,
        onPageChanged: onPageChanged,
        allowImplicitScrolling: true,
        physics: const NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: mobileBackgroundColor,
        items: [
          ..._pagesIcons.map((icon) => (BottomNavigationBarItem(
              icon: Icon(
                icon,
                color: _page == _pagesIcons.indexOf(icon)
                    ? primaryColor
                    : secondaryColor,
              ),
              label: '',
        ))),
        ],
        onTap:  nagiateToWantedPage,
        height: 55,
      ),
    );
  }
}
