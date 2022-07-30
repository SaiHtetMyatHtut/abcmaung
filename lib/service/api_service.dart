import 'package:abc_maung/model/2d3d_model/bet_confirm_dual.dart';
import 'package:abc_maung/model/2d3d_model/bet_dual.dart';
import 'package:abc_maung/model/2d3d_model/bet_record_response.dart';
import 'package:abc_maung/model/2d3d_model/bet_winner_response.dart';
import 'package:abc_maung/model/2d3d_model/data_response.dart';
import 'package:abc_maung/model/2d3d_model/dream_response.dart';
import 'package:abc_maung/model/2d3d_model/valid_check_response.dart';
import 'package:abc_maung/model/2d_dashboard_response.dart';
import 'package:abc_maung/model/3d_dashboard_response.dart';
import 'package:abc_maung/model/auth/login_response.dart';
import 'package:abc_maung/model/auth/register_response.dart';
import 'package:abc_maung/model/auth/send_otp1_response.dart';
import 'package:abc_maung/model/auth/send_otp2_response.dart';
import 'package:abc_maung/model/auth/check_phone_response.dart';
import 'package:abc_maung/model/dashboard/2d_holiday_response.dart';
import 'package:abc_maung/model/transaction/cashin_both.dart';
import 'package:abc_maung/model/transaction/cashout_both.dart';
import 'package:abc_maung/model/user_data/account_record.dart';
import 'package:abc_maung/model/user_data/user_balance.dart';
import 'package:abc_maung/model/user_data/wallet_record.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:abc_maung/model/auth/session_request.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: 'http://54.241.144.146:9001/') // dev baseUrl
// @RestApi(baseUrl: 'http://54.241.144.146:9000/') 
// @RestApi(baseUrl: 'http://8fc4-69-160-25-195.ngrok.io/')   // test
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;
  // AUTH အသုံးပြုသူ မှတ်ပုံတင်ခြင်း၊ ဝင်ရောက်မှုဆိုင်ရာစစ်ဆေးခြင်းများ
  @GET("user/register")
  Future<Phone> checkPhone(@Header('user_phone') String phone);
  @GET("otp/1")
  Future<Otp1> sendOtp1(
      @Header('number') String phNum
  );
  @GET("otp/2")
  Future<Otp2> sendOtp2(
      @Header('request_id') int reqId,
      @Header('code') int code
  );
  @POST("user/register")
  Future<RegisterResponse> register(
    @Header('user_phone') userPhone,
    @Header('full_name') userName,
    @Header('user_password') userPassword
  );
  @POST("user/login")
  Future<LoginResponse> login(
    @Header('user_phone') userPhone,
    @Header('user_password') userPassword,
  );
  @POST('user/session')
  Future<RegisterResponse> checkSession(@Body() SessionReg session);
  @DELETE('user/logout')
  Future<RegisterResponse> deleteSession(@Body() SessionReg session);
  // AUTH

  // TwoD Betting ၂ လုံးထိုးတာနဲ့ ပတ်သက်တာ
  @GET('2d/live_result')
  Future<DashBoard> dashboad2D();
  @GET('2d/holiday_list')
  Future<TwoDHoliday> get2DHoliday();
  @GET('/2d/data')
  Future<Data2D> getData(
    @Query('last_read_time')String time,
  );
  @GET('2d/edit')
  Future<CheckValid> checkEdit(
    @Query('number')String number,
    @Query('amount')String amount
  );
  @POST('2d/bet')
  Future<FromBet> betTowD(@Body() ToBet toBet);
  @GET('user/2d/record')
  Future<BetRecord> betRecord2D(
    @Query('user_id')String userId
  );
  @GET('2d/winners')
  Future<BetWinner> betWinner2D();
  // TwoD Betting

  // 3D Betting ၃လုံးထိုးတာနဲ့ ပတ်သက်သမျှ
  @GET('3d/results')
  Future<Dash3D> dashboad3D();
  @GET('3d/data') 
  Future<Data2D> getData3D(
    @Query('last_read_time')String time,
    @Query('start')String start,
    @Query('end')String end
  );
  @POST('abc/confirmation')
  Future<FromConfirm> betConfirm(@Body() ToConfirm toConfirm);
  @GET('3d/edit')
  Future<CheckValid> checkEdit3D(
    @Query('number')String number,
    @Query('amount')String amount
  );
  @POST('/3d/bet')
  Future<FromBet> betThreeD(@Body() ToBet toBet);
  @GET('user/3d/record')
  Future<BetRecord> betRecord3D(
    @Query('user_id')String userId
  );
  @GET('3d/winners')
  Future<BetWinner> betWinner3D();
  @GET('3d/eainmat')
  Future<Dream> getDream(@Query('start')int start);
  // 3D Betting
  
  // user data အကောင့်ဝင်ကြည့်ရင် လက်ကျန်ငွေစစ်ဖို့
  @GET('user/wallet/balance')
  Future<UserBalance> userData(
    @Header('user_id')String userId
  );
  //

  // transaction
  @POST('user/wallet/cashin')
  Future<FromCashIn> cashIn(@Body() ToCashIn toCashIn);
  @POST('user/wallet/cashout')
  Future<FromCashOut> cashOut(@Body() ToCashOut toCashOut);
  @GET('user/wallet/money_history')
  Future<WalletRecord> walletRecord(@Query('wallet_id')String walletId);
  @GET('user/account/record')
  Future<AccountRecord> accountRecord(@Query('wallet_id')String walletId);
  // transaction
}
// user_id: testuser#0000
// user_phone: +959999999999
// user_password: testing
// user_email: testuser@email.com
// wallet_id:a9c01267-9069-482c-88e7-2121f44694c8
// user_balance: 100000

// endpoint changes 
// "/register" -> "/user/register"
// "/login" -> "/user/login"
// "/session" -> "/user/session" (session check လုပ်တာပဲသုံးလို့ရတော့ပါတယ်)
// "/session" (DELETE) (logout) -> "/user/logout" (session endpoint ကို delete လုပ်ပီး logout လုပ်ခဲ့တဲ့ endpoint ပါ)
// new endpoints
// "/user/wallet/cashin/<int:amount>" (PUT) ငွေဖြည့်ရန်
// "/user/wallet/cashout/<int:amount>" (PUT) ငွေထုတ်ရန်
// "/resettables" (GET) -> Tables များ reset လုပ်ရာတွင်ခေါ်ရန်