import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_instagram_clone/models/post_comment.dart';

class Comment extends StatefulWidget {
  PostComment postComment;
  Comment({Key? key,required PostComment this.postComment}) : super(key: key);

  @override
  State<Comment> createState() => _CommentState();
}

class _CommentState extends State<Comment> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Text("data"),
    );
  }
}