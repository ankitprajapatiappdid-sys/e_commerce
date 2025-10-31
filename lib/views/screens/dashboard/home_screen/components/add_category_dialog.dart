import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../controllers/product_controller.dart';
import '../../../../base/custom_widget.dart/custom_toast.dart';
import '../../../../base/helper_widget/image_picker_sheet.dart';

final formKey = GlobalKey<FormState>();
class AddCategoryDialog extends StatelessWidget {
  const AddCategoryDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    late String name;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      child: GetBuilder<ProductController>(
        builder: (controller) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(labelText: "Category Name"),
                  ),

                  const SizedBox(height: 10),

                  ElevatedButton(
                    onPressed: () async {
                      File? file = await getImageBottomSheet(context);
                      if (file != null) controller.updateImage(file);
                    },
                    child: Text("Select Image"),
                  ),

                  if (controller.selectedImage != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Image.file(controller.selectedImage!, height: 100),
                    ),

                  const SizedBox(height: 10),

                  ElevatedButton(
                    onPressed: controller.isLoading
                        ? null
                        : () async {
                      name = nameController.text.trim();
                      if (name.isEmpty) {
                        showCustomToast("Please enter name");
                        return;
                      }
                      if(formKey.currentState!.validate()){
                        controller.addCategory(name).then((value){
                          if (value.isSuccess) {
                            showCustomToast(value.message);
                          } else {
                            showCustomToast(value.message);
                          }
                        });
                      }
                    },
                    child: controller.isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text("Add Category"),
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
