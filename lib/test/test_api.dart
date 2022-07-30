import 'package:abc_maung/model/2d3d_model/bet_confirm_dual.dart';
import 'package:abc_maung/model/auth/session_request.dart';
import 'package:flutter/material.dart';
import 'package:abc_maung/service/api_service.dart';
import 'package:abc_maung/service/err_response.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:get/get.dart';
import 'package:abc_maung/controller/controller.dart';

class TestAPI extends StatelessWidget {
  TestAPI({ Key? key }) : super(key: key);
  final Controller _ctrl = Get.find();
  final Logger logger = Logger();

  void checkPhone(String phone) async{
    String auth = 'vbIEY8JDWrmfB_iEAhAlHhHndGIDRMg5fRXES6i6EuquzFQY0kLWeWUwpGSyMmfNxQAoAP3yEi-XxHtir04cx-NUJEPMrqXZzZ4LDyLcIPXAYfELO-Gigzd43Wji6eXEQrOy3g';
    ApiService(Dio())
    .getData('ksksk')
    .then((value){
      print(value.message);
    })
    .catchError((Object obj) {
        switch (obj.runtimeType) {
          case DioError:
            ErrorResponse errorResponse = ErrorResponse(obj: obj);
            logger.e(errorResponse.data);
            // logger.d(errorResponse.html);
            // Get.snackbar('ERROR ${errorResponse.code}', errorResponse.codeMsg,
            //   snackPosition: SnackPosition.BOTTOM,
            //   duration: const Duration(seconds: 5));
            break;
          default:
        }
      });

    
  }
  
  void sendOtp1(String phone) async{
    ApiService(Dio())
    .sendOtp1('+959780132792')
    .then((value) {
        // change state user begin -> Not First Time
        // change end
      logger.i('status: ${value.status}');
      // logger.i('status_code: ${value.requestId}');
      logger.i('message: ${value.message}');
      })
      .catchError((Object obj) {
        switch (obj.runtimeType) {
          case DioError:
            final res = (obj as DioError).response;
            if(res!=null){
              if(res.data!=null){
                String message = res.data["message"];
                int status = res.data["status"];
                Get.snackbar('ERROR $status', message,
                    snackPosition: SnackPosition.BOTTOM,
                    duration: const Duration(seconds: 5));
                logger.e(
                    'message -> $message ,statusCode -> $status');
              }else{
                // print('data null');
                logger.i('SEVER RESPONSE DATA IS NULL');
              }
            }else{
              logger.i('SEVER RESPONSE NULL');
              // print('response null');
            }
            break;
          default:
        }
      });
  }
  void sendOtp2() async{
    ApiService(Dio())
        .sendOtp2(5060,203040)
        .then((value) {
      // change state user begin -> Not First Time
      // change end
    })
    .catchError((Object obj) {
      switch (obj.runtimeType) {
        case DioError:
          final res = (obj as DioError).response;
          if(res!=null){
            if(res.data!=null){
              String message = res.data["message"];
              int status = res.data["status"];
              Get.snackbar('ERROR $status', message,
                  snackPosition: SnackPosition.BOTTOM,
                  duration: const Duration(seconds: 5));
              logger.e(
                  'message -> $message ,statusCode -> $status');
            }else{
              // print('data null');
              logger.i('SEVER RESPONSE DATA IS NULL');
            }
          }else{
            logger.i('SEVER RESPONSE NULL');
            // print('response null');
          }
          break;
        default:
      }
    });
  }

  void register() async {
    ApiService(Dio())
    .register('+95944544545454', 'Testing', 'password')
    .then((value) {
      logger.i('message: ${value.message} ,statusCode: ${value.status}');
    }).catchError((Object obj) {
      switch (obj.runtimeType) {
        case DioError:
          final res = (obj as DioError).response;
          if (res != null) {
            if (res.data != null) {
              String message = res.data["message"];
              int status = res.data["status"];
              Get.snackbar('ERROR $status', message,
                  snackPosition: SnackPosition.BOTTOM,
                  duration: const Duration(seconds: 5));
              logger.e('message -> $message ,statusCode -> $status');
            } else {
              // print('data null');
              logger.i('SEVER RESPONSE DATA IS NULL');
            }
          } else {
            logger.i('SEVER RESPONSE NULL');
            // print('response null');
          }
          break;
        default:
      }
    });
  }

  void login(){
    ApiService(Dio())
    .login('+959999999999', 'testing')
    .then((value){
      // logger.i('balance  :  ${value.balanceData.balance}');
      // logger.i('point    : ${value.balanceData.point}');
      // logger.i('fullName : ${value.userData.fullName}');
      // logger.i('userId   : ${value.userData.userId}');
      // logger.i('userPhone: ${value.userData.userPhone}');
      // logger.i('messange : ${value.message}');
      // logger.i('status   : ${value.status}');
      // logger.i('token    : ${value.token}');
      // _ctrl.setBalance(value.balanceData.balance);
      // _ctrl.setBalanceId(value.balanceData.balanceId);
      // _ctrl.setPoint(value.balanceData.point);
      // _ctrl.setFullName(value.userData.fullName);
      // _ctrl.setUserId(value.userData.userId);
      // _ctrl.setUserPhone(value.userData.userPhone);
      // _ctrl.setToken(value.token);
    })
    .catchError((Object obj) {
      switch (obj.runtimeType) {
        case DioError:
          ErrorResponse errorResponse = ErrorResponse(obj: obj);
          logger.i(errorResponse.codeMsg);
          break;
        default:
      }
    });
  }

  void checkSession(){
    SessionReg session = SessionReg(_ctrl.userId,_ctrl.token);
    ApiService(Dio())
    .checkSession(session)
    .then((value){
      logger.d(value.message);
    })
    .catchError((Object obj) {
      switch (obj.runtimeType) {
        case DioError:
          ErrorResponse errorResponse = ErrorResponse(obj: obj);
          logger.i(errorResponse.codeMsg);
          break;
        default:
      }
    });
  }
  
  void sessionLogout(){
    SessionReg session = SessionReg(_ctrl.userId,_ctrl.token);
    ApiService(Dio())
    .deleteSession(session)
    .then((value){
      logger.d(value.message);
      logger.d(value.status);
    })
    .catchError((Object obj) {
      switch (obj.runtimeType) {
        case DioError:
          ErrorResponse errorResponse = ErrorResponse(obj: obj);
          logger.i(errorResponse.codeMsg);
          break;
        default:
      }
    });

  }

  void checkBalance(){
    ToConfirm toConfirm = ToConfirm(
      amount: 10000,
      userId: _ctrl.userId,
      gameType: 'three_d',
      number: ["000","256","512"]
    );
    ApiService(Dio())
    .betConfirm(toConfirm)
    .then((value){
      logger.i(value.numberList.length);
    })
    .catchError((Object obj) {
      switch (obj.runtimeType) {
        case DioError:
          final err = (obj as DioError).response;
          logger.d(err!);
          break;
        default:
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Test API'),),
      body: Column(children: [
        Center(
            child: ElevatedButton(
              onPressed: ()=>checkPhone('+959780132792'),
              child: const Text('Check User Phone'),
            ),
        ),
        Center(
            child: ElevatedButton(
              onPressed: ()=>sendOtp1('+959780132792'),
              child: const Text('   SendOpt 1   '),
            ),
        ),
        Center(
          child: ElevatedButton(
            onPressed: ()=>sendOtp2(),
            child: const Text('   SendOpt 1   '),
          ),
        ),
        Center(
          child: ElevatedButton(
            onPressed: ()=>register(),
            child: const Text('   Register   '),
          ),
        ),
        Center(
          child: ElevatedButton(
            onPressed: ()=>login(),
            child: const Text('   Login   '),
          ),
        ),
        Center(
          child: ElevatedButton(
            onPressed: ()=>checkSession(),
            child: const Text('   check Session   '),
          ),
        ),
        Center(
          child: ElevatedButton(
            onPressed: ()=>sessionLogout(),
            child: const Text('   Session Logout   '),
          ),
        ),
        Center(
          child: ElevatedButton(
            onPressed: ()=>checkBalance(),
            child: const Text('   3d Bet Confirm   '),
          ),
        ),
      ],mainAxisAlignment: MainAxisAlignment.center,),
    );
  }
}