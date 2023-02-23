import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:taskmanagementapiapp/utils/routes/routes_name.dart';
import 'package:taskmanagementapiapp/utils/utiles.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskmanagementapiapp/view_model/drawer_view_model.dart';
import 'package:provider/provider.dart';


import '../repository/auth_repository.dart';
import '../res/app_url.dart';
import '../res/user_data.dart';
import 'get_taskdata_view_model.dart';

class AuthViewModel with ChangeNotifier{

  final _myRepo = AuthRepository();
  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value){
    _loading = value;
    notifyListeners();
  }

  Future<void> loginApi(dynamic data,BuildContext context)async{
    final sharePref = await SharedPreferences.getInstance();
    sharePref.clear();
    setLoading(true);
    _myRepo.loginApiRequest(data).then((value) {
      setLoading(false);

      if(value["status"] == "success"){
        UserData.token = value["token"];
        UserData.email = value["data"]["email"];
        UserData.firstName = value["data"]["firstName"];
        UserData.lastName = value["data"]["lastName"];
        UserData.photo = value["data"]["photo"];
        UserData.mobile = value["data"]["mobile"];

        Utiles.toastMessage("Login Successfully");
        sharePref.setString("token", value["token"]);
        sharePref.setString("email", value["data"]["email"]);
        sharePref.setString("firstName", value["data"]["firstName"]);
        sharePref.setString("lastName", value["data"]["lastName"]);
        sharePref.setString("photo", value["data"]["photo"]);
        sharePref.setString("mobile", value["data"]["mobile"]);

        print(value);
        // Navigator.pushNamed(context, );
        final getTaskDataModel = Provider.of<GetTaskDataModel>(context, listen: false);
        getTaskDataModel.getStatusCountApi(AppUrls.taskStatusCountEndPointUrl);

        Navigator.pushNamedAndRemoveUntil(context, RoutesName.mainhome, (route) => false);

        final drawerViewModel = Provider.of<DrawerViewModel>(context,listen: false);
        drawerViewModel.setCloseDrawer();


      }else if(value["status"] == "unauthorized"){
        Utiles.toastMessage("please check email and Password");
      }
      if(kDebugMode){
        print(value);
        // print(value.toString());
      }
    }).onError((error, stackTrace){
      setLoading(false);
      Utiles.toastMessage("No Internet Connection");
      if(kDebugMode){
        print(error.toString());
      }
    });
  }

  Future<void> signApi(dynamic data, BuildContext context)async{
    final sharePref = await SharedPreferences.getInstance();
    sharePref.clear();
    setLoading(true);
    _myRepo.signApiRequest(data).then((value){
      setLoading(false);
      if(value["status"] == "success"){
        UserData.token = value["token"];
        UserData.email = value["data"]["email"];
        UserData.firstName = value["data"]["firstName"];
        UserData.lastName = value["data"]["lastName"];
        UserData.photo = value["data"]["photo"];
        UserData.mobile = value["data"]["mobile"];

        sharePref.setString("token", value["token"]);
        sharePref.setString("email", value["data"]["email"]);
        sharePref.setString("firstName", value["data"]["firstName"]);
        sharePref.setString("lastName", value["data"]["lastName"]);
        sharePref.setString("photo", value["data"]["photo"]);
        sharePref.setString("mobile", value["data"]["mobile"]);
        // Navigator.pushNamed(context, );
        Navigator.pushNamedAndRemoveUntil(context, RoutesName.mainhome, (route) => false);
        Utiles.toastMessage("Sign Up Successfull");
      }else if(value["data"]["keyValue"]["email"] != null){
        Utiles.toastMessage("Already Have Account \n Please Login");
      }

      if(kDebugMode){
        print(value);
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      if(kDebugMode){
        print(error.toString());
      }
    });
  }

  Future<void> recoveryEmailApi(BuildContext context,String email)async{
    setLoading(true);
    final sharPref = await SharedPreferences.getInstance();
    _myRepo.recoveryVerifyEmail(email).then((value){
      setLoading(false);
      if(value["status"]=="success"){
        sharPref.setString("getemail", email);
        var passemail = value["data"]["accepted"][0];
        Navigator.pushNamed(context, RoutesName.pinverifyScreen);
      }else if(value["status"]== "fail" ){
        Utiles.toastMessage(value["data"]);
      }

      if(kDebugMode){
        print(value);
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      if(kDebugMode){
        print(error);
      }
    });
  }

  Future<void> verifyOtpApi(BuildContext context,String email,String otp)async{
    setLoading(true);
    final sharPref = await SharedPreferences.getInstance();
    _myRepo.verifyOtpRequest(email, otp).then((value){
      setLoading(false);
      if(value["status"]=="success"){
        sharPref.setString("otp", otp);
        Navigator.pushNamed(context, RoutesName.confirmScreen);
      }else if(value["status"]=="fail"){
        Utiles.toastMessage(value["data"]);
      }
      if(kDebugMode){
        print(value);
      }
    }).onError((error, stackTrace){
      setLoading(false);
      if(kDebugMode){
        print(error);
      }
    });
  }

  Future<void> confirmPassApi(BuildContext context,dynamic data)async{
    setLoading(true);
    _myRepo.confirmPassRequest(data).then((value){
      setLoading(false);
      if(value["status"]=="success"){
        Navigator.pushNamed(context, RoutesName.login);
        Utiles.toastMessage("password changed successfully");
      }else if(value["status"]=="fail"){
        Utiles.toastMessage(value["data"]);
      }
      if(kDebugMode){
        print(value);
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      if(kDebugMode){
        print(error);
      }
    });
  }

}