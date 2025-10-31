import 'dart:io';

import 'package:e_commerce_app/data/api/api_client.dart';
import 'package:get/get_connect/http/src/multipart/form_data.dart';

import 'package:get/get_connect/http/src/response/response.dart';

import '../../services/constants.dart';

class ProductRepo {
  final ApiClient apiClient;
  ProductRepo({required this.apiClient});

  Future<Response> getProductsCategories() async => await apiClient.getData(
      AppConstants.categories
  );

  Future<Response> addCategory({required FormData data}) async {
    return await apiClient.postData(
      contentType: 'multipart/form-data',
      AppConstants.categories,
      data,
    );
  }


  Future<Response> getProduct() async => await apiClient.getData(
    AppConstants.getProducts
  );

}