// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _ApiService implements ApiService {
  _ApiService(this._dio, {this.baseUrl}) {
    baseUrl ??= 'http://54.241.144.146:9001/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<Phone> checkPhone(phone) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'user_phone': phone};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Phone>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'user/register',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = Phone.fromJson(_result.data!);
    return value;
  }

  @override
  Future<Otp1> sendOtp1(phNum) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'number': phNum};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<Otp1>(
        Options(method: 'GET', headers: _headers, extra: _extra)
            .compose(_dio.options, 'otp/1',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = Otp1.fromJson(_result.data!);
    return value;
  }

  @override
  Future<Otp2> sendOtp2(reqId, code) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'request_id': reqId, r'code': code};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<Otp2>(
        Options(method: 'GET', headers: _headers, extra: _extra)
            .compose(_dio.options, 'otp/2',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = Otp2.fromJson(_result.data!);
    return value;
  }

  @override
  Future<RegisterResponse> register(userPhone, userName, userPassword) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'user_phone': userPhone,
      r'full_name': userName,
      r'user_password': userPassword
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<RegisterResponse>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, 'user/register',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = RegisterResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<LoginResponse> login(userPhone, userPassword) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      r'user_phone': userPhone,
      r'user_password': userPassword
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<LoginResponse>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, 'user/login',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = LoginResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<RegisterResponse> checkSession(session) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(session.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<RegisterResponse>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, 'user/session',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = RegisterResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<RegisterResponse> deleteSession(session) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(session.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<RegisterResponse>(
            Options(method: 'DELETE', headers: _headers, extra: _extra)
                .compose(_dio.options, 'user/logout',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = RegisterResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<DashBoard> dashboad2D() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<DashBoard>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '2d/live_result',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = DashBoard.fromJson(_result.data!);
    return value;
  }

  @override
  Future<TwoDHoliday> get2DHoliday() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<TwoDHoliday>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '2d/holiday_list',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = TwoDHoliday.fromJson(_result.data!);
    return value;
  }

  @override
  Future<Data2D> getData(time) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'last_read_time': time};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Data2D>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/2d/data',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = Data2D.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CheckValid> checkEdit(number, amount) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'number': number,
      r'amount': amount
    };
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CheckValid>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '2d/edit',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = CheckValid.fromJson(_result.data!);
    return value;
  }

  @override
  Future<FromBet> betTowD(toBet) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(toBet.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<FromBet>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '2d/bet',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = FromBet.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BetRecord> betRecord2D(userId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'user_id': userId};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BetRecord>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'user/2d/record',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BetRecord.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BetWinner> betWinner2D() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BetWinner>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '2d/winners',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BetWinner.fromJson(_result.data!);
    return value;
  }

  @override
  Future<Dash3D> dashboad3D() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Dash3D>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '3d/results',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = Dash3D.fromJson(_result.data!);
    return value;
  }

  @override
  Future<Data2D> getData3D(time, start, end) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'last_read_time': time,
      r'start': start,
      r'end': end
    };
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Data2D>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '3d/data',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = Data2D.fromJson(_result.data!);
    return value;
  }

  @override
  Future<FromConfirm> betConfirm(toConfirm) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(toConfirm.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<FromConfirm>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, 'abc/confirmation',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = FromConfirm.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CheckValid> checkEdit3D(number, amount) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'number': number,
      r'amount': amount
    };
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<CheckValid>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '3d/edit',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = CheckValid.fromJson(_result.data!);
    return value;
  }

  @override
  Future<FromBet> betThreeD(toBet) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(toBet.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<FromBet>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/3d/bet',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = FromBet.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BetRecord> betRecord3D(userId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'user_id': userId};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BetRecord>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'user/3d/record',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BetRecord.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BetWinner> betWinner3D() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BetWinner>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '3d/winners',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BetWinner.fromJson(_result.data!);
    return value;
  }

  @override
  Future<Dream> getDream(start) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'start': start};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Dream>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '3d/eainmat',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = Dream.fromJson(_result.data!);
    return value;
  }

  @override
  Future<UserBalance> userData(userId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'user_id': userId};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<UserBalance>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'user/wallet/balance',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = UserBalance.fromJson(_result.data!);
    return value;
  }

  @override
  Future<FromCashIn> cashIn(toCashIn) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(toCashIn.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<FromCashIn>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, 'user/wallet/cashin',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = FromCashIn.fromJson(_result.data!);
    return value;
  }

  @override
  Future<FromCashOut> cashOut(toCashOut) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(toCashOut.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<FromCashOut>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, 'user/wallet/cashout',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = FromCashOut.fromJson(_result.data!);
    return value;
  }

  @override
  Future<WalletRecord> walletRecord(walletId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'wallet_id': walletId};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<WalletRecord>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'user/wallet/money_history',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = WalletRecord.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AccountRecord> accountRecord(walletId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'wallet_id': walletId};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AccountRecord>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'user/account/record',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AccountRecord.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
