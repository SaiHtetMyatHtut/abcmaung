import 'package:dio/dio.dart';
class ErrorResponse {
  Map<String,dynamic> data={};
  String message='';
  int statusCode=-1;
  String html='';
  int code=-1;
  String codeMsg='';
  ErrorResponse({required Object obj}){
    final err = (obj as DioError).response;
    if(err==null){
      data={};
      message='Response with Null';
      code=-1;
      codeMsg='';
    }else if(err.data==null){
      data={};
      message='Response no body';
      code=-1;
      codeMsg='';
    }else if(err.data.runtimeType==String){
      data={};
      html = err.data;
      message='Response HTML Code';
      code=-1;
      codeMsg='';
    }else{
      data={};
      data.addAll(err.data);
      message=data['message'];
      statusCode=data['status'];
      code=err.statusCode!;
      codeMsg=err.statusMessage!;
    }
  }
}

