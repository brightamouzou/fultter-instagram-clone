import 'package:cloud_firestore/cloud_firestore.dart';

class Post{
  String photoUrl;
  String email;
  String username;
  String uid;
  String postId;
  String description;
  final String userPhotoUrl;
  final DateTime datePublished;
  List  likes = [];
  
  Post({
    required String this.postId,
    required String this.userPhotoUrl,
    required String this.username,
    required String this.email,
    required String this.uid,
    required String this.description,
    required DateTime this.datePublished,
    List this.likes=const [],
    String this.photoUrl="",
  });

   Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'userPhotoUrl': userPhotoUrl,
      'description': description,
      'photoUrl': photoUrl,
      'datePublished': datePublished,
      'postId': postId,
      'likes': likes,
      'email':email,
      "username":username
    };
    
  } 

  static Post fromSnap(DocumentSnapshot snap){
    
    var snapData=snap.data() as Map<String,dynamic>; 

    return Post(
      uid: snapData["uid"],
      userPhotoUrl: snapData["userPhotoUrl"],
      email: snapData["email"],
      username: snapData["username"],
      postId: snapData["postId"],
      description: snapData["description"],
      photoUrl: snapData["photoUrl"],
      datePublished: snapData["datePublished"],
      likes: snapData["likes"],
    );
  }
  
}