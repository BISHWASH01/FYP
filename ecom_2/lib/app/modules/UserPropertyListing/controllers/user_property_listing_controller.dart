import 'dart:convert';

import 'package:ecom_2/app/constants.dart';
import 'package:ecom_2/app/model/commercial.dart';
import 'package:ecom_2/app/model/industrial.dart';
import 'package:ecom_2/app/model/land.dart';
import 'package:ecom_2/app/model/property.dart';
import 'package:ecom_2/app/model/residential.dart';
import 'package:ecom_2/app/utils/memoryManagement.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class UserPropertyListingController extends GetxController {
  var userProducts = <Property>[].obs; // List to store user's products
  List<Residential> userResidentialProperty = [];
  List<Commercial> userCommercialProperty = [];
  List<Industrial> userIndustrialProperty = [];
  List<Land> userLandProperty = [];

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    fetchUserProducts();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // Method to fetch user's products (replace with your own logic)
  fetchUserProducts() async {
    try {
      var url = Uri.http(ipAddress, 'ecom_api/getUserPropertyListing');

      var response = await http.post(url, body: {
        'token': MemoryManagement.getAccessToken(),
      });

      var result = jsonDecode(response.body);

      if (result['success']) {
        // List<dynamic> fetchedProducts = result['products'];
        // var products =
        //     fetchedProducts.map((e) => Property.fromJson(e)).toList();
        // userProducts.assignAll(products);
        userResidentialProperty =
            residentialFromJson(jsonEncode(result['residential']));
        userCommercialProperty =
            commercialFromJson(jsonEncode(result['commercial']));
        userIndustrialProperty =
            industrialFromJson(jsonEncode(result['industrial']));
        userLandProperty = landFromJson(jsonEncode(result['land']));
        print(userResidentialProperty);
        print(userCommercialProperty);
        print(userIndustrialProperty);
        print(userLandProperty);

        update();
      } else {
        Get.showSnackbar(GetSnackBar(
          backgroundColor: Colors.red,
          message: result['message'],
          duration: const Duration(seconds: 3),
        ));
      }
    } catch (e) {
      Get.showSnackbar(const GetSnackBar(
        backgroundColor: Colors.red,
        message: 'Something went wrong',
        duration: Duration(seconds: 3),
      ));
    }
  }

  // Method to add a new product
  void addProduct(Property property) {
    // Example: Add the new product to the user's products list
    userProducts.add(property);
  }
}
