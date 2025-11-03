import 'package:flutter/material.dart';
import '../../../../../data/models/product_model/product_model.dart';

class CartProductCard extends StatefulWidget {
  final ProductModel productModel;
  final void Function(ProductModel)? onRemoveToCart;
  final void Function(ProductModel)? onLike;

  final bool isInitiallyLiked;
  final bool isAddedToCart;

  const CartProductCard({
    required this.productModel,
    this.onRemoveToCart,
    this.onLike,
    this.isInitiallyLiked = false,
    this.isAddedToCart=false,
    super.key,
  });

  @override
  State<CartProductCard> createState() => _CartProductCardState();
}

class _CartProductCardState extends State<CartProductCard> {
  late bool isLiked;

  @override
  void initState() {
    super.initState();
    isLiked = widget.isInitiallyLiked;
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
                borderRadius:
                const BorderRadius.vertical(top: Radius.circular(16)),
                child: widget.productModel.image != null &&
                    widget.productModel.image!.isNotEmpty
                    ? Image.network(
                  widget.productModel.image!,
                  height: 140,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const Icon(
                    Icons.broken_image,
                    size: 80,
                    color: Colors.grey,
                  ),
                )
                    : const SizedBox(
                  height: 140,
                  child: Center(
                    child: Icon(
                      Icons.broken_image,
                      size: 80,
                      color: Colors.grey,
                    ),
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
                      if (widget.onRemoveToCart != null) {
                        widget.onRemoveToCart!(widget.productModel);
                      }
                    },
                    icon: const Icon(Icons.add_shopping_cart, size: 18),
                    label:  Text(
                      widget.isAddedToCart ?  "Remove": "Add to Cart",
                      style: TextStyle(fontSize: 13, color: Colors.white),
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
