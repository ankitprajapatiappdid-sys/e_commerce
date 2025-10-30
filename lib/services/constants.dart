import 'package:flutter/foundation.dart';

String getStringFromList(List<dynamic>? data) {
  String str = data.toString();
  return data.toString().substring(1, str.length - 1);
}

class AppConstants {
  static bool isProduction = true;
  String get getBaseUrl => baseUrl;

  set setBaseUrl(String url) => baseUrl = url;
  static const String liveUrl = 'https://api.escuelajs.co/';
  static const String localUrl = 'http://192.168.1.11:8000/';
  static String baseUrl = (kReleaseMode || isProduction) ? liveUrl : localUrl;

  static String appName = 'App Name';
  static const String agoraAppId = 'c87b710048c049f59570bd1895b7e561';

  // Auth
  static const String loginUri = 'api/vendor/v1/auth/otp/send';
  static const String otpVerifyUri = 'api/vendor/v1/auth/otp/verify';
  static const String profileUri = 'api/vendor/v1/auth/profile';
  static const String logOutUri = 'api/vendor/v1/auth/logout';
  static const String updateProfileUri = 'api/vendor/v1/auth/update';
  static const String registerUri = 'api/vendor/v1/auth/register';

  //-----basic
  static const String businessSettingUri = 'api/v1/basic/settings';



  //products

  static const String getProducts='api/v1/products';

  // Shared Key
  static const String token = 'user_app_token';
  static const String userId = 'user_app_id';
  static const String razorpayKey = 'razorpay_key';
  static const String recentOrders = 'recent_orders';
  static const String isUser = 'is_user';
}
