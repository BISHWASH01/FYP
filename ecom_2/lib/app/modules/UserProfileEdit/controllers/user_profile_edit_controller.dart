import 'dart:convert';

import 'package:ecom_2/app/constants.dart';
import 'package:ecom_2/app/model/user.dart';
import 'package:ecom_2/app/utils/memoryManagement.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class UserProfileEditController extends GetxController {
  User? user;
  var fullNameController = TextEditingController();
  var phoneNumberController = TextEditingController();
  var oldPasswordController = TextEditingController();
  var newPasswordController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchUserProfile();
  }

  fetchUserProfile() async {
    try {
      // Send updated details to API
      var url = Uri.http(ipAddress, 'ecom_api/getUserDetail');
      var response = await http.post(url, body: {
        'token': MemoryManagement.getAccessToken(),
      });
      var result = jsonDecode(response.body);
      print(result);
      if (result['success']) {
        user = User.fromJson(result['data']);
        fullNameController.text = user!.fullName!;
        phoneNumberController.text = user!.phoneNumber!;
      } else {
        Get.snackbar('Error', result['message']);
      }
    } catch (e) {
      print(e);
      Get.snackbar('Error', 'An error occurred');
    }
  }

  updateUserDetail() async {
    try {
      // Send updated details to API
      var url = Uri.http(ipAddress, 'ecom_api/updateUserProfile');
      var response = await http.post(url, body: {
        'token': MemoryManagement.getAccessToken(),
        'fullName': fullNameController.text,
        'phoneNumber': phoneNumberController.text,
      });
      var result = jsonDecode(response.body);
      if (result['success']) {
        Get.back(); // Go back to the previous screen or to the list
        Get.snackbar('Success', 'Profile updated successfully');
      } else {
        Get.snackbar('Error', result['message']);
      }
    } catch (e) {
      print(e);
      Get.snackbar('Error', 'An error occurred');
    }
  }

  updateUserPassword() async {
    try {
      // Send updated details to API
      var url = Uri.http(ipAddress, 'ecom_api/updateUserProfile');
      var response = await http.post(url, body: {
        'token': MemoryManagement.getAccessToken(),
        'oldPassword': oldPasswordController.text,
        'newPassword': newPasswordController.text,
      });
      var result = jsonDecode(response.body);
      print(result);
      if (result['success']) {
        Get.back(); // Go back to the previous screen or to the list
        Get.snackbar('Success', 'Password updated successfully');
      } else {
        Get.snackbar('Error', result['message']);
      }
    } catch (e) {
      print(e);
      Get.snackbar('Error', 'An error occurred');
    }
  }
}
