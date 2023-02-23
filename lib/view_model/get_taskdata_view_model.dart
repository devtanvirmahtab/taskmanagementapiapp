import 'dart:async';
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
  bool _loadingCount = false;
  bool get loading => _loading;
  bool get loadingCount => _loading;

  int _totalCancelled = 0,_totalNew = 0,_totalCompleted = 0,_totalProgress = 0 ;
  String _totalCancelledtitle = "Cancelled",_totalNewtitle = "New",_totalCompletedtitle = "Completed",_totalProgresstitle = "Progress" ;

  int get totalNew => _totalNew;
  int get totalCancelled => _totalCancelled;
  int get totalCompleted => _totalCompleted;
  int get totalProgress => _totalProgress;

  String get totalNewtitle => _totalNewtitle;
  String get totalCancelledtitle => _totalCancelledtitle;
  String get totalCompletedtitle => _totalCompletedtitle;
  String get totalProgresstitle => _totalProgresstitle;

  setLoading(value){
    _loading = value;
    notifyListeners();
  }

  setLoadingCount(value){
    _loadingCount = value;
    notifyListeners();
  }


  Future<void> getStatusCountApi(String url)async{
    setLoadingCount(true);
    _taskRepo.getTaskApiRequest(url).then((value) {
      setLoadingCount(true);
      if(value["status"] == "success"){
        _totalNewtitle = value["data"][3]["_id"];
        _totalCancelledtitle = value["data"][0]["_id"];
        _totalCompletedtitle = value["data"][1]["_id"];
        _totalProgresstitle = value["data"][2]["_id"];

        _totalNew = value["data"][3]["sum"];
        _totalCancelled = value["data"][0]["sum"];
        _totalCompleted = value["data"][1]["sum"];
        _totalProgress = value["data"][2]["sum"];
        notifyListeners();
        Future.delayed(Duration(seconds: 2)).then((value) => {
          setLoadingCount(false)
        });
      }
      if(kDebugMode){
        print(value);
      }
    }).onError((error, stackTrace) {
      setLoadingCount(false);
      if(kDebugMode){
        print(error);
      }
    });
  }




  Future<void> getNewTaskApi(String url)async{

    setLoading(true);
    _taskRepo.getTaskApiRequest(url).then((value) {

      if(value["status"] == "success"){
        getTaskModel = GetTaskModel.fromJson(value);
        getStatusCountApi(AppUrls.taskStatusCountEndPointUrl);
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
        getStatusCountApi(AppUrls.taskStatusCountEndPointUrl);
        getNewTaskApi(AppUrls.newTaskEndPoint);
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


  Future<void> getChangeStatusApi(String url)async{
    setLoading(true);
    _taskRepo.getTaskApiRequest(url).then((value) {

      if(value["status"] == "success"){
        Utiles.toastMessage("Status Change SuccessFully");
        getStatusCountApi(AppUrls.taskStatusCountEndPointUrl);
        getNewTaskApi(AppUrls.newTaskEndPoint);
        setLoading(false);
      }
      if(kDebugMode){
        print(value);
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      Utiles.toastMessage("Status Change Failed try again");
      if(kDebugMode){
        print(error);
      }
    });
  }

}