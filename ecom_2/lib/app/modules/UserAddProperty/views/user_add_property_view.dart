import 'package:ecom_2/app/components/My_button.dart';
import 'package:ecom_2/app/modules/UserAddProperty/controllers/user_add_property_controller.dart';
import 'package:ecom_2/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserAddPropertyView extends StatelessWidget {
  const UserAddPropertyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserAddPropertyController>(
      init: UserAddPropertyController(),
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: const Text('Add Property'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Form(
              key: controller.addProductFormKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Add Property',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: controller.titleController,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      labelText: 'Property Title',
                      hintText: 'Enter Property title',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter property title';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: controller.descriptionController,
                    textInputAction: TextInputAction.next,
                    minLines: 3,
                    maxLines: 5,
                    maxLength: 500,
                    decoration: const InputDecoration(
                      labelText: 'Property Description',
                      hintText: 'Enter Property description',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Property title';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: controller.priceController,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Property Price',
                      hintText: 'Enter Property price',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Property price';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  GetBuilder<UserAddPropertyController>(
                      builder: (controller) => controller.categories == null
                          ? const CircularProgressIndicator()
                          : DropdownButtonFormField(
                              menuMaxHeight: 350,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder()),
                              hint: const Text('Select Category'),
                              items: controller.categories!
                                  .map((category) => DropdownMenuItem(
                                        value: category.categoryId,
                                        child:
                                            Text(category.categoryTitle ?? ''),
                                      ))
                                  .toList(),
                              onChanged: (v) {
                                controller.selectedCategory = v;
                              })),
                  const SizedBox(height: 16),
                  GetBuilder<UserAddPropertyController>(
                      builder: (controller) => controller.locations == null
                          ? const CircularProgressIndicator()
                          : DropdownButtonFormField(
                              menuMaxHeight: 350,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder()),
                              hint: const Text('Select Location'),
                              value: "40",
                              items: controller.locations!
                                  .map((location) => DropdownMenuItem(
                                        value: location.locationId,
                                        child:
                                            Text(location.locationName ?? ''),
                                      ))
                                  .toList(),
                              onChanged: (v) {
                                controller.selectedLocation = v;
                              })),
                  const SizedBox(height: 16),
                  controller.productImage == null ||
                          controller.imageBytes == null
                      ? ElevatedButton(
                          onPressed: controller.onPickImage,
                          child: const Text('Upload Image'))
                      : Image.memory(controller.imageBytes!),
                  const SizedBox(height: 16),
                  MyButton(
                      tittle: 'Add Property', onPressed: controller.addProduct),
                  const SizedBox(
                    height: 50,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
