import 'package:ecom_2/app/components/product_card.dart';
import 'package:ecom_2/app/components/userProductCard.dart';
import 'package:ecom_2/app/constants.dart';
import 'package:ecom_2/app/model/property.dart';
import 'package:ecom_2/app/modules/User_Favourites/controllers/user_favourites_controller.dart';
import 'package:ecom_2/app/modules/cart/views/cart_view.dart';
import 'package:ecom_2/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/user_property_listing_controller.dart';

class UserPropertyListingView extends GetView<UserPropertyListingController> {
  @override
  final UserPropertyListingController controller =
      Get.put(UserPropertyListingController());

  UserPropertyListingView({Key? key}) : super(key: key);

  // @override
  // Widget build(BuildContext context) {
  //   controller.fetchUserProducts();
  //   return Scaffold(
  //       appBar: AppBar(
  //         title: const Text('UserPropertyListingView'),
  //         centerTitle: true,
  //       ),
  //       body: GetBuilder<UserPropertyListingController>(builder: (controller) {
  //         if (controller.userProducts == null) {
  //           return const Center(
  //             child: CircularProgressIndicator(),
  //           );
  //         }
  //         return Padding(
  //           padding: EdgeInsets.all(16.0),
  //           child: Column(
  //             children: [
  //               SizedBox(
  //                 height: 200,
  //                 child: ListView.builder(
  //                     itemBuilder: (context, index) => ProductCard(
  //                           product: controller.userProducts[index],
  //                         )),
  //               )
  //             ],
  //           ),
  //         );
  //       }));
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Products'),
        centerTitle: true,
      ),
      body: Obx(() {
        controller.fetchUserProducts;
        if (controller.userProducts.isEmpty) {
          return Center(child: Text("No products found"));
        } else {
          return Padding(
            padding: EdgeInsets.all(16.0),
            child: ListView.builder(
              itemCount: controller.userProducts.length,
              itemBuilder: (context, index) {
                var product = controller.userProducts[index];
                return UserProductCard(
                    property: product); // Your custom product card widget
              },
            ),
          );
        }
      }),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 60.0),
        child: FloatingActionButton(
          onPressed: () {
            Get.toNamed(Routes.USER_ADD_PROPERTY);
          },
          child: Icon(Icons.add),
          tooltip: 'List a new product',
        ),
      ),
    );
  }
}

class UserProductCard extends StatelessWidget {
  final Property property;

  const UserProductCard({Key? key, required this.property}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: GestureDetector(
        onTap: () {
          Get.toNamed(Routes.USER_DETAIL_PROPERTY, arguments: property);
        },
        child: Stack(
          children: [
            Container(
              height: 300,
              width: 300,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      width: 150,
                      height: 50,
                      child: Hero(
                        tag: 'product+${property.propertyId}',
                        child: Image.network(
                          getImageUrl(property.imageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                property.propertyName?.toUpperCase() ?? '',
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Rs${property.price ?? ''}',
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              // InkWell(
                              //   onTap: () {
                              //     UserFavouritesController.addUserfav(
                              //         product: product);
                              //     // cartController.addProduct(product: product);
                              //   },
                              //   child: const Icon(Icons.add_circle),
                              // ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
