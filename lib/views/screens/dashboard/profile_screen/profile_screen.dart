import 'package:e_commerce_app/services/route_helper.dart';
import 'package:e_commerce_app/views/base/custom_widget.dart/common_button.dart';
import 'package:flutter/material.dart';

import '../../../../services/theme.dart';
import '../../../base/custom_widget.dart/custom_image.dart';
import 'my_products/my_products_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: primaryColor,
        title: Text(
          "Profile",
          style: TextStyle(color: backgroundLight),
        ),
      ),
      body: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              Container(
                width: double.infinity,
                height: 100,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50)
                  )
                ),
              ),
              Positioned(
                bottom: -40, // Move image halfway out of the header
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: backgroundLight,
                  child: CustomImage(
                    path: Assets.imagesECommerceLogo,
                    height: 80,
                    width: 80,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 60),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomButton(
                  onTap: () {
                    Navigator.push(
                      context,
                      getCustomRoute(child: const MyProductsScreen()),
                    );
                  },
                  color: primaryColor.withValues(alpha: 0.2),
                  child: Row(
                    children: [
                      Icon(Icons.production_quantity_limits_sharp),
                      SizedBox(width: 20,),
                      const Text("My Products"),
                    ],
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
