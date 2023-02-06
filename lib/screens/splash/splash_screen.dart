import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskmanagementapiapp/res/user_data.dart';

import '../../utils/colors.dart';
import '../../utils/constants.dart';
import '../../utils/routes/routes_name.dart';
import '../../utils/size_config.dart';
import '../home_page.dart';

class SplashScreen extends StatefulWidget {
   SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}



class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      gotoNextScreen();
    });
  }

void gotoNextScreen()async{
    final sharePref = await SharedPreferences.getInstance();
    final String? result = sharePref.getString("token");
    if(result != null ){
      UserData.token = result;
      UserData.email = sharePref.getString("email");
      UserData.firstName = sharePref.getString("firstName");
      UserData.lastName = sharePref.getString("lastName");
      UserData.photo = sharePref.getString("photo");
      UserData.mobile = sharePref.getString("mobile");

      Future.delayed(Duration(seconds: 2)).then((value) => {
        Navigator.pushNamedAndRemoveUntil(context, RoutesName.mainhome, (route) => false)
      });
    }else{
      Future.delayed(Duration(seconds: 2)).then((value) => {
        // Navigator.pushNamedAndRemoveUntil(context, RoutesName.login, (route) => false)
        Navigator.pushNamed(context, RoutesName.login)
        // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LoginScreen()), (route) => false)
      });
    }
}

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: appPrimaryLightColor,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
                img_logo
            )
          ],
        ),
      ),
    );
  }
}
