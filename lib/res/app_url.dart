
class AppUrls{
  static var baseUrl = "https://task.teamrabbil.com/api/v1";
  static var loginEndPointUrl = baseUrl+"/login";
  static var signUpEndPointUrl = baseUrl+"/registration";
  static var recoveryEmailUrl = baseUrl+"/RecoverVerifyEmail/";
  static var recoveryOtpUrl = baseUrl+"/RecoverVerifyOTP/";
  static var recoveryResetPassUrl = baseUrl+"/RecoverResetPass";
  static var createTaskEndPointUrl = baseUrl+"/createTask";
  static var newTaskEndPoint = baseUrl+"/listTaskByStatus/New";
  static var completedTaskEndPoint = baseUrl+"/listTaskByStatus/Completed";
  static var CancelledTaskEndPoint = baseUrl+"/listTaskByStatus/Cancelled";
  static var InProgressTaskEndPoint = baseUrl+"/listTaskByStatus/InProgress";
}