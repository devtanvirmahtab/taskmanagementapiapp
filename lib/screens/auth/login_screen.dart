import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:taskmanagementapiapp/screens/auth/forget/forgetpass_screen.dart';
import 'package:taskmanagementapiapp/screens/auth/signup_screen.dart';
import 'package:taskmanagementapiapp/utils/colors.dart';
import 'package:taskmanagementapiapp/utils/constants.dart';
import 'package:taskmanagementapiapp/utils/routes/routes_name.dart';
import 'package:taskmanagementapiapp/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';

import '../../utils/style.dart';
import '../../utils/utiles.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/prefix_icon.dart';
import '../../widgets/reusable_already_account.dart';
import '../../widgets/suffix_icon.dart';
import '../home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  ValueNotifier<bool> _obsecurePass = ValueNotifier<bool>(true);

  final _form = GlobalKey<FormState>();

  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passTEController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passFocusNode = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailTEController.dispose();
    _passTEController.dispose();

    emailFocusNode.dispose();
    passFocusNode.dispose();

    _obsecurePass.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    print("build");
    return Scaffold(
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _form,
                child: Column(
                  children: [
                    Text("Welcome Back!",style: titleTextStyle(context)),
                    const SizedBox(height: 8),
                    Text("Sign in to continue",style: subTextStyle(context)),
                    const SizedBox(height: 25),
                    //email textField
                    TextFormField(
                      controller: _emailTEController,
                      keyboardType: TextInputType.emailAddress,
                      focusNode: emailFocusNode,
                      decoration:  InputDecoration(
                        prefixIcon: PrefixIcon(image: ic_envelope1),
                        hintText: "Enter your Email",
                      ),
                      onFieldSubmitted: (v){
                        Utiles.fieldFocusChange(context, emailFocusNode, passFocusNode);
                      },
                      validator: (value){
                        String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                        RegExp regex =  RegExp(pattern);
                        if(_emailTEController.text.isEmpty ){
                          return "Enter your Email";
                        }
                        // else if(!regex.hasMatch(value!)){
                        //   return "Enter your Right Email";
                        // }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    //password textField
                    ValueListenableBuilder(
                      valueListenable: _obsecurePass,
                      builder: (context,value,child){
                        return TextFormField(
                          controller: _passTEController,
                          focusNode: passFocusNode,
                          obscureText: _obsecurePass.value,
                          obscuringCharacter: "*",
                          decoration: InputDecoration(
                            prefixIcon: PrefixIcon(image: ic_lock),
                            hintText: "Enter your Password",
                            suffixIcon: SuffixIcon(visibility: _obsecurePass.value,onTap: () {
                                _obsecurePass.value = !_obsecurePass.value;
                              },
                            ),
                          ),
                          validator: (value){
                            if(_passTEController.text.isEmpty ){
                              return "Enter your Password";
                            }
                            // else if(value!.length <6){
                            //   return "Password more than 6 charracter";
                            // }
                            return null;
                          },
                        );
                      }
                    ),

                    Container(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ForgetPasswordScreen()));
                        },
                        child: Text("Forget Password",style: textButtonStyle(context),),
                      ),
                    ),
                    const SizedBox(height: 15),
                    CustomButton(loading:authViewModel.loading,text: "Login",onTap: (){
                      if(_form.currentState!.validate()){
                        passFocusNode.unfocus();
                        Map data = {
                          "email": _emailTEController.text,
                          "password": _passTEController.text
                        };
                        authViewModel.loginApi(data,context);
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));

                      }
                    }),
                    const SizedBox(height: 20),
                    ReusableAlreadyAccount(
                      accountText: "Don\'t have an account?",
                      buttonText: "Sign Up",
                      onTap: (){
                        Navigator.pushNamed(context, RoutesName.signup);
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      )
    );
  }
}








