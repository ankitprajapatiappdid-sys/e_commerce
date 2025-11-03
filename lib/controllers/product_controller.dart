import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:e_commerce_app/data/models/product_model/product_model.dart';
import 'package:e_commerce_app/data/repositories/product_repo.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/models/response/response_model.dart';
import '../views/base/custom_widget.dart/custom_toast.dart';

class ProductController extends GetxController implements GetxService {
  final ProductRepo productRepo;

  ProductController({required this.productRepo});

  bool isLoading = false;

  List<ProductModel> favoriteList = [];
  List<ProductModel> cartList = [];

  final String _favKey = "favorite_products";

  @override
  void onInit() {
    super.onInit();
    _loadLocalFavorites();
  }

  Future<void> _loadLocalFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favData = prefs.getStringList(_favKey) ?? [];
    favoriteList =
        favData.map((json) => ProductModel.fromJson(jsonDecode(json))).toList();
    update();
  }

  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList(
        _favKey, favoriteList.map((p) => jsonEncode(p.toJson())).toList());
  }

  void toggleFavorite(ProductModel product) {
    final exists = favoriteList.any((p) => p.id == product.id);
    if (exists) {
      favoriteList.removeWhere((p) => p.id == product.id);
      showCustomToast("${product.title} removed from favorites");
    } else {
      favoriteList.add(product);
      showCustomToast("${product.title} added to favorites");
    }
    _saveFavorites();
    update();
  }

  void clearCart() {
    cartList.clear();
    update();
  }


  File? selectedImage;
  void updateImage(File image) {
    if (selectedImage != image) {
      selectedImage = image;
      update();
    }
  }

  Future<ResponseModel> removeFromCart({required int id}) async {
    log('----------- removeFromCart() -------------');
    ResponseModel responseModel;
    isLoading = true;
    update();

    try {
      final response = await productRepo.removeFromCartR(id: id);
      log(response.bodyString.toString(), name: "Remove From Cart");

      if (response.statusCode == 200 || response.statusCode == 204) {
        cartList.removeWhere((p) => p.id == id);
        responseModel = ResponseModel(true, "Removed from cart");
      } else {
        responseModel = ResponseModel(false, "Failed to remove from cart");
      }
    } catch (e, s) {
      log("****** Error ****** $e", name: "removeFromCart", stackTrace: s);
      responseModel = ResponseModel(false, "Error removing from cart: $e");
    }

    isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> addToCart({required ProductModel product}) async {
    log('----------- addToCart() -------------');
    ResponseModel responseModel;
    isLoading = true;
    update();

    try {
      final response = await productRepo.addToCartR(product: product);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final exists = cartList.any((p) => p.id == product.id);
        if (!exists) {
          cartList.add(product);
        }
        showCustomToast("${product.title} added to cart successfully");
        responseModel = ResponseModel(true, "Added to cart");
      } else {
        showCustomToast("Failed to add ${product.title} to cart");
        responseModel = ResponseModel(false, "Failed to add to cart");
      }
    } catch (e, s) {
      log("****** Error ****** $e", name: "addToCart", stackTrace: s);
      responseModel = ResponseModel(false, "Error adding to cart: $e");
    }

    isLoading = false;
    update();
    return responseModel;
  }



  Future<ResponseModel> addProduct({
    required String title,
    required num price,
    required String description,
    required String category,
  }) async {
    log('-----------  addProduct() -------------');
    ResponseModel responseModel;
    isLoading = true;
    update();

    try {
      Map<String, dynamic> data = {
        "title": title,
        "price": price,
        "description": description,
        "category": category,
        "image": selectedImage != null ? MultipartFile(selectedImage, filename: selectedImage!.path) : null,
      };

      Response response = await productRepo.addProducts(data: FormData(data));

      if (response.statusCode == 200 || response.statusCode == 201) {
        responseModel = ResponseModel(true, "Product added successfully");
        showCustomToast("Product added successfully Cool");
      } else {
        responseModel = ResponseModel(false, "Failed to add Product");
      }
    } catch (e) {
      responseModel = ResponseModel(false, "Catch: $e");
      log("****** Error ****** $e", name: "addProduct");
    }

    isLoading = false;
    update();
    return responseModel;
  }



  List<ProductModel> productList = [];

  Future<ResponseModel> getProducts() async {
    log('----------- getProducts() -------------');
    ResponseModel responseModel;
    isLoading = true;
    update();

    try {
      final response = await productRepo.getProduct();
      if (response.statusCode == 200) {
        productList = (response.body as List<dynamic>)
            .map((item) => ProductModel.fromJson(item))
            .toList();
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
