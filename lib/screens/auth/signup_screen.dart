import 'package:flutter/material.dart';
import 'package:taskmanagementapiapp/screens/auth/login_screen.dart';
import 'package:taskmanagementapiapp/utils/routes/routes_name.dart';
import 'package:taskmanagementapiapp/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';

import '../../utils/colors.dart';
import '../../utils/constants.dart';
import '../../utils/style.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/prefix_icon.dart';
import '../../widgets/reusable_already_account.dart';
import '../../widgets/suffix_icon.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  ValueNotifier<bool> _obsecurePass = ValueNotifier<bool>(true);

  final _form = GlobalKey<FormState>();

  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();


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
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Create Account",style: titleTextStyle(context)),
                      const SizedBox(height: 8),
                      Text("Sign up to continue",style: subTextStyle),
                      const SizedBox(height: 25),
                      //first name field
                      TextFormField(
                        controller: _firstNameTEController,
                        keyboardType: TextInputType.text,
                        decoration:  InputDecoration(
                          prefixIcon: PrefixIcon(image: ic_user),
                          hintText: "Enter your First Name",
                        ),
                        validator: (value){
                          if(value!.isEmpty ){
                            return "Enter your First Name";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      //Last name field
                      TextFormField(
                        controller: _lastNameTEController,
                        keyboardType: TextInputType.text,
                        decoration:  InputDecoration(
                          prefixIcon: PrefixIcon(image: ic_user),
                          hintText: "Enter your Last Name",
                        ),
                        validator: (value){
                          if(value!.isEmpty ){
                            return "Enter your Last Name";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      //email field
                      TextFormField(
                        controller: _emailTEController,
                        keyboardType: TextInputType.emailAddress,
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
                      //Mobile number field
                      TextFormField(
                        controller: _mobileTEController,
                        keyboardType: TextInputType.number,
                        decoration:  InputDecoration(
                          prefixIcon: PrefixIcon(image: ic_phone),
                          hintText: "Enter your Mobile Number",
                        ),
                        validator: (value){
                          if(value!.isEmpty ){
                            return "Enter your Mobile Number";
                          }else if(value.length > 15){
                            return "Wrong your Mobile Number";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      //Password field
                      ValueListenableBuilder(
                          valueListenable: _obsecurePass,
                          builder: (context,value,child){
                            return TextFormField(
                              controller: _passTEController,
                              obscureText: _obsecurePass.value,
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
                                }else if(value!.length <6){
                                  return "Password more than 6 charracter";
                                }
                                return null;
                              },
                            );
                          }
                      ),


                      const SizedBox(height: 15),
                      // submit button
                      CustomButton(loading: authViewModel.loading,text: "Sign Up",onTap: (){
                        if(_form.currentState!.validate()){
                          Map data =
                            {
                              "email":_emailTEController.text,
                              "firstName":_firstNameTEController.text,
                              "lastName":_lastNameTEController.text,
                              "mobile": _mobileTEController.text,
                              "password":_passTEController.text,
                              "photo":""
                          };
                          authViewModel.signApi(data, context);
                          print("next screen");
                        }
                      }),
                      const SizedBox(height: 20),
                      // have an account
                      ReusableAlreadyAccount(
                        accountText: "Already Have an Account?",
                        buttonText: "Sign In",
                        onTap: (){
                          Navigator.pushNamedAndRemoveUntil(context, RoutesName.login, (route) => false);
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
