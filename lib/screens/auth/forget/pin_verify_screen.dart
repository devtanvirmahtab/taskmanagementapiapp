import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'package:taskmanagementapiapp/view_model/auth_view_model.dart';

import '../../../utils/style.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/reusable_already_account.dart';
import '../signup_screen.dart';
class PinVerifyScreen extends StatefulWidget {

  const PinVerifyScreen({Key? key }) : super(key: key);


  @override
  State<PinVerifyScreen> createState() => _PinVerifyScreenState();
}

class _PinVerifyScreenState extends State<PinVerifyScreen> {


  TextEditingController textEditingController = TextEditingController();

  late StreamController<ErrorAnimationType> errorController;

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController.close();
    textEditingController.dispose();
    super.dispose();
  }

  bool hasError = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();

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
                  key: formKey,
                  child: Column(
                    children: [
                      Text("Forget Password!",style: titleTextStyle(context)),
                      const SizedBox(height: 8),
                      Text("Enter Email to continue",style: subTextStyle),
                      const SizedBox(height: 25),
                      //email field
                      PinCodeTextField(
                        appContext: context,
                        length: 6,
                        obscureText: false,
                        animationType: AnimationType.fade,
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(5),
                          fieldHeight: 50,
                          fieldWidth: 40,
                          activeFillColor: Colors.white,
                        ),
                        animationDuration: Duration(milliseconds: 300),
                        backgroundColor: Colors.blue.shade50,
                        enableActiveFill: true,
                        errorAnimationController: errorController,
                        controller: textEditingController,
                        validator: (v) {
                          if (v!.length < 3) {
                            return "I'm from validator";
                          }
                          return null;
                        },
                        onCompleted: (v) {
                          print("Completed");
                        },
                        onChanged: (value) {
                          print(value);
                          setState(() {
                            currentText = value;
                          });
                        },
                        beforeTextPaste: (text) {
                          print("Allowing to paste $text");
                          //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                          //but you can show anything you want here, like your pop up saying wrong paste format or etc
                          return true;
                        },
                      ),
                      const SizedBox(height: 15),
                      //submit button
                      CustomButton(loading:authViewModel.loading,text: "Submit",onTap: ()async{
                        formKey.currentState!.validate();
                        // conditions for validating
                        if (currentText.length != 6 ) {
                          errorController.add(ErrorAnimationType
                              .shake); // Triggering error shake animation
                          setState(() {
                            hasError = true;
                          });
                        } else {

                          final sf = await SharedPreferences.getInstance();
                          final String? email = sf.getString('getemail');
                          authViewModel.verifyOtpApi(context, email!, currentText);

                          setState(() {
                            hasError = false;
                            // Navigator.push(context, MaterialPageRoute(builder: (context) => ConfirmPassScreen()));
                          });
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
