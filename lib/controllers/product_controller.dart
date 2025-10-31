import 'dart:developer';
import 'dart:io';

import 'package:e_commerce_app/data/models/product_model/product_model.dart';
import 'package:e_commerce_app/data/repositories/product_repo.dart';
import 'package:get/get.dart';

import '../data/models/response/response_model.dart';

class ProductController extends GetxController implements GetxService{
  final ProductRepo productRepo;

  ProductController({required this.productRepo});

  bool isLoading = false;

  List<CategoryModel> productCategories = [];

  Future<ResponseModel> getProductCategory() async {
    log('-----------  getProductCategory() -------------');
    ResponseModel responseModel;
    isLoading = true;
    update();

    try {
      Response response = await productRepo.getProductsCategories();

      if (response.statusCode == 200 ) {
        productCategories = (response.body as List<dynamic>).map((productCate) => CategoryModel.fromJson(productCate)).toList();
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




  Future<ResponseModel> addCategory(String name) async {
    log('-----------  addCategory() -------------');
    ResponseModel responseModel;
    isLoading = true;
    update();

    try {

      Map<String , dynamic> data ={
        "name":name,
        "slug":"clothes",
        "image": selectedImage != null ? MultipartFile(selectedImage, filename: selectedImage!.path) : null
      };
      Response response = await productRepo.addCategory(data: FormData(data));

      if (response.statusCode == 200 || response.statusCode == 201) {
        responseModel = ResponseModel(true, "Category added successfully");
        await getProductCategory();
      } else {
        responseModel = ResponseModel(false, "Failed to add category");
      }
    } catch (e) {
      responseModel = ResponseModel(false, "Catch: $e");
      log("****** Error ****** $e", name: "addCategory");
    }

    isLoading = false;
    update();
    return responseModel;
  }



  File? selectedImage;
  updateImage(File image) {
    if (selectedImage != image) {
      selectedImage = image;
      update();
    }
  }



  List<ProductModel> productList = [];

  Future<ResponseModel> getProducts() async {
    log('----------- getProducts() -------------');
    ResponseModel responseModel;
    isLoading = true;
    update();

    try {
      final response = await productRepo.getProduct();
      log(productList.toString(),name: "ProductList");
      if (response.statusCode == 200 && response.body is List) {
        productList = (response.body as List)
            .map((item) => ProductModel.fromJson(item))
            .toList();
        log(productList.toString(),name: "ProductList1");
        responseModel = ResponseModel(true, "Products fetched successfully");
      } else {
        responseModel = ResponseModel(false, "Something went wrong");
      }
    } catch (e, s) {
      responseModel = ResponseModel(false, "Exception occurred");
      log("****** Error ****** $e", name: "getProducts", stackTrace: s);
    }

    isLoading = false;
    update();
    return responseModel;
  }

}