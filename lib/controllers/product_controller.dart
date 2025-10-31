import 'dart:developer';

import 'package:e_commerce_app/data/models/product_model/product_model.dart';
import 'package:e_commerce_app/data/repositories/auth_repo.dart';
import 'package:get/get.dart';

import '../data/models/response/response_model.dart';

class ProductController extends GetxController implements GetxService{
  final AuthRepo authRepo;

  ProductController({required this.authRepo});

  bool isLoading = false;

  List<ProductCategoriesModel> productCategories = [];

  Future<ResponseModel> getProductCategory() async {
    log('-----------  getProductCategory() -------------');
    ResponseModel responseModel;
    isLoading = true;
    update();

    try {
      Response response = await authRepo.getProductsCategories();

      if (response.statusCode == 200 ) {
        productCategories = (response.body as List<dynamic>).map((productCate) => ProductCategoriesModel.fromJson(productCate)).toList();
        responseModel = ResponseModel(true, "getProductCategory");
      } else {
        responseModel = ResponseModel(false, "Something Went Wrong");
      }
    } catch (e) {
      responseModel = ResponseModel(false, "Catch");
      log("****** Error ****** $e", name: "getProductCategory");
    }

    isLoading = false;
    update();
    return responseModel;
  }
}