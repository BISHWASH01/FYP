import 'dart:convert';

import 'package:ecom_2/app/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class RegisterController extends GetxController {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var fullNameController = TextEditingController();
  var phoneNumberController = TextEditingController();

  var registerFormKey = GlobalKey<FormState>();

  final count = 0.obs;

  void onRegister() async {
    if (registerFormKey.currentState!.validate()) {
      try {
        var url = Uri.http(ipAddress, 'ecom_api/auth/register');

        var response = await http.post(url, body: {
          'fullName': fullNameController.text,
          'email': emailController.text,
          'password': passwordController.text,
          'phoneNumber': phoneNumberController.text
        });

        var result = jsonDecode(response.body);

        if (result['success']) {
          Get.back();
          Get.showSnackbar(GetSnackBar(
            backgroundColor: Colors.green,
            message: result['message'],
            duration: const Duration(seconds: 3),
          ));
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
    }
  }

  void increment() => count.value++;
}
