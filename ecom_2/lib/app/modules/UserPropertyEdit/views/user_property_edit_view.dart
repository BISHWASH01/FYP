import 'package:ecom_2/app/modules/UserPropertyListing/controllers/user_property_listing_controller.dart';
import 'package:ecom_2/app/modules/main/controllers/main_controller.dart';
import 'package:ecom_2/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/user_property_edit_controller.dart';

class UserPropertyEditView extends GetView<UserPropertyEditController> {
  const UserPropertyEditView({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var productID = Get.arguments as String;
    final UserPropertyEditController controller =
        Get.put(UserPropertyEditController());
    controller.fetchProductDetails(int.parse(productID));

    return Scaffold(
        appBar: AppBar(
          title: const Text('Edit Product'),
          centerTitle: true,
        ),
        body: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    TextFormField(
                      controller: controller.titleController,
                      decoration: const InputDecoration(labelText: 'Title'),
                    ),
                    TextFormField(
                      controller: controller.descriptionController,
                      decoration:
                          const InputDecoration(labelText: 'Description'),
                    ),
                    TextFormField(
                      controller: controller.priceController,
                      decoration: const InputDecoration(labelText: 'Price'),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          await controller.updateProduct();
                        },
                        child: const Text('Update Property')),
                    ElevatedButton(
                        onPressed: () {
                          Get.dialog(
                            AlertDialog(
                              title: const Text(
                                  'Are you sure to delete this product?'),
                              content:
                                  const Text('You cannot undo this action'),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('No'),
                                  onPressed: () {
                                    Get.back();
                                  },
                                ),
                                TextButton(
                                  child: const Text('Yes'),
                                  onPressed: () {
                                    controller.deleteProduct();
                                    Get.find<UserPropertyListingController>()
                                        .fetchUserProducts();
                                    Get.back();
                                    Get.toNamed(Routes.MAIN);
                                  },
                                ),
                              ],
                            ),
                            barrierDismissible: false,
                          );
                        },
                        child: const Text('Delete Property'))
                  ],
                ),
              ),
            );
          }
        }));
  }
}
