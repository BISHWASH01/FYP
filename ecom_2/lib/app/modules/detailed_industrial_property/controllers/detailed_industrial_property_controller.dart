import 'dart:convert';

import 'package:ecom_2/app/constants.dart';
import 'package:ecom_2/app/model/industrial.dart';
import 'package:ecom_2/app/model/rating.dart';
import 'package:ecom_2/app/utils/memoryManagement.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class DetailedIndustrialPropertyController extends GetxController {
  //TODO: Implement DetailedIndustrialPropertyController
  List<Rating> ratings = [];
  var property = Get.arguments as Industrial;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    fetchReviews(property.propertyId);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
  fetchReviews(String? propertyId) async {
    try {
      var url = Uri.http(ipAddress, 'ecom_api/getProductRatings');

      var response = await http.post(url, body: {"propertyID": propertyId});

      var result = jsonDecode(response.body);
      print(response.body);

      if (result['success']) {
        // ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
        //   content: const Text('Rating and review fetched successfully',
        //       style: TextStyle(color: Colors.white)),
        //   backgroundColor: Colors.green,
        //   action: SnackBarAction(
        //     label: 'Undo',
        //     textColor: Colors.white,
        //     onPressed: () {},
        //   ),
        // ));
        ratings = ratingFromJson(jsonEncode(result['ratings'])).obs;
        update();
        return ratings;
      } else {
        ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text(result['message'],
              style: const TextStyle(color: Colors.white)),
          backgroundColor: Colors.red,
        ));
      }
    } catch (e) {
      // print(e);
      ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(
        content:
            Text('Something went wrong', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.red,
      ));
    }
  }

  void giveRating(
      {required double rating,
      required String review,
      required String propertyID}) async {
    try {
      var url =
          Uri.http(ipAddress, 'ecom_api/addRating'); // Correct API endpoint

      // Assuming the token retrieval and body content match your API requirements
      var response = await http.post(url, body: {
        "rating": rating.toString(),
        "review": review,
        "token": MemoryManagement.getAccessToken(),
        "propertyID": propertyID
      });

      var result = jsonDecode(response.body);

      if (result['success']) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: const Text('Rating and review submitted successfully',
              style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.green,
          action: SnackBarAction(
            label: 'Undo',
            textColor: Colors.white,
            onPressed: () {},
          ),
        ));
        fetchReviews(propertyID);
        update();
      } else {
        ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text(result['message'],
              style: const TextStyle(color: Colors.white)),
          backgroundColor: Colors.red,
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(
        content:
            Text('Something went wrong', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.red,
      ));
    }
  }
}
