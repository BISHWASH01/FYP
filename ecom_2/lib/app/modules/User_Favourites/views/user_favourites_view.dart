import 'package:ecom_2/app/constants.dart';
import 'package:ecom_2/app/model/property.dart';
import 'package:ecom_2/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/user_favourites_controller.dart';

class UserFavouritesView extends GetView<UserFavouritesController> {
  const UserFavouritesView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('UserFavouritesView'),
          centerTitle: true,
        ),
        body: GetBuilder<UserFavouritesController>(
          builder: (controller) => Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    // height: 634.9091,
                    height: 1000,

                    child: ListView.builder(
                        itemCount: controller.userFav.length,
                        itemBuilder: (context, index) => UserFavCard(
                            favItem: controller.userFav[index], index: index)),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

class UserFavCard extends StatelessWidget {
  final FavItem favItem;
  final int index;
  const UserFavCard({super.key, required this.favItem, required this.index});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<UserFavouritesController>();
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            Get.toNamed(Routes.DETAILED_PRODUCT,
                arguments: Property.fromJson(favItem.product.toJson()));
          },
          child: Container(
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ]),
            margin: const EdgeInsets.only(bottom: 20),
            height: 110,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Image.network(
                    getImageUrl(favItem.product.imageUrl),
                    fit: BoxFit.cover,
                    height: double.infinity,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          favItem.product.propertyName ?? '',
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Price: ${favItem.product.price}',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Positioned(
          right: 0,
          child: IconButton(
            onPressed: () {
              controller.removeUserFav(index);
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ),
        )
      ],
    );
  }
}
