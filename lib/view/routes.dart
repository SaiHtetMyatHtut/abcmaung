import 'package:abc_maung/test/test_api.dart';
import 'package:abc_maung/view/account/record/record.dart';
import 'package:abc_maung/view/account/record/record_detail.dart';
import 'package:abc_maung/view/home/2d/dashboard/tow_d_close.dart';
import 'package:abc_maung/view/home/2d/dashboard/two_d_record.dart';
import 'package:abc_maung/view/home/2d/dashboard/two_d_winner.dart';
import 'package:abc_maung/view/home/3d/dashboard/three_d_record.dart';
import 'package:abc_maung/view/home/3d/dashboard/three_d_winner.dart';
import 'package:abc_maung/view/home/3d/three_d_betting.dart';
import 'package:abc_maung/view/home/3d/three_d_confirm.dart';
import 'package:abc_maung/view/home/3d/three_d_dashboard.dart';
import 'package:abc_maung/view/intro/help.dart';
import 'package:abc_maung/view/intro/otp_verify.dart';
import 'package:abc_maung/view/loading.dart';
import 'package:abc_maung/view/main/main.dart';
import 'package:abc_maung/view/pocket/deposit/deposit.dart';
import 'package:abc_maung/view/pocket/deposit/deposit_detail.dart';
import 'package:abc_maung/view/pocket/transaction_history/transaction.dart';
import 'package:abc_maung/view/pocket/transaction_history/transaction_detail.dart';
import 'package:abc_maung/view/pocket/withdraw/withdraw.dart';
import 'package:abc_maung/view/pocket/withdraw/withdraw_detail.dart';
import 'package:get/get.dart';
import 'package:abc_maung/view/intro/welcome.dart';
import 'package:abc_maung/view/intro/register.dart';
import 'home/2d/two_d_dashboard.dart';
import 'home/2d/two_d_betting.dart';
import 'home/2d/two_d_confirm.dart';
import 'intro/login.dart';
import '../test/test.dart';

  List<GetPage> routes = [

    GetPage(name: '/welcome', page: () => Welcome()),
    GetPage(name: '/register', page: () => Register()),
    GetPage(name: '/otp', page: () => OtpVerigy()),
    GetPage(name: '/login', page: () => Login()),
    GetPage(name: '/', page: () => const Loading()),

    GetPage(name: '/home', page: () => const Main()),   
    GetPage(name: '/help', page: () => const Help()),

    GetPage(name: '/twoddashboard', page: () => TwoDDashboard()),
    GetPage(name: '/twodrecord', page: () => TwoDRecord()),
    GetPage(name: '/twodwinner', page: () => TwoDWinner()),
    GetPage(name: '/twodclose', page: () => TwoDClose()),
    GetPage(name: '/twodbetting', page: () => TwoDBetting()),
    GetPage(name: '/towdcomfirm', page: () => TowDConfirm()),

    GetPage(name: '/threeddashboard', page: () => ThreeDDashboard()),
    GetPage(name: '/threedrecord', page: () => ThreeDRecord()),
    GetPage(name: '/threedwinner', page: () => ThreeDWinner()),
    GetPage(name: '/threedbetting', page: () => ThreeDBetting()),
    GetPage(name: '/threedcomfirm', page: () => ThreeDConfirm()),
    
    // Pocket
    GetPage(name: '/deposit', page: () => Deposit()),
    GetPage(name: '/depositdetail', page: () => DepositDetail()),
    GetPage(name: '/withdraw', page: () => Withdraw()),
    GetPage(name: '/withdrawdetail', page: () => WithdrawDetail()),
    GetPage(name: '/transaction', page: () => Transaction()),
    GetPage(name: '/transactiondetail', page: () => TransactionDetail()),

    // Account
    GetPage(name: '/account/record', page: ()=> Record()),
    GetPage(name: '/account/record/detail', page: ()=> RecordDetail()),

    GetPage(name: '/test', page: () => Test()),
    GetPage(name: '/testapi', page: () => TestAPI()),
  ];
