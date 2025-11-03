import 'dart:io';

import 'package:flutter/material.dart';
import '../../../../../data/models/product_model/product_model.dart';

class MyProductCard extends StatefulWidget {
  final ProductModel productModel;
  final void Function(ProductModel)? onAddToCart;
  final void Function(ProductModel)? onLike;

  final bool isInitiallyLiked;
  final bool isAddedCart;

  const MyProductCard({
    required this.productModel,
    this.onAddToCart,
    this.onLike,
    this.isInitiallyLiked = false,
    this.isAddedCart=false,
    super.key,
  });

  @override
  State<MyProductCard> createState() => _MyProductCardState();
}

class _MyProductCardState extends State<MyProductCard> {
  late bool isLiked;

  late var file ;

  @override
  void initState() {
    super.initState();
    isLiked = widget.isInitiallyLiked;
    file = File(widget.productModel.image!);
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
            color: Colors.black.withValues(alpha: 0.1),
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
                borderRadius: BorderRadius.circular(10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.file(
                    file,
                    width: double.infinity,
                    height: 140,
                    fit: BoxFit.cover,
                  ),
                ),

              ),

              Positioned(
                top: 8,
                right: 8,
                child: InkWell(
                  onTap: () {
                    setState(() => isLiked = !isLiked);
                    if (widget.onLike != null) {
                      widget.onLike!(widget.productModel);
                    }
                  },
                  borderRadius: BorderRadius.circular(30),
                  child: CircleAvatar(
                    radius: 16,
                    backgroundColor: Colors.white.withValues(alpha: 0.8),
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
                      if (widget.onAddToCart != null) {
                        widget.onAddToCart!(widget.productModel);
                      }
                    },
                    icon: const Icon(Icons.add_shopping_cart, size: 18),
                    label: Text(
                      widget.isAddedCart ?  "Remove": "Add to Cart",
                      style: const TextStyle(fontSize: 13, color: Colors.white),
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
