import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/screens/add_post_screen.dart';
import 'package:flutter_instagram_clone/screens/feed_screen.dart';
import 'package:flutter_instagram_clone/widgets/post_card.dart';

const WEB_SCREEN_SIZE = 600;

const homeScreenItems = [
  // Text('home'),

  FeedScreen(),
  Text('search'),
  AddPostScreen(),
  Text('favortites'),
  Text('profile'),
];
 