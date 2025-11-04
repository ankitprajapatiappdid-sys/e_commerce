import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../data/models/product_model/product_model.dart';
import '../../../../../controllers/product_controller.dart';

class ReusableProductCard extends StatefulWidget {
  final ProductModel productModel;

  final void Function(ProductModel)? onAddToCart;
  final void Function(ProductModel)? onRemoveFromCart;
  final void Function(ProductModel)? onLike;

  final bool isInitiallyLiked;
  final bool isAddedToCart;

  final bool showCartButton;
  final bool showLikeButton;

  const ReusableProductCard({
    required this.productModel,
    this.onAddToCart,
    this.onRemoveFromCart,
    this.onLike,
    this.isInitiallyLiked = false,
    this.isAddedToCart = false,
    this.showCartButton = true,
    this.showLikeButton = true,
    super.key,
  });

  @override
  State<ReusableProductCard> createState() => _ReusableProductCardState();
}

class _ReusableProductCardState extends State<ReusableProductCard> {
  late bool isLiked;
  late bool isCart;

  @override
  void initState() {
    super.initState();
    isLiked = widget.isInitiallyLiked;
    isCart = widget.isAddedToCart;
  }

  Widget _buildProductImage(BuildContext context) {
    final imagePath = widget.productModel.image;

    if (imagePath == null || imagePath.isEmpty) {
      return const SizedBox(
        height: 140,
        child: Center(
          child: Icon(Icons.broken_image, size: 80, color: Colors.grey),
        ),
      );
    }

    final productController = Get.find<ProductController>();

    if (productController.isImageUrl(imagePath)) {
      return Image.network(
        imagePath,
        height: 140,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) =>
        const Icon(Icons.broken_image, size: 80, color: Colors.grey),
      );
    }

    return Image.file(
      File(imagePath),
      height: 140,
      width: double.infinity,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) =>
      const Icon(Icons.broken_image, size: 80, color: Colors.grey),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius:
                const BorderRadius.vertical(top: Radius.circular(16)),
                child: _buildProductImage(context),
              ),

              if (widget.showLikeButton)
                Positioned(
                  top: 8,
                  right: 8,
                  child: InkWell(
                    onTap: () {
                      setState(() => isLiked = !isLiked);
                      widget.onLike?.call(widget.productModel);
                    },
                    borderRadius: BorderRadius.circular(30),
                    child: CircleAvatar(
                      radius: 16,
                      backgroundColor: Colors.white.withOpacity(0.8),
                      child: Icon(
                        isLiked ? Icons.favorite : Icons.favorite_border,
                        color: isLiked ? Colors.red : Colors.grey,
                        size: 18,
                      ),
                    ),
                  ),
                ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.productModel.title ?? "Unnamed Product",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  widget.productModel.price != null
                      ? "\$${widget.productModel.price!.toStringAsFixed(2)}"
                      : "Price N/A",
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.green,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10),

                if (widget.showCartButton)
                  SizedBox(
                    width: double.infinity,
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
                        if (isCart) {
                          widget.onAddToCart?.call(widget.productModel);
                        } else {
                          widget.onRemoveFromCart?.call(widget.productModel);
                        }
                      },
                      icon: const Icon(Icons.add_shopping_cart, size: 18),
                      label: Text(
                        isCart ? "Remove" : "Add to Cart",
                        style:
                        const TextStyle(fontSize: 13, color: Colors.white),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
