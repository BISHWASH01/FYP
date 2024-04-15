import 'dart:convert';

import 'package:ecom_2/app/constants.dart';
import 'package:ecom_2/app/model/property.dart';
import 'package:ecom_2/app/modules/main/controllers/main_controller.dart';
import 'package:ecom_2/app/utils/memoryManagement.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class UserPropertyEditController extends GetxController {
  var product =
      Rx<Property?>(null); // Initialize with null or a default product
  var isLoading = false.obs;
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  var priceController = TextEditingController();

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void fetchProductDetails(int productId) async {
    isLoading(true);
    try {
      // Fetch product details from API
      var url = Uri.http(ipAddress, 'ecom_api/getPropertyDetail');
      var response = await http.post(url, body: {
        'token': MemoryManagement.getAccessToken(),
        'propertyID': productId.toString()
      });
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        product.value =
            propertyFromJson(jsonEncode(jsonData['productDetail']))[0];
        // Update text controllers
        titleController.text = product.value!.propertyName.toString();
        descriptionController.text =
            product.value!.propertyDescription.toString();
        priceController.text = product.value!.price.toString();
      } else {
        Get.snackbar('Error', 'Failed to fetch product details');
      }
    } catch (e) {
      print(e);
      Get.snackbar('Error', 'An error occurred');
    } finally {
      isLoading(false);
    }
  }

  updateProduct() async {
    isLoading(true);
    try {
      // Send updated details to API
      var url = Uri.http(ipAddress, 'ecom_api/updateProperty');
      var response = await http.post(url, body: {
        'title': titleController.text,
        'description': descriptionController.text,
        'price': priceController.text,
        'propertyID': product.value?.propertyId.toString(),
      });
      var result = jsonDecode(response.body);
      if (result['success']) {
        Get.back(); // Go back to the previous screen or to the list
        Get.snackbar('Success', 'Product updated successfully');
      } else {
        Get.snackbar('Error', result['message']);
      }
    } catch (e) {
      print(e);
      Get.snackbar('Error', 'An error occurred');
    } finally {
      isLoading(false);
    }
  }

  deleteProduct() async {
    isLoading(true);
    try {
      // Send updated details to API
      var url = Uri.http(ipAddress, 'ecom_api/deleteProduct');
      var response = await http.post(url, body: {
        'token': MemoryManagement.getAccessToken(),
        'product_id': product.value?.propertyId.toString(),
      });
      var result = jsonDecode(response.body);
      if (result['success']) {
        // Get.back();
        Get.snackbar('Success', 'Product updated successfully');
        update();
        return;
      } else {
        Get.snackbar('Error', result['message']);
      }
    } catch (e) {
      print(e);
      Get.snackbar('Error', 'An error occurred');
    } finally {
      isLoading(false);
    }
  }
}
