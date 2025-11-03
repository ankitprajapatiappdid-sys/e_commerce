import 'dart:io';
import 'package:e_commerce_app/data/models/product_model/product_model.dart';
import 'package:e_commerce_app/services/route_helper.dart';
import 'package:e_commerce_app/services/theme.dart';
import 'package:e_commerce_app/views/screens/dashboard/buy_now_screen/buy_now_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controllers/product_controller.dart';

class ProductDetailScreen extends StatefulWidget {
  final ProductModel product;
  final void Function(ProductModel)? onAddToCart;
  final void Function(ProductModel)? onLike;

  final bool isInitiallyLiked;
  final bool isAddedCart;

  const ProductDetailScreen({
    required this.product,
    this.onAddToCart,
    this.onLike,
    this.isInitiallyLiked = false,
    this.isAddedCart=false,
    super.key,
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {

  late bool isLiked;
  late bool isCart;
  @override
  void initState() {
    super.initState();
    isLiked = widget.isInitiallyLiked;
    isCart=widget.isAddedCart;
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(
      builder: (controller) {
        final imagePath = widget.product.image ?? "";

        return Scaffold(
          appBar: AppBar(
            title: Text(
              widget.product.title ?? "Product Detail",
              style: TextStyle(color: backgroundLight),
            ),
            iconTheme: IconThemeData(color: backgroundLight),
            backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          ),
          body: SingleChildScrollView(
            child: Stack(
              children:[
                Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (imagePath.isNotEmpty)
                    Container(
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: controller.isImageUrl(imagePath)
                          ? Image.network(
                        imagePath,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => const Icon(
                          Icons.broken_image,
                          size: 100,
                          color: Colors.grey,
                        ),
                      )
                          : Image.file(
                        File(imagePath),
                        height: 240,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => const Icon(
                          Icons.broken_image,
                          size: 100,
                          color: Colors.grey,
                        ),
                      ),
                    )
                  else
                    const SizedBox(
                      height: 240,
                      child: Center(
                        child: Icon(
                          Icons.broken_image,
                          size: 100,
                          color: Colors.grey,
                        ),
                      ),
                    ),

                  const SizedBox(height: 20),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.product.title ?? "Unnamed Product",
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          widget.product.description ?? "No description available.",
                          style: const TextStyle(fontSize: 16, color: Colors.black54),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          widget.product.price != null
                              ? "\$${widget.product.price!.toStringAsFixed(2)}"
                              : "Price not available",
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.green,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 30,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blueAccent,
                                  padding: const EdgeInsets.symmetric(vertical: 8),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                onPressed: () {
                                  setState(() => isCart = !isCart);
                                  if (widget.onAddToCart != null) {
                                    widget.onAddToCart!(widget.product);
                                  }
                                },
                                icon: const Icon(Icons.add_shopping_cart, size: 18),
                                label: Text(
                                  isCart ? "Remove" : "Add to Cart",
                                  style: const TextStyle(fontSize: 13, color: Colors.white),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blueAccent,
                                  padding: const EdgeInsets.symmetric(vertical: 8),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.push(context, getCustomRoute(child: BuyNowScreen(product: widget.product)));
                                },
                                icon: const Icon(Icons.shopping_bag, size: 18),
                                label: const Text(
                                  "Buy Now",
                                  style: TextStyle(fontSize: 13, color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 50,)
                      ],
                    ),
                  ),
                ],
              ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: InkWell(
                    onTap: () {
                      setState(() => isLiked = !isLiked);
                      if (widget.onLike != null) {
                        widget.onLike!(widget.product);
                      }
                    },
                    borderRadius: BorderRadius.circular(30),
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.white.withValues(alpha: 0.8),
                      child: Icon(
                        isLiked ? Icons.favorite : Icons.favorite_border,
                        color: isLiked ? Colors.red : Colors.grey,
                        size: 25,
                      ),
                    ),
                  ),
                ),
              ]
            ),
          ),
        );
      },
    );
  }
}
