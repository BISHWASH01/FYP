import 'package:ecom_2/app/constants.dart';
import 'package:ecom_2/app/model/property.dart';
import 'package:ecom_2/app/routes/app_pages.dart';
// import 'package:ecom_2/app/modules/UserPropertyListing/controllers/user_property_listing_controller.dart';
// import 'package:ecom_2/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

import '../controllers/user_detail_property_controller.dart';

// class UserDetailPropertyView extends GetView<UserDetailPropertyCconst UserDetailPropertyView({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     var product = Get.arguments as Product;
//     var userPropertyListingController =
//         Get.find<UserPropertyListingController>();
//     return Scaffold(
//         appBar: AppBar(
//           title: Text(product.title?.toUpperCase() ?? ''),
//           centerTitle: true,
//         ),
//         body: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Hero(
//                     tag: 'product+${product.productId}',
//                     child: Image.network(
//                       width: double.infinity,
//                       height: Get.height * 0.4,
//                       getImageUrl(product.imageUrl ?? ''),
//                       fit: BoxFit.cover,
//                     )),
//                 Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         product.title?.toUpperCase() ?? '',
//                         style: const TextStyle(fontSize: 20),
//                       ),
//                       Text(
//                         'Rs ${product.price?.toString()}',
//                         style: const TextStyle(fontSize: 20),
//                       ),
//                       Text(
//                         'Description : ${product.description?.toString()}',
//                         style: const TextStyle(fontSize: 20),
//                       ),
//                     ],
//                   ),
//                 )
//               ],
//             )
//           ],
//         ));
//   }
// }
class UserDetailPropertyView extends GetView<UserDetailPropertyController> {
  const UserDetailPropertyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var property = Get.arguments as Property?;

    return GetBuilder<UserDetailPropertyController>(
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: Text(property?.title?.toUpperCase() ?? ''),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: 'product+${property?.propertyId}',
                child: Image.network(
                  width: double.infinity,
                  height: Get.height * 0.4,
                  getImageUrl(property?.imageUrl ?? ''),
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      property?.propertyName?.toUpperCase() ?? '',
                      style: const TextStyle(fontSize: 20),
                    ),
                    Text(
                      'Rs ${property?.price}',
                      style: const TextStyle(fontSize: 20),
                    ),
                    Text(
                      'Location : ${property?.locationName}',
                      style: const TextStyle(fontSize: 20),
                    ),
                    Text(
                      'Description : ${property?.propertyDescription}',
                      style: const TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (property?.isVerified == '0')
                ElevatedButton(
                  onPressed: () async {
                    KhaltiScope.of(Get.context!).pay(
                      preferences: [
                        PaymentPreference.khalti,
                        PaymentPreference.connectIPS
                      ],
                      config: PaymentConfig(
                        amount: 10000,
                        productIdentity: property!.propertyId.toString(),
                        productName: "product",
                      ),
                      onSuccess: (PaymentSuccessModel v) {
                        controller.makePayment(
                          total: (v.amount / 100).toString(),
                          productID: property.propertyId.toString(),
                          otherData: v.toString(),
                        );
                        // property.isVerified = '1'; // Update isVerified directly
                      },
                      onFailure: (v) {
                        Get.showSnackbar(const GetSnackBar(
                          backgroundColor: Colors.red,
                          message: 'Payment failed!',
                          duration: Duration(seconds: 3),
                        ));
                      },
                      onCancel: () {
                        Get.showSnackbar(const GetSnackBar(
                          backgroundColor: Colors.red,
                          message: 'Payment cancelled!',
                          duration: Duration(seconds: 3),
                        ));
                      },
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/KhaltiLogo.png', height: 40),
                      const Text('Verify'),
                    ],
                  ),
                ),
              ElevatedButton(
                onPressed: () {
                  Get.toNamed(Routes.USER_PROPERTY_EDIT,
                      arguments: property?.propertyId);
                },
                child: const Text('Edit Property'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
