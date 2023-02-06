import 'package:flutter/material.dart';
import 'package:taskmanagementapiapp/screens/auth/forget/confirm_pass_screen.dart';
import 'package:taskmanagementapiapp/screens/auth/forget/pin_verify_screen.dart';
import 'package:taskmanagementapiapp/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';

import '../../../utils/constants.dart';
import '../../../utils/style.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/prefix_icon.dart';
import '../../../widgets/reusable_already_account.dart';
import '../signup_screen.dart';

class ForgetPasswordScreen extends StatelessWidget {
   ForgetPasswordScreen({Key? key}) : super(key: key);

  final _form = GlobalKey<FormState>();

  TextEditingController _emailTEController = TextEditingController();
  FocusNode emailFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
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
                      Text("Forget Password!",style: titleTextStyle(context)),
                      const SizedBox(height: 8),
                      Text("Enter Email to continue",style: subTextStyle(context)),
                      const SizedBox(height: 25),
                      //email field
                      TextFormField(
                        controller: _emailTEController,
                        keyboardType: TextInputType.emailAddress,
                        focusNode: emailFocusNode,
                        decoration:  InputDecoration(
                          prefixIcon: PrefixIcon(image: ic_envelope1),
                          hintText: "Enter your Email",
                        ),
                        validator: (value){
                          String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                          RegExp regex =  RegExp(pattern);
                          if(_emailTEController.text.isEmpty ){
                            return "Enter your Email";
                          }else if(!regex.hasMatch(value!)){
                            return "Enter your Right Email";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      //submit button
                      CustomButton(loading: authViewModel.loading,text: "Submit",onTap: (){
                        if(_form.currentState!.validate()){
                          emailFocusNode.unfocus();
                          authViewModel.recoveryEmailApi(context,_emailTEController.text);
                          // Navigator.pop(context);
                        }
                      }),
                      const SizedBox(height: 20),
                      ReusableAlreadyAccount(
                        accountText: "Don\'t have an account?",
                        buttonText: "Sign Up",
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpScreen()));
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
