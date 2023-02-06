import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:taskmanagementapiapp/screens/auth/login_screen.dart';
import 'package:taskmanagementapiapp/view_model/auth_view_model.dart';

import '../../../utils/constants.dart';
import '../../../utils/style.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/prefix_icon.dart';

class ConfirmPassScreen extends StatelessWidget {
   ConfirmPassScreen({Key? key}) : super(key: key);

  final _form = GlobalKey<FormState>();

   TextEditingController _passwordTEController = TextEditingController();
   TextEditingController _confirmPassTEController = TextEditingController();

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
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Confirm Password!",style: titleTextStyle(context)),
                      const SizedBox(height: 8),
                      Text("New password set here",style: subTextStyle(context)),
                      const SizedBox(height: 25),
                      //email field
                      TextFormField(
                        obscureText: true,
                        controller: _passwordTEController,
                        decoration:  InputDecoration(
                          prefixIcon: PrefixIcon(image: ic_lock),
                          hintText: "Enter Password",
                        ),
                        validator: (value){
                          if(value!.isEmpty ){
                            return "Enter Password";
                          }else if(value.length < 6){
                            return "Password minimum 6 character";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      //email field
                      TextFormField(
                        obscureText: true,
                        controller: _confirmPassTEController,
                        decoration:  InputDecoration(
                          prefixIcon: PrefixIcon(image: ic_lock),
                          hintText: "Enter Confirm Password",
                        ),
                        validator: (value){
                          if(value!.isEmpty ){
                            return "Enter Confirm Password";
                          }else if(value != _passwordTEController.text){
                            return "Confirm password not matching";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      //submit button
                      CustomButton(loading: authViewModel.loading,text: "Submit",onTap: ()async{
                        if(_form.currentState!.validate()){
                          final sharedPref = await SharedPreferences.getInstance();
                          final String? email = sharedPref.getString("getemail");
                          final String? otp = sharedPref.getString("otp");

                            Map data = {
                              "email": email!,
                              "OTP": otp!,
                              "password": _confirmPassTEController.text
                           };
                          authViewModel.confirmPassApi(context, data);
                          // Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginScreen()));
                        }
                      }),
                      const SizedBox(height: 20),
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
