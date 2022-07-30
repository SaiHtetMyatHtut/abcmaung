import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
class Controller extends GetxController{
  final box = GetStorage();
  bool firstTime = true;
  bool login = false;
  String token = '';
  RxInt gameBalance = 0.obs;
  RxInt mainBalance = 0.obs;
  String walletId = ''; // change on Dec 3
  int point = 0;
  String userId = '';
  String fullName = '';
  String userEmail = '';
  String userPhone = '';
  Controller(){
    firstTime = box.read('firstTime')??true;
    login = box.read('login')??false;
    token = box.read('token')??'';
    gameBalance(box.read('gameBalance')??0);
    mainBalance(box.read('mainBalance')??0);
    walletId=box.read('walletId')??'';
    point=box.read('point')??0;
    userId=box.read('userId')??'';
    fullName=box.read('fullName')??'';
    userEmail=box.read('userEmail')??'';
    userPhone=box.read('userPhone')??'';
  }
  void setFirstTime(bool isFirstTime){
    firstTime = isFirstTime;
    box.write('firstTime', isFirstTime);
    update();
  }
  void setLogin(bool isLogin){
    login = isLogin;
    box.write('login', isLogin);
    update();
  }
  void setToken(String newToken){
    token = newToken;
    box.write('token', newToken);
    update();
  }
  void setGameBalance(int newGameBalance){
    gameBalance(newGameBalance);
    box.write('gameBalance', newGameBalance);
    update();
  }
  void setMainBalance(int newMainBalance){
    mainBalance(newMainBalance);
    box.write('mainBalance', newMainBalance);
    update();
  }
  void setWalletId(String newwalletId){
    walletId=newwalletId;
    box.write('walletId', newwalletId);
    update();
  }
  void setPoint(int newPoint){
    point=newPoint;
    box.write('point', newPoint);
    update();
  }
  void setUserId(String newUserId){
    userId=newUserId;
    box.write('userId', newUserId);
    update();
  }
  void setFullName(String newFullName){
    fullName=newFullName;
    box.write('fullName', newFullName);
    update();
  }
  void setUserEmail(String newEmail){
    userEmail=newEmail;
    box.write('userEmail', userEmail);
    update();
  }
  void setUserPhone(String newPhone){
    userPhone=newPhone;
    box.write('userPhone', newPhone);
    update();
  }
}