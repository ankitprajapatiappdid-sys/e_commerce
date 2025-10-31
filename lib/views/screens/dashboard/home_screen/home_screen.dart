
import 'dart:developer';

import 'package:e_commerce_app/controllers/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ProductController category= Get.find<ProductController>();
      await category.getProductCategory();
      category.update();
    });


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Platzi",style: TextStyle(

        ),),
      ),
      body: GetBuilder<ProductController>(

          builder: (controller){
            log(controller.productCategories.toString(),name:"categoriesPrint");
            if(controller.isLoading){
              return Center(child: CircularProgressIndicator());
            }else{
              return  ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: controller.productCategories.length,
                itemBuilder: (context, index) {
                  var product = controller.productCategories[index];
                  return Card(
                    child: ListTile(
                      title: Text(product.name ?? '', style: TextStyle(fontWeight: FontWeight.w600)),
                      //leading: Image.network(product.image)
                    ),
                  );
                },
              );

            }

          }
      ),
    );
  }
}
