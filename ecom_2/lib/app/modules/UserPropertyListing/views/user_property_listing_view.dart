import 'package:ecom_2/app/constants.dart';
import 'package:ecom_2/app/model/commercial.dart';
import 'package:ecom_2/app/model/industrial.dart';
import 'package:ecom_2/app/model/land.dart';
import 'package:ecom_2/app/model/property.dart';
import 'package:ecom_2/app/model/residential.dart';

import 'package:ecom_2/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/user_property_listing_controller.dart';

class UserPropertyListingView extends GetView<UserPropertyListingController> {
  @override
  final UserPropertyListingController controller =
      Get.put(UserPropertyListingController());

  UserPropertyListingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Your Products'),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Residential'),
              Tab(text: 'Commercial'),
              Tab(text: 'Industrial'),
              Tab(text: 'Land'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            GetBuilder<UserPropertyListingController>(builder: (controller) {
              if (controller.userResidentialProperty.isEmpty) {
                return const Center(child: Text("No products found"));
              }

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView.builder(
                  itemCount: controller.userResidentialProperty.length,
                  itemBuilder: (context, index) {
                    var product = controller.userResidentialProperty[index];
                    return UserResidentialPropertyCard(
                        property: product); // Your custom product card widget
                  },
                ),
              );
            }),
            GetBuilder<UserPropertyListingController>(builder: (controller) {
              if (controller.userCommercialProperty.isEmpty) {
                return const Center(child: Text("No products found"));
              }

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView.builder(
                  itemCount: controller.userCommercialProperty.length,
                  itemBuilder: (context, index) {
                    var product = controller.userCommercialProperty[index];
                    return UserCommercialPropertyCard(
                        property: product); // Your custom product card widget
                  },
                ),
              );
            }),
            GetBuilder<UserPropertyListingController>(builder: (controller) {
              if (controller.userResidentialProperty.isEmpty) {
                return const Center(child: Text("No products found"));
              }

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView.builder(
                  itemCount: controller.userIndustrialProperty.length,
                  itemBuilder: (context, index) {
                    var product = controller.userIndustrialProperty[index];
                    return UserIndustrialPropertyCard(
                        property: product); // Your custom product card widget
                  },
                ),
              );
            }),
            GetBuilder<UserPropertyListingController>(builder: (controller) {
              if (controller.userResidentialProperty.isEmpty) {
                return const Center(child: Text("No products found"));
              }

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView.builder(
                  itemCount: controller.userLandProperty.length,
                  itemBuilder: (context, index) {
                    var product = controller.userLandProperty[index];
                    return UserlandPropertyCard(
                        property: product); // Your custom product card widget
                  },
                ),
              );
            }),
          ],
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 60.0),
          child: FloatingActionButton(
            onPressed: () {
              Get.toNamed(Routes.USER_ADD_PROPERTY);
            },
            tooltip: 'List a new product',
            child: const Icon(Icons.add),
          ),
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

class UserResidentialPropertyCard extends StatelessWidget {
  final Residential property;

  const UserResidentialPropertyCard({Key? key, required this.property})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: GestureDetector(
        onTap: () {
          Get.toNamed(Routes.DETAILED_RESIDENTIAL_PROPERTY,
              arguments: property);
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

class UserCommercialPropertyCard extends StatelessWidget {
  final Commercial property;

  const UserCommercialPropertyCard({Key? key, required this.property})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: GestureDetector(
        onTap: () {
          Get.toNamed(Routes.DETAILED_COMMERCIAL_PROPERTY, arguments: property);
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

class UserIndustrialPropertyCard extends StatelessWidget {
  final Industrial property;

  const UserIndustrialPropertyCard({Key? key, required this.property})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: GestureDetector(
        onTap: () {
          Get.toNamed(Routes.DETAILED_INDUSTRIAL_PROPERTY, arguments: property);
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

class UserlandPropertyCard extends StatelessWidget {
  final Land property;

  const UserlandPropertyCard({Key? key, required this.property})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: GestureDetector(
        onTap: () {
          Get.toNamed(Routes.DETAILED_LAND_PROPERTY, arguments: property);
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
