import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:taskmanagementapiapp/main.dart';

import 'package:taskmanagementapiapp/data/app_exception.dart';
import 'package:taskmanagementapiapp/data/network/base_api_service.dart';

import 'package:taskmanagementapiapp/res/user_data.dart';
import 'package:taskmanagementapiapp/utils/routes/routes_name.dart';
import 'package:taskmanagementapiapp/utils/utiles.dart';


class NetworkApiService extends  BaseApiServices{

  @override
  Future getGetApiResponse(String url) async{
    dynamic responseJson;

    try{
      final response = await http.get(Uri.parse(url),
          headers: {
            "Access-Control-Allow-Origin": "*",
            // 'Content-Type': 'application/json',
            'Accept': '*/*',
            'token': UserData.token ?? ""
          }
      ).timeout(Duration(seconds: 30));
      responseJson = returnResponse(response);
    }on SocketException{
      Utiles.toastMessage("No Internet Connection");
      throw FetchDataException("No Internet Connection");
    }
    return responseJson;

  }

  @override
  Future getPostApiResponse(String url, dynamic data) async{
    dynamic responseJson;
    try{

      http.Response response = await http.post(
        Uri.parse(url),
        body: data,
        headers: {
          "Access-Control-Allow-Origin": "*",
          'Accept': '*/*',
          'token': UserData.token ?? ""
        }
      ).timeout(Duration(seconds: 30));

      responseJson = returnResponse(response);

    }on SocketException{
      throw FetchDataException("No Internet Connection");
    }
    return responseJson;
  }




  dynamic returnResponse(http.Response response)async{
    final sharedPref = await SharedPreferences.getInstance();
    switch(response.statusCode){
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
        sharedPref.clear();
        return navigatorKey.currentState?.pushNamedAndRemoveUntil(RoutesName.login, (route) => false);
      case 404:
        throw UnauthorisedException(response.body.toString());
      default:
        throw FetchDataException("Error accured while communicate with server"+
            "with Status code"+response.statusCode.toString());
    }
  }

}