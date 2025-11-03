import 'package:e_commerce_app/data/models/product_model/product_model.dart';
import 'package:e_commerce_app/views/screens/dashboard/buy_now_screen/components/product_card.dart';
import 'package:flutter/material.dart';
import '../../../../services/theme.dart';

class BuyNowScreen extends StatelessWidget {
  final List<ProductModel>? cartListBuy;
  final ProductModel? product;

  const BuyNowScreen({Key? key, this.product, this.cartListBuy}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final bool isSingleProduct = product != null;

    double? totalPrice = 0.0;
    if (isSingleProduct) {
      totalPrice = (product?.price ?? 0) as double?;
    } else if (cartListBuy != null && cartListBuy!.isNotEmpty) {
      totalPrice = cartListBuy!.fold(
        0.0,
            (sum, item) => sum + (item.price ?? 0),
      );
    }

    const double deliveryFee = 5.0;
    final double grandTotal = totalPrice! + deliveryFee;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Confirm Purchase",
          style: TextStyle(color: backgroundLight),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Products list or single product card
            Expanded(
              child: isSingleProduct
                  ? ProductCard(productModel: product!)
                  : ListView.builder(
                itemCount: cartListBuy?.length ?? 0,
                itemBuilder: (context, index) {
                  final curProduct = cartListBuy![index];
                  return ProductCard(productModel: curProduct);
                },
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "Order Summary",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  summaryRow("Product Price", "\$${totalPrice.toStringAsFixed(2)}"),
                  summaryRow("Delivery Fee", "\$${deliveryFee.toStringAsFixed(2)}"),
                  const Divider(),
                  summaryRow("Total", "\$${grandTotal.toStringAsFixed(2)}", isTotal: true),
                ],
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Order Confirmed"),
                      content: const Text("Your purchase was successful!"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          child: const Text("OK"),
                        ),
                      ],
                    ),
                  );
                },
                child: const Text(
                  "Confirm Purchase",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget summaryRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              fontSize: isTotal ? 15 : 14,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              fontSize: isTotal ? 15 : 14,
              color: isTotal ? Colors.green : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
