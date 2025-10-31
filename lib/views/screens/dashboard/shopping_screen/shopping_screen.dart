import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controllers/product_controller.dart';
import 'components/product_card.dart';

class ShoppingScreen extends StatefulWidget {
  const ShoppingScreen({super.key});

  @override
  State<ShoppingScreen> createState() => _ShoppingScreenState();
}

class _ShoppingScreenState extends State<ShoppingScreen> {
  late final ProductController productController;

  @override
  void initState() {
    super.initState();

    productController = Get.find<ProductController>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      productController.getProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Shopping",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: GetBuilder<ProductController>(
        builder: (controller) {
          if (controller.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.productList.isEmpty) {
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
              childAspectRatio: 0.68,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: controller.productList.length,
            itemBuilder: (context, index) {
              final product = controller.productList[index];
              return GestureDetector(
                onTap: () {
                },
                child: ProductCard(productModel: product),
              );
            },
          );
        },
      ),
    );
  }
}
