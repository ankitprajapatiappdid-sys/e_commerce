import 'dart:convert';
import 'dart:developer';

import 'package:e_commerce_app/controllers/dashboard_controller.dart';
import 'package:e_commerce_app/controllers/product_controller.dart';
import 'package:e_commerce_app/data/repositories/product_repo.dart';
import 'package:flutter/services.dart';
import 'package:get/instance_manager.dart';
import 'package:e_commerce_app/controllers/one_signal_controller.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/auth_controller.dart';

import '../controllers/permission_controller.dart';

import '../data/api/api_calls.dart';
import '../data/api/api_client.dart';
import '../data/repositories/auth_repo.dart';
import '../data/repositories/basic_repo.dart';

import 'constants.dart';

class Init {
  getBaseUrl() async {
    ApiCalls calls = ApiCalls();
    await calls
        .apiCallWithResponseGet(
            'https://fishcary.com/fishcary/api/link2.php?for=true')
        .then((value) {
      log(value.toString());
      AppConstants().setBaseUrl = jsonDecode(value)['link'];
      log(AppConstants().getBaseUrl, name: 'BASE');
    });
  }

  initialize() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    Get.lazyPut<SharedPreferences>(() => sharedPreferences);
    try {
      //-------Repos--------------
      Get.lazyPut(() => ApiClient(
          appBaseUrl: AppConstants.baseUrl, sharedPreferences: Get.find()));
      Get.lazyPut(
          () => AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
      Get.lazyPut(() => BasicRepo(apiClient: Get.find()));
      Get.lazyPut(() => ProductRepo(apiClient: Get.find()));

      //--------Controllers-----------
      Get.lazyPut(() => PermissionController());
      Get.lazyPut(() => AuthController(authRepo: Get.find()));
      Get.lazyPut(() => OneSingleController());
      Get.lazyPut(() => DashBoardController());
      Get.lazyPut(()=> ProductController(productRepo: Get.find()));
    } catch (e) {
      log('---- ${e.toString()} ----', name: "ERROR AT initialize()");
    }
  }

  stopAppRotation() async {
    await SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  }
}
