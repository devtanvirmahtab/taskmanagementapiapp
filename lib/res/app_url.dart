
class AppUrls{
  static var baseUrl = "https://task.teamrabbil.com/api/v1";
  static var loginEndPointUrl = baseUrl+"/login";
  static var signUpEndPointUrl = baseUrl+"/registration";
  static var profileUpdateEndPointUrl = baseUrl+"/profileUpdate";
  static var recoveryEmailUrl = baseUrl+"/RecoverVerifyEmail/";
  static var recoveryOtpUrl = baseUrl+"/RecoverVerifyOTP/";
  static var recoveryResetPassUrl = baseUrl+"/RecoverResetPass";
  static var createTaskEndPointUrl = baseUrl+"/createTask";
  static var taskStatusCountEndPointUrl = baseUrl+"/taskStatusCount";
  static var newTaskEndPoint = baseUrl+"/listTaskByStatus/New";
  static var completedTaskEndPoint = baseUrl+"/listTaskByStatus/Completed";
  static var CancelledTaskEndPoint = baseUrl+"/listTaskByStatus/Cancelled";
  static var InProgressTaskEndPoint = baseUrl+"/listTaskByStatus/InProgress";
  static String ChangeStatusEndPoint(String taskId, String status) => baseUrl+"/updateTaskStatus/$taskId/$status";
}