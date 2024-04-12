import 'dart:convert';

import 'package:ecom_2/app/constants.dart';
import 'package:ecom_2/app/utils/memoryManagement.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class MembershipController extends GetxController {
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

  void makePayment(
      {required String total,
      required String userID,
      required String otherData}) async {
    try {
      var url = Uri.http(ipAddress, 'ecom_api/makePayment');
      print(otherData);

      var response = await http.post(url, body: {
        'token': MemoryManagement.getAccessToken(),
        'total': total,
        'userID': userID,
        'otherData': otherData,
      });

      print(response.body);

      var result = jsonDecode(response.body);

      if (result['success']) {
        Get.showSnackbar(GetSnackBar(
          backgroundColor: Colors.green,
          message: result['message'],
          duration: const Duration(seconds: 3),
        ));
        update();
      } else {
        Get.showSnackbar(GetSnackBar(
          backgroundColor: Colors.red,
          message: result['message'],
          duration: const Duration(seconds: 3),
        ));
      }
    } catch (e) {
      print(e);
      Get.showSnackbar(const GetSnackBar(
        backgroundColor: Colors.red,
        message: 'Something went wrong',
        duration: Duration(seconds: 3),
      ));
    }
    return null;
  }
}
