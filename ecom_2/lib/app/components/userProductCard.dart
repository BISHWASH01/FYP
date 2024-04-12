import 'package:ecom_2/app/constants.dart';
import 'package:ecom_2/app/model/property.dart';
import 'package:ecom_2/app/modules/User_Favourites/controllers/user_favourites_controller.dart';
import 'package:ecom_2/app/modules/cart/controllers/cart_controller.dart';
import 'package:ecom_2/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class userProductCard extends StatelessWidget {
  final Property property;
  const userProductCard({Key? key, required this.property}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var userFavController = Get.put(UserFavouritesController());

    return Padding(
      padding: EdgeInsets.all(5),

      // Wrap the ProductCard with Container
      // height: 100, // Set an explicit height
      child: GestureDetector(
        onTap: () {
          Get.toNamed(Routes.DETAILED_PRODUCT, arguments: property);
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
                                property.title?.toUpperCase() ?? '',
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
                              InkWell(
                                onTap: () {
                                  userFavController.addUserfav(
                                      product: property);
                                  // cartController.addProduct(product: product);
                                },
                                child: const Icon(Icons.add_circle),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Positioned(
            //   right: 0,
            //   child: IconButton(
            //     onPressed: () {
            //       isFavourite.value = !isFavourite.value;
            //     },
            //     icon: Obx(
            //       () => Icon(
            //         isFavourite.value ? Icons.favorite : Icons.favorite_outline,
            //         color: Colors.white,
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
