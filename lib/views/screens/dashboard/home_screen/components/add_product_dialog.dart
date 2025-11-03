import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../controllers/product_controller.dart';
import '../../../../base/custom_widget.dart/custom_toast.dart';
import '../../../../base/helper_widget/image_picker_sheet.dart';

final formKey = GlobalKey<FormState>();

class AddProductDialog extends StatelessWidget {
  const AddProductDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    final priceController = TextEditingController();
    final descriptionController = TextEditingController();
    final categoryController = TextEditingController();

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      child: GetBuilder<ProductController>(
        builder: (controller) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        labelText: "Product Title",
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) =>
                      value == null || value.isEmpty ? "Enter product title" : null,
                    ),
                    const SizedBox(height: 10),

                    TextFormField(
                      controller: priceController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: "Price",
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) return "Enter price";
                        if (num.tryParse(value) == null) return "Invalid number";
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),


                    TextFormField(
                      controller: descriptionController,
                      maxLines: 2,
                      decoration: const InputDecoration(
                        labelText: "Description",
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) => value == null || value.isEmpty
                          ? "Enter product description"
                          : null,
                    ),
                    const SizedBox(height: 10),


                    TextFormField(
                      controller: categoryController,
                      decoration: const InputDecoration(
                        labelText: "Category",
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) => value == null || value.isEmpty ? "Enter category" : null,
                    ),

                    const SizedBox(height: 15),


                    ElevatedButton.icon(
                      onPressed: () async {
                        File? file = await getImageBottomSheet(context);
                        if (file != null) controller.updateImage(file);
                      },
                      icon: const Icon(Icons.image_outlined),
                      label: const Text("Select Image"),
                    ),


                    if (controller.selectedImage != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(
                            controller.selectedImage!,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                    const SizedBox(height: 10),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 45),
                      ),
                      onPressed: controller.isLoading ? null : () async {
                        if (formKey.currentState!.validate()) {
                          if (controller.selectedImage == null) {
                            showCustomToast("Please select an image");
                            return;
                          }

                          final title = titleController.text.trim();
                          final description = descriptionController.text.trim();
                          final category = categoryController.text.trim();
                          final price = num.tryParse(priceController.text.trim()) ?? 0;

                          final result = await controller.addProduct(
                            title: title,
                            price: price,
                            description: description,
                            category: category,
                          );

                          if (result.isSuccess) {
                            Navigator.pop(context);
                          }
                        }
                      },
                      child: controller.isLoading
                          ? const SizedBox(
                        height: 22,
                        width: 22,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                          : const Text("Add Product"),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
