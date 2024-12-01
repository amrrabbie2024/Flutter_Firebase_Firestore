
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

import '../sign_in/view.dart';

class VRegsisterView extends StatefulWidget {
  const VRegsisterView({super.key});

  @override
  State<VRegsisterView> createState() => _VRegsisterViewState();
}


final keyForm=GlobalKey<FormState>();
final nameController=TextEditingController(text: "");
final phoneController=TextEditingController(text: "");
final emailController=TextEditingController(text: "");
final passwordController=TextEditingController(text: "");
final confirmpasswordController=TextEditingController(text: "");
XFile? profilePic;

bool isPassword=true;
bool isConfirmPassword=true;

class _VRegsisterViewState extends State<VRegsisterView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Sign up"),
        titleTextStyle: TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.w600,fontSize: 22),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding:  EdgeInsetsDirectional.symmetric(horizontal: 16,vertical: 24),
          child: Form(
            key: keyForm,
            child: Column(
              crossAxisAlignment:  CrossAxisAlignment.center,
              children: [
                _profileImage(),
                SizedBox(height: 16,),
                _name(),
                SizedBox(height: 16,),
                _phone(),
                SizedBox(height: 16,),
                _email(),
                SizedBox(height: 16,),
                _password(),
                SizedBox(height: 16,),
                _confirmpassword(),
                SizedBox(height: 24,),
                _signupButton(),
                SizedBox(height: 16,),
                _signin()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _name() {
    return SizedBox(
      height: 60,
      child: TextFormField(
        controller: nameController,
        keyboardType: TextInputType.text,
        validator: (value) {
          if(value!.isEmpty)
            return "Must enter your name";
          else if(!value.contains(" "))
            return "Must enter full name";
          else return null;
        },
        decoration: InputDecoration(
          hintText: "type your name here",
          labelText: "Full name",
          prefix: Icon(Icons.person,color: Theme.of(context).primaryColor,),
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

  Widget _phone() {
    return SizedBox(
      height: 60,
      child: TextFormField(
        controller: phoneController,
        keyboardType: TextInputType.phone,
        validator: (value) {
          if (value!.isEmpty)
            return "Must enter your phone number";
          else if (value.length < 10)
            return "Invalid mobil";
          else
            return null;
        },
        decoration: InputDecoration(
          hintText: "type your phone number here",
          labelText: "Phone number",
          prefix: Icon(Icons.phone, color: Theme
              .of(context)
              .primaryColor,),
          alignLabelWithHint: true,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Theme
                  .of(context)
                  .primaryColor)
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Theme
                  .of(context)
                  .primaryColor)
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Theme
                  .of(context)
                  .primaryColor)
          ),
        ),
      ),
    );
  }

  Widget _email() {
    return SizedBox(
      height: 60,
      child: TextFormField(
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty)
            return "Must enter your email address";
          else if (!value.contains("@"))
            return "Invalid email";
          else if (!value.contains("."))
            return "Invalid email";
          else
            return null;
        },
        decoration: InputDecoration(
          hintText: "type your email address here",
          labelText: "Email address",
          prefix: Icon(Icons.email, color: Theme
              .of(context)
              .primaryColor,),
          alignLabelWithHint: true,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Theme
                  .of(context)
                  .primaryColor)
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Theme
                  .of(context)
                  .primaryColor)
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Theme
                  .of(context)
                  .primaryColor)
          ),
        ),
      ),
    );
  }

  Widget _password() {
    return SizedBox(
      height: 60,
      child: TextFormField(
        controller: passwordController,
        keyboardType: TextInputType.text,
        validator: (value) {
          if (value!.isEmpty)
            return "Must enter your password";
          else if (value.length <8)
            return "Password must be at least 8 characters";
          else
            return null;
        },
        obscureText: isPassword,
        decoration: InputDecoration(
          hintText: "type your password here",
          labelText: "Password",
          prefix: Icon(Icons.password, color: Theme
              .of(context)
              .primaryColor,),
          suffix: IconButton(onPressed: () {
            setState(() {
              isPassword=!isPassword;
            });
          }, icon: Icon(isPassword?Icons.visibility:Icons.visibility_off,color: Theme.of(context).primaryColor,)),
          alignLabelWithHint: true,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Theme
                  .of(context)
                  .primaryColor)
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Theme
                  .of(context)
                  .primaryColor)
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Theme
                  .of(context)
                  .primaryColor)
          ),
        ),
      ),
    );
  }

  Widget _confirmpassword() {
    return SizedBox(
      height: 60,
      child: TextFormField(
        controller: confirmpasswordController,
        keyboardType: TextInputType.text,
        validator: (value) {
          if (value!.isEmpty)
            return "Must enter your password again";
          else if (value.length <8)
            return "Confirm password must be at least 8 characters";
          else
            return null;
        },
        obscureText: isConfirmPassword,
        decoration: InputDecoration(
          hintText: "type your confirm password here",
          labelText: "Confirm Password",
          prefix: Icon(Icons.password, color: Theme
              .of(context)
              .primaryColor,),
          suffix: IconButton(onPressed: () {
            setState(() {
              isConfirmPassword=!isConfirmPassword;
            });
          }, icon: Icon(isConfirmPassword?Icons.visibility:Icons.visibility_off,color: Theme.of(context).primaryColor,)),
          alignLabelWithHint: true,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Theme
                  .of(context)
                  .primaryColor)
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Theme
                  .of(context)
                  .primaryColor)
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Theme
                  .of(context)
                  .primaryColor)
          ),
        ),
      ),
    );
  }

  Widget _profileImage() {
    return Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: [
        CircleAvatar(backgroundColor: Theme.of(context).primaryColor,radius: 50,child: CircleAvatar(radius: 48,backgroundImage: profilePic!=null?FileImage(File(profilePic!.path)):AssetImage("assets/images/person.png") as ImageProvider,)),
        Positioned(
            bottom: 0,
            child: IconButton(
                style: IconButton.styleFrom(
                    backgroundColor: Colors.green.withOpacity(.3)
                ),
                onPressed: () {
                  showDialog(context: context, builder: (context) => _showDialog(),);
                }, icon: Icon(Icons.add,color: Colors.blue,size: 24,)))
      ],
    );
  }

  Widget _signupButton(){
    return SizedBox(
      height: 60,
      width: 180,
      child: OutlinedButton(onPressed:  () async {
        if(keyForm.currentState!.validate()){
          try {
            final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: emailController.text,
              password: passwordController.text,
            );
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("User sign up sucessfully",
                  textAlign: TextAlign.center, style: TextStyle(fontSize: 16.0, fontWeight:
                  FontWeight.bold),), duration: Duration(seconds: 2), backgroundColor: Colors.green,));
            Navigator.push(context, MaterialPageRoute(builder: (context) => VLoginView(),));
          } on FirebaseAuthException catch (e) {
            if (e.code == 'weak-password') {
              print('The password provided is too weak.');
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("The password provided is too weak.",
                    textAlign: TextAlign.center, style: TextStyle(fontSize: 16.0, fontWeight:
                    FontWeight.bold),), duration: Duration(seconds: 2), backgroundColor: Colors.red,));
            } else if (e.code == 'email-already-in-use') {
              print('The account already exists for that email.');
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("The account already exists for that email.",
                    textAlign: TextAlign.center, style: TextStyle(fontSize: 16.0, fontWeight:
                    FontWeight.bold),), duration: Duration(seconds: 2), backgroundColor: Colors.red,));
            }
          } catch (e) {
            print(e);
          }
        }
      }, child: Text("Sign up",style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 22,fontWeight: FontWeight.w600))),
    );
  }

  Widget _signin(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text("Have account?",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
        TextButton(onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => VLoginView(),));
        }, child: Text("Sign in!",style: TextStyle(fontSize: 22,fontWeight: FontWeight.w500),))
      ],
    );
  }

  _showDialog() {
    return SimpleDialog(
      title: Text("Select image source",style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 22,fontWeight: FontWeight.w600),),
      children: [
        Padding(
          padding:  EdgeInsetsDirectional.symmetric(horizontal: 24),
          child: OutlinedButton.icon(onPressed: () async {
            profilePic=await ImagePicker().pickImage(source: ImageSource.camera);
            Navigator.pop(context);
            setState(() {});
          }, icon: Icon(Icons.camera,color: Theme.of(context).primaryColor,), label: Text("From camera")),
        ),
        SizedBox(height: 16,),
        Padding(
          padding:  EdgeInsetsDirectional.symmetric(horizontal: 24),
          child: OutlinedButton.icon(onPressed: () async {
            profilePic=await ImagePicker().pickImage(source: ImageSource.gallery);
            Navigator.pop(context);
            setState(() {});
          }, icon: Icon(Icons.browse_gallery,color: Theme.of(context).primaryColor,), label: Text("From gallery")),
        ),
      ],
    );
  }

}
