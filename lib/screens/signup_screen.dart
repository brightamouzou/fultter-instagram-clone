import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/ressources/auth_methods.dart';
import 'package:flutter_instagram_clone/ressources/storage_methods.dart';
import 'package:flutter_instagram_clone/screens/login_screen.dart';
import 'package:flutter_instagram_clone/utils/color.dart';
import 'package:flutter_instagram_clone/utils/utils.dart';
import 'package:flutter_instagram_clone/widgets/form_validation_button.dart';
import 'package:flutter_instagram_clone/widgets/text_fied_input.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

class SignupScreen extends StatefulWidget {
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  bool _isLoading=false;
  Uint8List?_image;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
  }
  void _handleSignup() async{

    String res="Veuillez choisir une image";
    if(_image==null){
       showSnackBar(res, context);
      return;
    }


    setState(() {
    _isLoading = true;
    });

    res=await AuthMethods().signupUser(
          email: _emailController.text,
          password: _passwordController.text,
          username: _usernameController.text,
          bio: _bioController.text,
          file: _image!
    );

    if(res!="success"){
       showSnackBar(res, context);
    }else{
      navigateToLogin();
    }

    setState(() {
      _isLoading = false;
    });

  }

  navigateToLogin(){
         Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  void selectImage() async{
    Uint8List pickedIm=await pickImage(ImageSource.gallery);

    setState(() {
      _image=pickedIm;
    });
  }
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: Text( "Login into your account"),
        // ),

        body: SafeArea(
          child: Container(

          padding: const EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          child: Column(children: [
            Flexible(flex: 2, child: Container()),
            SvgPicture.asset("assets/ic_instagram.svg",
                color: primaryColor, height: 64),
            const SizedBox(
              height: 30,
            ),

            Stack(
              children: [
                _image!=null ?(
                  CircleAvatar(
                    backgroundImage:MemoryImage(_image!),
                    radius: 64,
                  )

                )
                :const CircleAvatar(
                  radius: 64,
                  backgroundImage: NetworkImage(
                    "https://www.apple.com/v/iphone-12/key-features/g/images/overview/hero/hero_purple__b4giljhj5ehe_small.jpg"
                  ),
                ),
                Positioned(
                  bottom: -10,
                  right: 5,
                  child:IconButton(onPressed: () async{
                        selectImage();
                  }, icon: Icon(Icons.add_a_photo)),
                )
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            //USername input

            TextFieldInput(
              hintText: "username",
              textEditingController: _usernameController,
              textInputType: TextInputType.text,
            ),

            const SizedBox(
              height: 24,
            ),

            //Email input
            TextFieldInput(
                hintText: "Email",
                textEditingController: _emailController,
                textInputType: TextInputType.emailAddress),

            const SizedBox(
              height: 24,
            ),

            //Password input
            TextFieldInput(
              hintText: "Mot de passe",
              textEditingController: _passwordController,
              textInputType: TextInputType.text,
              isPass: true,
            ),

            const SizedBox(
              height: 24,
            ),

            //Bio input
            TextFieldInput(
              hintText: "Bio",
              textEditingController: _bioController,
              textInputType: TextInputType.text,
            ),
            const SizedBox(
              height: 24,
            ),

            //Signup button
            InkWell(
                onTap: _handleSignup,
                child: FormValidationButton(_isLoading),
            ),
            Flexible(flex: 2, child: Container()),
            const SizedBox(
              height: 24,
            ),

            //Already account? login
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: const Text(
                    "Avez vous déjà un compte? ",
                    style: TextStyle(fontSize: 13),
                  ),
                ),
                GestureDetector(
                  onTap: navigateToLogin,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: const Text(
                      "Connectez vous! ",
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                  ),
              )
            ],
          ),
        ]),
      ),
    ));
  }
}
