import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskmanagementapiapp/repository/profiel_update_repository.dart';
import 'package:taskmanagementapiapp/utils/utiles.dart';

import '../res/user_data.dart';

class ProfileUpdateViewModel with ChangeNotifier{
  final _puRepo = ProfileUpdateRepository();
  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value){
    _loading = value;
    notifyListeners();
  }

  Future<void> profileUpApiCall(dynamic data)async{
    final sharePref = await SharedPreferences.getInstance();
    setLoading(true);
    _puRepo.ProfileUpdateApiRequester(data).then((value) {
      setLoading(false);
      if(value["status"]=="success"){
        Utiles.toastMessage("Profile Update Successfully");
        UserData.firstName = data["firstName"];
        UserData.lastName = data["lastName"];
        UserData.photo = data["photo"];
        UserData.mobile = data["mobile"];

        sharePref.setString("firstName", data["firstName"]);
        sharePref.setString("lastName", data["lastName"]);
        sharePref.setString("photo", data["photo"]);
        sharePref.setString("mobile", data["mobile"]);
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