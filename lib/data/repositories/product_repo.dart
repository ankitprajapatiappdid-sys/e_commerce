import 'package:e_commerce_app/data/api/api_client.dart';
import 'package:get/get_connect/http/src/multipart/form_data.dart';

import 'package:get/get_connect/http/src/response/response.dart';

import '../../services/constants.dart';
import '../models/product_model/product_model.dart';

class ProductRepo {
  final ApiClient apiClient;
  ProductRepo({required this.apiClient});


  Future<Response> addProducts({required FormData data}) async {
    return await apiClient.postData(
      AppConstants.getProducts,
      data,
    );
  }


  Future<Response> getProduct() async => await apiClient.getData(
    AppConstants.getProducts
  );


  Future<Response> addToCartR({required ProductModel product})async{
    return await apiClient.postData(AppConstants.addToCart, product.toJson());
  }

  
  Future<Response> removeFromCartR({required int id}) async {
    return await apiClient.delete("${AppConstants.addToCart}/$id");
  }
}