
import 'package:taskmanagementapiapp/data/network/network_api_service.dart';
import 'package:taskmanagementapiapp/res/app_url.dart';

class ProfileUpdateRepository{
  NetworkApiService _apiService = NetworkApiService();

  Future<dynamic> ProfileUpdateApiRequester(dynamic data)async{
    try{
      dynamic response = await _apiService.getPostApiResponse(AppUrls.profileUpdateEndPointUrl, data);
      return response;
    }catch(e){
      throw e;
    }
  }
}