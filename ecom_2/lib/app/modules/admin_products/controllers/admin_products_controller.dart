import 'dart:convert';
import 'package:ecom_2/app/constants.dart';
import 'package:ecom_2/app/model/property.dart';
import 'package:ecom_2/app/modules/home/controllers/home_controller.dart';
import 'package:ecom_2/app/utils/memoryManagement.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AdminProductsController extends GetxController {
  Property? property;

  void onAdd() {
    // showDialog(
    //     context: Get.context!, builder: (context) => const AddProductPopup());
  }

  void onDeleteClicked({required String productId}) async {
    try {
      var url = Uri.http(ipAddress, 'ecom_api/deleteProperty');
      // await Future.delayed(const Duration(seconds: 3));
      // print(productId);

      var response = await http.post(url, body: {
        'propertyID': productId,
        'token': MemoryManagement.getAccessToken()
      });

      var result = jsonDecode(response.body);

      if (result['success']) {
        Get.back();
        Get.showSnackbar(GetSnackBar(
          backgroundColor: Colors.green,
          message: result['message'],
          duration: const Duration(seconds: 3),
        ));
        var homeController = Get.put(HomeController());
        homeController.getProducts();
        update();
      } else {
        Get.showSnackbar(GetSnackBar(
          backgroundColor: Colors.red,
          message: result['message'],
          duration: const Duration(seconds: 3),
        ));
      }
    } catch (e) {
      // print(e);
      Get.showSnackbar(const GetSnackBar(
        backgroundColor: Colors.red,
        message: 'Something went wrong',
        duration: Duration(seconds: 3),
      ));
    }
  }

  getProperty() async {}

  verifyProperty(String propertyID) async {
    try {
      var url = Uri.http(ipAddress, 'ecom_api/verifyProduct');
      // await Future.delayed(const Duration(seconds: 3));

      var response = await http.post(url, body: {
        'product_id': propertyID,
        'token': MemoryManagement.getAccessToken()
      });

      var result = jsonDecode(response.body);

      if (result['success']) {
        Get.back();
        Get.showSnackbar(GetSnackBar(
          backgroundColor: Colors.green,
          message: result['message'],
          duration: const Duration(seconds: 3),
        ));
        var homeController = Get.put(HomeController());
        homeController.getProducts();
        update();
      } else {
        Get.showSnackbar(GetSnackBar(
          backgroundColor: Colors.red,
          message: result['message'],
          duration: const Duration(seconds: 3),
        ));
      }
    } catch (e) {
      // print(e);
      Get.showSnackbar(const GetSnackBar(
        backgroundColor: Colors.red,
        message: 'Something went wrong',
        duration: Duration(seconds: 3),
      ));
    }
  }
}
