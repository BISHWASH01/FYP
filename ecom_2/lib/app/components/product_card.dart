import 'package:ecom_2/app/constants.dart';
import 'package:ecom_2/app/model/property.dart';
import 'package:ecom_2/app/modules/User_Favourites/controllers/user_favourites_controller.dart';
import 'package:ecom_2/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// class ProductCard extends StatelessWidget {
//   final Property property;
//   const ProductCard({Key? key, required this.property}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     // var cartController = Get.find<CartController>();

//     var userFavController = Get.put(UserFavouritesController());
//     // var isFavourite = false.obs;

//     return Padding(
//       padding: const EdgeInsets.all(5),

//       // Wrap the ProductCard with Container
//       // height: 100, // Set an explicit height
//       child: GestureDetector(
//         onTap: () {
//           Get.toNamed(Routes.DETAILED_PRODUCT, arguments: property);
//         },
//         child: Stack(
//           children: [
//             Container(
//               height: 300,
//               width: 300,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey.withOpacity(0.5),
//                     spreadRadius: 5,
//                     blurRadius: 7,
//                     offset: const Offset(0, 3),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 children: [
//                   Expanded(
//                     flex: 2,
//                     child: SizedBox(
//                       width: 150,
//                       height: 50,
//                       child: Hero(
//                         tag: 'product+${property.propertyId}',
//                         child: Image.network(
//                           getImageUrl(property.imageUrl),
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     flex: 1,
//                     child: Container(
//                       padding: const EdgeInsets.all(10),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             children: [
//                               Text(
//                                 property.propertyName?.toUpperCase() ?? '',
//                                 style: const TextStyle(
//                                   fontSize: 15,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 'रु ${property.price ?? ''}',
//                                 style: const TextStyle(
//                                   fontSize: 15,
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
//                               InkWell(
//                                 onTap: () {
//                                   userFavController.addUserfav(
//                                       product: property);
//                                   // cartController.addProduct(product: product);
//                                 },
//                                 child: const Icon(Icons.add_circle),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
class ProductCard extends StatelessWidget {
  final Property property;
  const ProductCard({Key? key, required this.property}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var userFavController = Get.put(UserFavouritesController());
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.DETAILED_PRODUCT, arguments: property);
      },
      child: Container(
        width: 250,
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(15.0)),
              child: Hero(
                tag: 'product+${property.propertyId}',
                child: Image.network(
                  getImageUrl(property.imageUrl),
                  fit: BoxFit.cover,
                  height: 150,
                  width: double.infinity,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    property.propertyName ?? '',
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'रु ${property.price ?? ''}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          userFavController.addUserfav(product: property);
                        },
                        child: const Icon(
                          Icons.favorite_border,
                          color: Colors.blue,
                        ),
                      ),
                    ],
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
