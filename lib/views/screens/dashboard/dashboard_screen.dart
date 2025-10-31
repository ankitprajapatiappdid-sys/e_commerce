
import 'dart:developer';

import 'package:e_commerce_app/views/screens/dashboard/profile_screen/profile_screen.dart';
import 'package:e_commerce_app/views/screens/dashboard/shopping_screen/shopping_screen.dart';
import 'package:e_commerce_app/views/screens/dashboard/wishlist_screen/wishlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../../../controllers/dashboard_controller.dart';
import '../../../generated/assets.dart';
import '../../../services/theme.dart';
import 'home_screen/home_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  @override
  void initState() {
    super.initState();
    log("Dashboard Screen Active", name: "IsDashBoard");
  }

  final pages = [
    const HomeScreen(),
    const WishlistScreen(),
    const ShoppingScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<DashBoardController>(
        builder: (DashBoardController controller) {
          return pages[controller.dashPage];
        },
      ),
      bottomNavigationBar: GetBuilder<DashBoardController>(
        builder: (DashBoardController controller) {
          return SafeArea(
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: backgroundLight,
                border: Border(
                  top: BorderSide(color: Colors.grey.shade200),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BottomNavigationItemWidget(
                    onTap: () {
                      controller.dashPage = 0;
                      controller.update();
                    },
                    title: 'Home',
                    icon: Assets.svgsHomeOutline,
                    isActive: controller.dashPage == 0 ,
                  ),
                  BottomNavigationItemWidget(
                    onTap: () {
                      controller.dashPage = 1;
                      controller.update();
                    },
                    title: 'Shopping',
                    icon: Assets.svgsProjectsOutline,
                    isActive: controller.dashPage == 1,
                  ),
                  BottomNavigationItemWidget(
                    onTap: () {
                      controller.dashPage = 2;
                      controller.update();
                    },
                    title: 'Wishlist',
                    icon: Assets.svgsHeartOutline,
                    isActive: controller.dashPage == 2,
                  ),
                  BottomNavigationItemWidget(
                    onTap: () {
                      controller.dashPage = 3;
                      controller.update();
                    },
                    title: 'Profile',
                    icon: Assets.svgsMoreOutline,
                    isActive: controller.dashPage == 3,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}


class BottomNavigationItemWidget extends StatelessWidget {
  const BottomNavigationItemWidget({
    super.key,
    required this.title,
    required this.icon,
    this.isActive = false,
    this.onTap,
  });

  final String title;
  final String icon;
  final bool isActive;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SvgPicture.asset(
              icon,
              width: icon.contains('logout') ? 20 : 24,
              height: icon.contains('logout') ? 20 : 24,
              colorFilter: ColorFilter.mode(
                  isActive ? primaryColor : Colors.black87, BlendMode.srcIn),
            ),
            const SizedBox(height: 2),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: isActive ? primaryColor : const Color(0xFF393648),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
