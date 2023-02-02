class AppException implements Exception{
  final _message;
  final _prefix;

  AppException([this._message,this._prefix]);

  String toString(){
    return "$_prefix$_message";
  }

}



class FetchDataException extends AppException{
  //when api timeout
  FetchDataException([String? message]) :super(message,"Error During Communication");
}

class BadRequestException extends AppException{
  //invalid request url not found
  BadRequestException([String? message]) : super(message,"Invalid Request");
}

class UnauthorisedException extends AppException{
  //token not found  or  user not  exesit
  UnauthorisedException([String? message]):super(message ,"Unauthorised Exception");
}

class InvalidInputException extends AppException{
  InvalidInputException([String? message]) : super(message,"Invalid Input");
}