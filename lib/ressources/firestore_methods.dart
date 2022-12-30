import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_instagram_clone/models/post_comment.dart';
import 'package:flutter_instagram_clone/widgets/comment.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_instagram_clone/models/post.dart';
import 'package:flutter_instagram_clone/models/user.dart';
import 'package:flutter_instagram_clone/ressources/auth_methods.dart';
import 'package:flutter_instagram_clone/ressources/storage_methods.dart';

class FirestoreMethods {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // User _user=AuthMethods().getUserDetails();

  Future<String> uploadPost(
      {required String photoUrl,
      required String email,
      required String uid,
      required String username,
      required String description,
      required String userPhotoUrl,
      Uint8List? file}) async {
    String res = "Some error occured while uploading the post";

    try {
      String photoUrl = "";
      if (file != null) {
        photoUrl =
            await StorageMethods().uploadImageStorage("posts", file, true);
      }

      String postId = const Uuid().v1();
      Post newPost = Post(
          email: email,
          userPhotoUrl: userPhotoUrl,
          username: username,
          postId: postId,
          uid: uid,
          description: description,
          photoUrl: photoUrl,
          datePublished: DateTime.now());

      await _firestore.collection('posts').doc(postId).set(newPost.toJson());

      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<void> likePost(String postId, String uid, List likes) async {
    try {
      if (likes.contains(uid)) {
        await _firestore.collection('posts').doc(postId).update({
          "likes": FieldValue.arrayRemove([uid])
        });
      } else {
        await _firestore.collection('posts').doc(postId).update({
          "likes": FieldValue.arrayUnion([uid])
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<String> commentPost(String postId, String uid, String description,
      List likes, List dislikes) async {
    String commentId = Uuid().v1();
    String res = "Commented posted succefully";

    try {
      PostComment newComment = PostComment(
          content: description,
          uid: uid,
          likes: likes,
          dislikes: dislikes,
          postId: postId,
          publishedAt: DateTime.now());

      _firestore
          .collection('posts')
          .doc(postId)
          .collection('comments')
          .doc(commentId)
          .set({...newComment.toJson()});
    } catch (e) {
      res = "Oh! Something went wrong!";
    }

    return res;
  }
}
