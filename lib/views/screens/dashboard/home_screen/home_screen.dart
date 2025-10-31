import 'package:e_commerce_app/controllers/product_controller.dart';
import 'package:e_commerce_app/views/screens/dashboard/home_screen/components/category_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'components/add_category_dialog.dart';

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
            if(controller.isLoading){
              return Center(child: CircularProgressIndicator());
            }else{
              return  GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                padding: const EdgeInsets.all(12),
                itemCount: controller.productCategories.length,
                itemBuilder: (context, index) {
                  var category = controller.productCategories[index];
                  return GestureDetector(
                    onTap: (){},
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CategoryCard(categoryModel: category,),
                    ),
                  );
                },
              );
            }
          }
      ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(context: context, builder: (context) => const AddCategoryDialog());
          },
          child: Icon(Icons.add),
        ),
    );
  }
}
