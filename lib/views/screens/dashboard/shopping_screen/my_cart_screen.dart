import 'package:e_commerce_app/services/route_helper.dart';
import 'package:e_commerce_app/views/screens/dashboard/buy_now_screen/buy_now_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controllers/product_controller.dart';
import '../../../../services/theme.dart';
import '../common_components/resuable_product_card.dart';
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
        title: Text(
          "My Cart",
          style: TextStyle(fontWeight: FontWeight.bold,color: backgroundLight),
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
              return ReusableProductCard(
                productModel: product,
                isInitiallyLiked: controller.favoriteList.any((p) => p.id == product.id),
                onLike: (p) => controller.toggleFavorite(p),
                onRemoveFromCart: (p) => controller.removeFromCart(id: p.id!),
                isAddedToCart: controller.cartList.any((p) => p.id ==product.id),
              );

            },
          );
        },
      ),

      floatingActionButton: GetBuilder<ProductController>(
        builder: (controller){ return GestureDetector(
          onTap: (){
            Navigator.push(context, getCustomRoute(child: BuyNowScreen(cartListBuy: controller.cartList,)));
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
                  Icon(Icons.shopping_cart,color: Colors.white,),
                  SizedBox(width: 10,),
                  Text("Buy Now",style: TextStyle(color: Colors.white),)
                ],
              ),
            ),
          ),
        );}
      ),
    );
  }
}
