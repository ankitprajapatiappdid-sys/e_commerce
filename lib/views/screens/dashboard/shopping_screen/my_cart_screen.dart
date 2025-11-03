import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controllers/product_controller.dart';
import 'components/cart_product_card.dart';

class ShoppingScreen extends StatefulWidget {
  const ShoppingScreen({super.key});

  @override
  State<ShoppingScreen> createState() => _ShoppingScreenState();
}

class _ShoppingScreenState extends State<ShoppingScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Cart",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: GetBuilder<ProductController>(
        builder: (controller) {
          if (controller.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.cartList.isEmpty) {
            return const Center(
              child: Text(
                "Empty Cart.",
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
            itemCount: controller.cartList.length,
            itemBuilder: (context, index) {
              final product = controller.cartList[index];
              return CartProductCard(
                productModel: product,
                isInitiallyLiked: controller.favoriteList.any((p) => p.id == product.id),
                onLike: (p) => controller.toggleFavorite(p),
                onRemoveToCart: (p) => controller.removeFromCart(id: p.id!),
              );
            },
          );
        },
      ),
    );
  }
}
