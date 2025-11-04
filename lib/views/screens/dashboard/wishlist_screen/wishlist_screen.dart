import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/product_controller.dart';
import '../../../../services/theme.dart';
import '../common_components/resuable_product_card.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Favourites",
          style: TextStyle(fontWeight: FontWeight.bold,color: backgroundLight),
        ),
      ),
      body: GetBuilder<ProductController>(
        builder: (controller) {
          if (controller.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.favoriteList.isEmpty) {
            return const Center(
              child: Text(
                "No favourite added.",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.all(12),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.57,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: controller.favoriteList.length,
            itemBuilder: (context, index) {
              final product = controller.favoriteList[index];
              return ReusableProductCard(
                productModel: product,
                isInitiallyLiked: controller.favoriteList.any((p) => p.id == product.id),
                onLike: (p) => controller.toggleFavorite(p),
                onAddToCart: (p) => controller.addToCart(product: p),
                onRemoveFromCart: (p) => controller.removeFromCart(id: p.id!),
                isAddedToCart: controller.cartList.any((p) => p.id ==product.id),
              );
            },
          );
        },
      ),
    );
  }
}
