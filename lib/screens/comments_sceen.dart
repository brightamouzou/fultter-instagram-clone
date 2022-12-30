
import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/models/post_comment.dart';
import 'package:flutter_instagram_clone/utils/color.dart';
import 'package:flutter_instagram_clone/widgets/comment.dart';
import 'package:flutter_instagram_clone/widgets/text_fied_input.dart';

class CommentsScreen extends StatefulWidget {
  const CommentsScreen({Key? key}) : super(key: key);

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  TextEditingController _commentController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text("Commentaires"),
        backgroundColor: mobileBackgroundColor,
        centerTitle: false,
      ),

      body: const Text("Hello"),
      bottomNavigationBar:
      SafeArea(
         child: Container(
          height:kToolbarHeight,
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom
       
          ),
          padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
          child:Row(
            children: [
                const CircleAvatar(
                  backgroundImage: NetworkImage("https://images.unsplash.com/photo-1485579149621-3123dd979885?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1031&q=80"),
                  radius: 18,
                ),
                
                Expanded(child: 
                
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 0,),
                  child: TextField(
                    controller:_commentController,
                    decoration: InputDecoration(
                      hintText: "Tapez votre comentaire",
                      border: InputBorder.none,
       
                    ),
                    keyboardType: TextInputType.text,
       
                  ),
                )
                ),

                InkWell(
                  onTap:(){

                  },
                  child:Padding(padding:EdgeInsets.only(right: 8),
                    child: 
                  const Text(
                    'Post',
                    style: TextStyle(
                      color: blueColor,
                      fontWeight: FontWeight.bold,
                    ),
                    
                  ) ,
                  )
                )
            ],
          )
             ),
       ),

    );
  }
}