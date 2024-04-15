import 'package:ecom_2/app/constants.dart';
import 'package:ecom_2/app/model/property.dart';
import 'package:ecom_2/app/modules/admin_products/controllers/admin_products_controller.dart';
import 'package:ecom_2/app/routes/app_pages.dart';
import 'package:ecom_2/app/utils/memoryManagement.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminProductCard extends StatelessWidget {
  final Property property;
  const AdminProductCard({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.DETAILED_PRODUCT, arguments: property);
      },
      child: Container(
        height: 75,
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 2,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
            // border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            Image.network(
              getImageUrl(property.imageUrl),
              width: 75,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              property.propertyName ?? '',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const Spacer(),
            MemoryManagement.getAccessRole() == 'admin' &&
                    property.isVerified == "pending"
                ? ElevatedButton(
                    onPressed: () {
                      VerifyPropertyDialog(propertyId: property.propertyId!);
                    },
                    child: Text("verify"))
                : SizedBox(
                    height: 0,
                  ),
            MemoryManagement.getAccessRole() == 'admin' &&
                    property.isVerified == "verified"
                ? Icon(Icons.verified)
                : SizedBox(),
            const Spacer(),
            MemoryManagement.getAccessRole() == 'admin'
                ? IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) => DeleteProductDialog(
                                productId: property.propertyId ?? '',
                              ));
                    },
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  )
                : SizedBox()
          ],
        ),
      ),
    );
  }
}

class DeleteProductDialog extends StatelessWidget {
  final String productId;
  const DeleteProductDialog({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<AdminProductsController>();
    // var controller = Get.put(AdminProductsController());
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Are you sure you want to delete it?',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                    onPressed: () {
                      controller.onDeleteClicked(productId: productId);
                      Get.back();
                    },
                    child: const Text('Yes')),
                TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text('No'))
              ],
            )
          ],
        ),
      ),
    );
  }
}

class VerifyPropertyDialog extends StatelessWidget {
  final String propertyId;
  const VerifyPropertyDialog({super.key, required this.propertyId});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<
        AdminProductsController>(); // Assuming a PropertyController exists
    // var controller = Get.put(PropertyController()); // Use if the controller is not previously created

    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Are you sure you want to verify this property?',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () {
                    // controller.onVerifyClicked(
                    //     propertyId:
                    //         propertyId); // Method to verify the property
                    Get.back(); // Close the dialog
                  },
                  child:
                      const Text('Yes', style: TextStyle(color: Colors.green)),
                ),
                TextButton(
                  onPressed: () {
                    Get.back(); // Close the dialog without doing anything
                  },
                  child: const Text('No', style: TextStyle(color: Colors.red)),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
