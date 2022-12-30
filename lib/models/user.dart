import 'package:cloud_firestore/cloud_firestore.dart';

class User{

  final String username;
  final String email;
  final String uid;
  final String bio;
  final String photoUrl;
  final List following;
  final List followers;

  User.nullable({this.username="", this.email="", this.uid="", this.bio="",this.photoUrl="", this.followers=const [],this.following=const []});
  User({required this.uid,required this.username,required this.email, required this.bio,required this.photoUrl,required this.followers, required this.following});

  Map<String, dynamic> toJson(){
    return {
      'uid': uid,
      'username':username,
      'email':email,
      'photoUrl':photoUrl,
      'bio':bio,
      'following': following,
      'followers': followers,
    };
  } 

  static User fromSnap(DocumentSnapshot snap){
    
    var snapData=snap.data() as Map<String,dynamic>; 

    return User(
      uid:snapData['uid'],
      username: snapData['username'],
      email: snapData['email'], 
      bio: snapData['bio'], 
      photoUrl: snapData['photoUrl'], 
      followers: snapData['following'],
      following: snapData['following']
    );
  } 

}
