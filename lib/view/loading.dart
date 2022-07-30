import 'package:abc_maung/model/auth/session_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:abc_maung/controller/controller.dart';
import 'package:get/get.dart';
import 'package:abc_maung/service/api_service.dart';
import 'package:abc_maung/service/err_response.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);
  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  final Controller _ctrl = Get.find();
  final Logger logger = Logger();
  bool reload = true;
  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) => check());
    super.initState();
  }
  void session(){
    // logger.i(_ctrl.userId);
    // logger.i(_ctrl.token);
    SessionReg session = SessionReg(_ctrl.userId,_ctrl.token);
    ApiService(Dio())
    .checkSession(session)
    .then((value){
      if(value.status==0){
        // TODO: go home page
        Get.offAllNamed('/home');
        reload=false;
      }
      // logger.d(value.message);
      // logger.d(value.status);
    })
    .catchError((Object obj) {
      switch (obj.runtimeType) {
        case DioError:
          ErrorResponse errorResponse = ErrorResponse(obj: obj);
          logger.e(errorResponse.html);
          if(errorResponse.statusCode==1){ // user not login
            // TODO: go login
            Get.offNamed('/login',arguments: {
              'userPhone':_ctrl.userPhone
            });
            reload=false;
          }
          if(reload){
            logger.i('Reloading . . .');
            reLoad();
          }
          break;
        default:
      }
    });
    logger.i('outer api end');
  }

  void reLoad(){
    logger.i('reLoad Start');
    Future.delayed(const Duration(seconds: 1),(){
      logger.i('run session');
      session();
    });
    logger.i('reLoad End');
  }
  void check() {
    if (_ctrl.firstTime) {
      Future.delayed(const Duration(seconds: 3),(){
        Get.offNamed('/welcome');
      });
    }else if(_ctrl.login){
      if(_ctrl.token.isNotEmpty){
        // TODO: API Request for check session
        // print(_ctrl.userId);
        print(_ctrl.token);
        // print(_ctrl.balance);
        // print(_ctrl.userPhone);
        // print(_ctrl.userEmail);
        // print(_ctrl.fullName);
        reLoad();
      }else{
        Future.delayed(const Duration(seconds: 3),(){
          Get.offNamed('/login',arguments: {
            'userPhone':_ctrl.userPhone
          });
        });
      }
    }else{
      Future.delayed(const Duration(seconds: 3),(){
        Get.offNamed('/login',arguments: {
          'userPhone':_ctrl.userPhone
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Center(
        child: Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10.0)
          ),
          child: const SpinKitCircle(
            color: Colors.white,
            size: 50.0,
          ),
        ),
      ),
    ));
  }
}
