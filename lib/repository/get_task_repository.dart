import 'package:taskmanagementapiapp/data/network/network_api_service.dart';

import '../res/app_url.dart';


class TaskRepository {

  NetworkApiService _apiService = NetworkApiService();

  Future<dynamic> getTaskApiRequest(String url) async {
    try {
      dynamic response = await _apiService.getGetApiResponse(url);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> createTaskApiRequest(dynamic data) async {
    try {
      dynamic response = await _apiService.getPostApiResponse(
          AppUrls.createTaskEndPointUrl, data);
      return response;
    } catch (e) {
      throw e;
    }
  }
}

