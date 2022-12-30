import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_instagram_clone/models/user.dart';
import 'package:flutter_instagram_clone/providers/user_provider.dart';
import 'package:flutter_instagram_clone/ressources/firestore_methods.dart';
import 'package:flutter_instagram_clone/utils/color.dart';
import 'package:flutter_instagram_clone/utils/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  Uint8List? _file;
  final TextEditingController _descriptionController=TextEditingController();
  
  @override
  void initState() {
    _descriptionController.text="";
    super.initState();
  }
   @override
   void dispose(){
    super.dispose();
    _descriptionController.dispose();
   }

   handleUpload(
    String uid,
    String description,
    Uint8List? file,
   )async{
      User _user = Provider.of<UserProvider>(context,listen: false).getUser;

      showSnackBar("Publication en cours...", context);
      String res=await FirestoreMethods().uploadPost(userPhotoUrl: _user.photoUrl,photoUrl: _user.photoUrl,email: _user.email,username: _user.username,uid: uid, description: description,file: _file);

      try {
        if(res=="success"){
          showSnackBar("Posté", context);
        }else{
          showSnackBar(res, context);

        }
      } on Exception catch (e) {
        showSnackBar(res, context);
      }
   }
  _selectImage(BuildContext context)async{
    
    return showDialog(context: context, builder: (context){
      return SimpleDialog(
        title: const Text("Créer un poste"),
        children: [
          SimpleDialogOption(
            padding:  EdgeInsets.all(20),
            child: Text("Prendre une photo"),
            onPressed:()async {
               Navigator.of(context).pop();
               Uint8List? file = await pickImage(ImageSource.camera);
              if (file != null) {
                setState(() {
                  _file = file;
                });
              } 
            }
          ),

          SimpleDialogOption(
            child: const Text("Choisir une photo"),
            padding:const EdgeInsets.all(20),
            onPressed:  () async {
                  Navigator.of(context).pop();
                  Uint8List? file = await pickImage(ImageSource.gallery); 
                  if (file != null) {
                    setState(() {
                      _file = file;
                    });
                  }
            },
          ),

        SimpleDialogOption(
          child: const Text("Annuler"),
          padding: const EdgeInsets.all(20),
          onPressed: () {
            Navigator.of(context).pop();
          }),

        ],
      );
    });
  }
  
  @override
  Widget build(BuildContext context) {
     User user=Provider.of<UserProvider>(context).getUser;

    return _file==null? Center(
      child:IconButton(
        icon: Icon(Icons.upload),
        onPressed: (){
          _selectImage(context);
        },
       )

      
    ): Scaffold(

      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            //pass
            setState(() {
              _file=null;
            });
            
          },
        ),
        title: const Text('Faire un post post'),
        actions: [
          TextButton(
              onPressed: ()=>handleUpload(user.uid, _descriptionController.text,_file),
              child: const Text(
                "Poster",
                style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
          )),

        ],
        // centerTitle: true,
      ),

      body: Container(
        padding:const EdgeInsets.symmetric(vertical: 20),
        child: Column( 
          children: [
            Row(
              mainAxisAlignment:MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                CircleAvatar(
                  backgroundImage: NetworkImage(user.photoUrl),
                ),
 
                SizedBox(
                  height: 100,
                  width:MediaQuery.of(context).size.width*0.5,
                  child:TextField(
                    decoration: InputDecoration(
                      hintText: "Quoi de neuf, "+user.username +" ?",
                      border:InputBorder.none ,
                    ),
                    maxLength:256,
                    controller: _descriptionController,
                    
                  ),
                ),
              
                SizedBox(
                  height:45,
                  width:45,
                  child: AspectRatio(
                    aspectRatio:16/9 ,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image:MemoryImage(_file!),
                          fit: BoxFit.fill,
                          
                        ),
                        shape: BoxShape.circle
                        
                      ),
                      alignment:FractionalOffset.topCenter
                      // child: ,
                    ),
                  ),
                )

                
              ]

            )
          ],
          
        ),
      ),
    );
  }
}
