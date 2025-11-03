import 'package:e_commerce_app/controllers/product_controller.dart';
import 'package:e_commerce_app/services/route_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../services/theme.dart';
import '../product_detail_screen/product_detail_screen.dart';
import 'components/product_card.dart';
import 'components/add_product_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


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
              childAspectRatio: 0.57,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: controller.productList.length,
            itemBuilder: (context, index) {
              final product = controller.productList[index];

              return GestureDetector(
                onTap: (){
                  Navigator.push(context, getCustomRoute(child: ProductDetailScreen(
                    product: product,
                    isInitiallyLiked: controller.favoriteList.any((p) => p.id == product.id),
                    onLike: (p) => controller.toggleFavorite(p),
                    onAddToCart: (p) => controller.addToCart(product: p),
                    isAddedCart: controller.cartList.any((p) => p.id ==product.id),
                  )));
                },
                child: ProductCard(
                  productModel: product,
                  isInitiallyLiked: controller.favoriteList.any((p) => p.id == product.id),
                  onLike: (p) => controller.toggleFavorite(p),
                  onAddToCart: (p) => controller.addToCart(product: p),
                  isAddedCart: controller.cartList.any((p) => p.id ==product.id),
                ),
              );
            },
          );
        },
      ),

      floatingActionButton: GestureDetector(
        onTap: (){
          showDialog(
            context: context,
            builder: (_) => const AddProductDialog(),
          );
        },
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.all(Radius.circular(10))
          ),
          child:  Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 8.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.add,color: Colors.white,),
                SizedBox(width: 10,),
                Text("Product...",style: TextStyle(color: Colors.white),)
              ],
            ),
          ),
        ),
      )
    );
  }
}
