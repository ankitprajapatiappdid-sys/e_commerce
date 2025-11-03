import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../controllers/product_controller.dart';
import '../../../../../services/theme.dart';
import '../components/my_product_card.dart';

class MyProductsScreen extends StatelessWidget {
  const MyProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Home",
          style: TextStyle(fontWeight: FontWeight.bold,color: backgroundLight),
        ),
      ),
      body: GetBuilder<ProductController>(

        builder: (controller) {
          if (controller.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.myProductList.isEmpty) {
            return const Center(
              child: Text(
                "No products found.",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.all(12),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.6,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: controller.myProductList.length,
            itemBuilder: (context, index) {
              final product = controller.myProductList[index];

              return MyProductCard(
                productModel: product,
                isInitiallyLiked: controller.favoriteList.any((p) => p.id == product.id),
                onLike: (p) => controller.toggleFavorite(p),
                onAddToCart: (p) => controller.addToCart(product: p),
                isAddedCart: controller.cartList.any((p) => p.id ==product.id),
              );
            },
          );
        },
      ),

    );
  }
}
