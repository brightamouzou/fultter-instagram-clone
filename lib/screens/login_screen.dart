import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/ressources/auth_methods.dart';
import 'package:flutter_instagram_clone/screens/home_screen.dart';
import 'package:flutter_instagram_clone/screens/signup_screen.dart';
import 'package:flutter_instagram_clone/utils/color.dart';
import 'package:flutter_instagram_clone/utils/utils.dart';
import 'package:flutter_instagram_clone/widgets/form_validation_button.dart';
import 'package:flutter_instagram_clone/widgets/text_fied_input.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState()=> _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController=TextEditingController();
  TextEditingController _passwordController=TextEditingController();
  bool _isLoading=false;
  @override
  void dispose(){
    super.dispose();

    _emailController.dispose();
    _passwordController.dispose();
  }

  navigateToSignup(){
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => SignupScreen()));

  }

  navigateToHome() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomeScreen()));
  }
  handleLogin() async{
    if(!_isLoading){

      setState(() {
        _isLoading=true;
      });
      
      String res=await AuthMethods().loginUser(email: _emailController.text, password: _passwordController.text);

      if(res=="success"){
        navigateToHome();
      }else{
        showSnackBar(res.split(']')[1], context);
      }

      setState(() {
        _isLoading = false;
      });
    }

    
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
        // appBar: AppBar(
        //   title: Text( "Login into your account"),
        // ),
        body: SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        width: double.infinity,
        child: Column(children: [
          Flexible(flex: 2, child: Container()),
          SvgPicture.asset("assets/ic_instagram.svg",
              color: primaryColor, height: 64),
          const SizedBox(
            height: 30,
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

          //Login button
          InkWell(
              onTap: handleLogin,
              child: FormValidationButton(_isLoading)
          ),
          Flexible(flex: 2, child: Container()),
          const SizedBox(
            height: 24,
          ),

          //No account? Signup
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: const Text(
                  "Vous n'avez pas de compte? ",
                  style: TextStyle(fontSize: 13),
                ),
              ),
              GestureDetector(
                onTap:navigateToSignup,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: const Text(
                    "S'inscrire",
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