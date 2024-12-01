import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../firestore/chats/view.dart';
import '../sign_up/view.dart';


class VLoginView extends StatefulWidget {
  const VLoginView({super.key});

  @override
  State<VLoginView> createState() => _VLoginViewState();
}

final keyForm=GlobalKey<FormState>();
final emailController=TextEditingController(text:"" );
final passwordController=TextEditingController(text:"" );
bool isPassword=true;


class _VLoginViewState extends State<VLoginView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Login",style: TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.w500,fontSize: 24),),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding:  EdgeInsetsDirectional.symmetric(horizontal: 16),
          child: Form(
            key: keyForm,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                _email(),
                SizedBox(height: 16,),
                _password(),
                SizedBox(height: 24,),
                _loginButton(),
                SizedBox(height: 16,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("Do not have account?",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                    TextButton(onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => VRegsisterView(),));
                    }, child: Text("Sign up!",style: TextStyle(fontSize: 22,fontWeight: FontWeight.w500),))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _email(){
    return SizedBox(
      height: 60,
      child: TextFormField(
        controller: emailController,
        validator: (value) {
          if(value!.isEmpty)
            return "Must enter your email";
          else if(!value.contains("@"))
            return "Invalid email";
          else if(!value.contains("."))
            return "Invalid email";
          else return null;
        },
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          hintText: "enter your email here",
          labelText: "Email",
          prefix: Icon(Icons.email,color: Theme.of(context).primaryColor,),
          alignLabelWithHint: true,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Theme.of(context).primaryColor)
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Theme.of(context).primaryColor)
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Theme.of(context).primaryColor)
          ),
        ),
      ),
    );
  }

  Widget _password(){
    return SizedBox(
      height: 60,
      child: TextFormField(
        controller: passwordController,
        validator: (value) {
          if(value!.isEmpty)
            return "Must enter your password";
          else if(value.length <8)
            return "password must be at least 8 characters";
          else return null;
        },
        keyboardType: TextInputType.text,
        obscureText: isPassword,
        decoration: InputDecoration(
          hintText: "enter your password here",
          labelText: "Password",
          prefix: Icon(Icons.password,color: Theme.of(context).primaryColor,),
          suffix: IconButton(onPressed: () {
            setState(() {
              isPassword=!isPassword;
            });
          }, icon: Icon(isPassword?Icons.visibility:Icons.visibility_off,color: Theme.of(context).primaryColor,)),
          alignLabelWithHint: true,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Theme.of(context).primaryColor)
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Theme.of(context).primaryColor)
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Theme.of(context).primaryColor)
          ),
        ),
      ),
    );
  }

  Widget _loginButton(){
    return SizedBox(
      height: 60,
      width: 180,
      child: OutlinedButton(
          style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(color: Theme.of(context).primaryColor)
              )
          ),
          onPressed: () async {
            if(keyForm.currentState!.validate()){
              try {
                final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: emailController.text,
                    password: passwordController.text
                );
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("User sign in sucessfully",
                      textAlign: TextAlign.center, style: TextStyle(fontSize: 16.0, fontWeight:
                      FontWeight.bold),), duration: Duration(seconds: 2), backgroundColor: Colors.green,));
                Navigator.push(context, MaterialPageRoute(builder: (context) => ChatsView(email: emailController.text,),));
              } on FirebaseAuthException catch (e) {
                if (e.code == 'user-not-found') {
                  print('No user found for that email.');
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("No user found for that email.",
                        textAlign: TextAlign.center, style: TextStyle(fontSize: 16.0, fontWeight:
                        FontWeight.bold),), duration: Duration(seconds: 2), backgroundColor: Colors.red,));
                } else if (e.code == 'wrong-password') {
                  print('Wrong password provided for that user.');
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Wrong password provided for that user.",
                        textAlign: TextAlign.center, style: TextStyle(fontSize: 16.0, fontWeight:
                        FontWeight.bold),), duration: Duration(seconds: 2), backgroundColor: Colors.red,));
                }
              }
            }
          }, child: Text("Login",style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 22,fontWeight: FontWeight.w600),)),
    );
  }
}