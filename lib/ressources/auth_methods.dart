import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/models/user.dart' as model;
import 'package:flutter_instagram_clone/ressources/storage_methods.dart';

class AuthMethods{
  final FirebaseAuth _auth=FirebaseAuth.instance;
  final FirebaseFirestore _firestore=FirebaseFirestore.instance;

  String _trimedString(String str){
    return str.trim();
  }

  Future<model.User> getUserDetails() async{
    User currentUser=_auth.currentUser!;

    DocumentSnapshot snap=await FirebaseFirestore.instance.collection('users').doc(currentUser.uid).get();
    return model.User.fromSnap(snap);

  }

  Future<String> signupUser(
  {
    required String email, 
    required String password, 
    required String username, 
    required String bio, 
    required Uint8List file, 
  }
  )async{

    String res="Somme error occured !";

    try{ 
      print('\n\n');
      if(_trimedString(email).isNotEmpty && password.isNotEmpty && bio.isNotEmpty && file!=null){
        //registrer user
        UserCredential cred=await _auth.createUserWithEmailAndPassword(email: email, password: password);
        // print (cred.user!.uid);

        String photoUrl=await StorageMethods().uploadImageStorage("profilePictures", file, false);

        model.User user= model.User(
            uid:cred.user!.uid,
            username:username,
            email:email,
            bio:bio,
            following:[],
            followers:[],
            photoUrl:photoUrl
        );
        _firestore.collection("users").doc(cred.user!.uid).set(
          user.toJson()
        );
      res="success";
      }else{
        //
      }
    }on FirebaseAuthException catch (err){
      //
      res=err.toString();
      
    }catch(err){
      res=err.toString();
      print(err.toString());
      return res;

    }
      return res;

  }
  Future<String> loginUser({
    required String email, 
    required String password
  }) async{
    String res='Some error occured';

    try{
      if(email.isNotEmpty && password.isNotEmpty){
        await _auth.signInWithEmailAndPassword(email: email, password: password);
      }else{
        throw Error.safeToString("Erreur");
      }

      res="success";
    }catch(err){
      res=err.toString();
    }

    return res;
  }
}