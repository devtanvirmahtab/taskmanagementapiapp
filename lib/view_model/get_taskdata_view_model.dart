import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:taskmanagementapiapp/model/get_task_model.dart';
import 'package:taskmanagementapiapp/res/app_url.dart';
import 'package:http/http.dart';
import 'package:taskmanagementapiapp/res/user_data.dart';
import 'package:taskmanagementapiapp/utils/utiles.dart';

import '../model/future_gettaskmodel.dart';
import '../repository/get_task_repository.dart';

class GetTaskDataModel with ChangeNotifier{

  GetTaskModel? getTaskModel;
  final _taskRepo = TaskRepository();
  bool _loading = false;
  bool get loading => _loading;

  setLoading(value){
    _loading = value;
    notifyListeners();
  }

  Future<void> getNewTaskApi(String url)async{
    setLoading(true);
    _taskRepo.getTaskApiRequest(url).then((value) {

      if(value["status"] == "success"){
        getTaskModel = GetTaskModel.fromJson(value);
        setLoading(false);
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

  String? result;

  Future<void> createApiCall(dynamic data)async{
    setLoading(true);
    _taskRepo.createTaskApiRequest(data).then((value) {
      setLoading(false);
      if(value["status"] == "success"){
        Utiles.toastMessage("Task added Successfully");
        result = "success";
        return result;
      }

      if(kDebugMode){
        print(value);
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      Utiles.toastMessage("No Internet Connection");

      if(kDebugMode){
        print(error);
      }
      return result = "";
    });
  }

}