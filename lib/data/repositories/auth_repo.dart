import 'dart:developer';

import 'package:get/get_connect/http/src/response/response.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../services/constants.dart';
import '../api/api_client.dart';

class AuthRepo {
  final SharedPreferences sharedPreferences;
  final ApiClient apiClient;

  AuthRepo({required this.sharedPreferences, required this.apiClient});

  /// Methods to deal with Remote Data ///
  Future<Response> login({required  dynamic data}) async =>
      await apiClient.postData(AppConstants.loginUri, data);

  Future<Response> otpVerification(
          {required Map<String, dynamic> data}) async =>
      await apiClient.postData(AppConstants.otpVerifyUri, data);

  Future<Response> getUserData() async =>
      await apiClient.getData(AppConstants.profileUri);

  Future<Response> getLogOut() async =>
      await apiClient.getData(AppConstants.logOutUri);

  /// Methods to deal with Local Data ///
  Future<bool> saveUserToken(String token) async {
    apiClient.token = token;
    apiClient.updateHeader(token);
    return await sharedPreferences.setString(AppConstants.token, token);
  }

  String getUserToken() {
    return sharedPreferences.getString(AppConstants.token) ?? "";
  }

  Future<bool> saveUserId(String id) async {
    log(getUserId());
    return await sharedPreferences.setString(AppConstants.userId, id);
  }

  String getUserId() {
    return sharedPreferences.getString(AppConstants.userId) ?? "";
  }

  bool isLoggedIn() {
    return sharedPreferences.containsKey(AppConstants.token);
  }

  bool clearSharedData() {
    sharedPreferences.remove(AppConstants.token);
    sharedPreferences.remove(AppConstants.userId);
    apiClient.token = null;
    apiClient.updateHeader(null);
    sharedPreferences.clear();
    return true;
  }

  Future<String> getDeviceId() async {
    return OneSignal.User.pushSubscription.id ?? 'null';
  }

  Future<Response> getProductsCategories() async => await apiClient.getData(
      AppConstants.getCategories
  );
}
