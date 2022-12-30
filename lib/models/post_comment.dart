
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PostComment{

  String content;
  // String username;
  // String email;
  // String userPhotoUrl;
  String uid;
  String postId;
  late DateTime publishedAt;
  final List likes;
  final List dislikes;

  PostComment({
    required this.content,
    // required this.username,
    // required this.userPhotoUrl,
    // required this.email,
    required this.uid,
    required this.postId,
    this.dislikes=const [],
    this.likes=const [],
    required this.publishedAt

  }){
      // publishedAt=DateTime.now();
  }



  Map<String, dynamic> toJson(){
    return {
      "content":content,
      // "username":username,
      // "userPhotoUrl": userPhotoUrl,
      // "email":email,
      "uid": uid,
      "postId":postId,
      "likes":likes,
      "dislikes": dislikes,
      "publishedAt": publishedAt,

    };
  }

  
  PostComment fromSnap(DocumentSnapshot snapshot){
    var snap=snapshot.data() as Map<String, dynamic>;
    return PostComment(
      content: snap["content"],
      //  username: snap["username"], 
      //  userPhotoUrl: snap["userPhotoUrl"],
        // email: snap["email"], 
        uid: snap["uid"], 
        postId: snap["postId"],
        likes:snap['likes'],
        dislikes:snap['dislikes'],
        publishedAt:snap['publishedAt']

    );
  }
  
  
}