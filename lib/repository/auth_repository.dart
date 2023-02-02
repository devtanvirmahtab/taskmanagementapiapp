
import 'package:taskmanagementapiapp/data/network/network_api_service.dart';
import 'package:taskmanagementapiapp/res/app_url.dart';

class AuthRepository{
  NetworkApiService _apiService = NetworkApiService();

  Future<dynamic> loginApiRequest(dynamic data)async{
    try{
      dynamic response = await _apiService.getPostApiResponse(AppUrls.loginEndPointUrl, data);
      return response;
    }catch(e){
      throw e;
    }
  }

  Future<dynamic> signApiRequest(dynamic data)async{
    try{
      dynamic response = await _apiService.getPostApiResponse(AppUrls.signUpEndPointUrl, data);
      return response;
    }catch(e){
      throw e;
    }
  }

  Future<dynamic> recoveryVerifyEmail(String data)async{
    try{
      dynamic response = await _apiService.getGetApiResponse(AppUrls.recoveryEmailUrl+data);
      return response;
    }catch(e){
      throw e;
    }
  }

  Future<dynamic> verifyOtpRequest(String email,String otp)async{
    try{
      dynamic response = await _apiService.getGetApiResponse(AppUrls.recoveryOtpUrl+email+"/$otp");
      return response;
    }catch(e){
      throw e;
    }
  }
  
  Future<dynamic> confirmPassRequest(dynamic data)async{
    try{
      dynamic response = await _apiService.getPostApiResponse(AppUrls.recoveryResetPassUrl, data);
      return response;
    }catch(e){
      throw e;
    }
  }
}