import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:taskmanagementapiapp/res/user_data.dart';
import 'package:taskmanagementapiapp/view_model/profile_update_view_model.dart';

import '../utils/constants.dart';
import '../utils/style.dart';
import '../widgets/custom_button.dart';
import '../widgets/prefix_icon.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  final _form = GlobalKey<FormState>();

  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final profileViewModel = Provider.of<ProfileUpdateViewModel>(context);

    _emailTEController.text = UserData.email!;
    _firstNameTEController.text = UserData.firstName!;
    _lastNameTEController.text = UserData.lastName!;
    _mobileTEController.text = UserData.mobile!;
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
                      Text("Update Account",style: titleTextStyle(context)),
                      const SizedBox(height: 8),
                      Text("Update Account to continue",style: subTextStyle(context)),
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
                        enabled: false,
                        controller: _emailTEController,
                        keyboardType: TextInputType.emailAddress,
                        decoration:  InputDecoration(
                          prefixIcon: PrefixIcon(image: ic_envelope1),
                          hintText: "Enter your Email",
                        ),
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

                      const SizedBox(height: 15),
                      // submit button
                      CustomButton(loading: profileViewModel.loading,text: "Submit",onTap: (){
                        if(_form.currentState!.validate()){
                          Map data =
                          {
                            "firstName":_firstNameTEController.text,
                            "lastName":_lastNameTEController.text,
                            "mobile": _mobileTEController.text,
                            "photo":""
                          };
                          // authViewModel.signApi(data, context);
                          profileViewModel.profileUpApiCall(data);
                        }
                      }),

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
