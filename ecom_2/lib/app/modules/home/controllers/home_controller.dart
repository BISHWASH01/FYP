import 'dart:convert';

// import 'package:ecom_2/app/components/addProductPopup.dart';
import 'package:ecom_2/app/constants.dart';
import 'package:ecom_2/app/model/category.dart';
import 'package:ecom_2/app/model/commercial.dart';
import 'package:ecom_2/app/model/industrial.dart';
import 'package:ecom_2/app/model/land.dart';
import 'package:ecom_2/app/model/property.dart';
import 'package:ecom_2/app/model/residential.dart';
import 'package:ecom_2/app/model/user.dart';

import 'package:ecom_2/app/routes/app_pages.dart';
import 'package:ecom_2/app/utils/memoryManagement.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:get/get.dart';
// import 'package:get/get_connect/http/src/request/request.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  Map<String, List<dynamic>> propertyByCategory = {};
  late final SharedPreferences prefs;
  List<Category>? categories;
  List<Property>? properties;
  List<Property>? featuredProperties;
  List<Land>? landProperty;
  List<Residential>? residentialProperty;
  List<Commercial>? commercialProperty;
  List<Industrial>? industrialProperty;

  final count = 0.obs;
  var addCategoryFormKey = GlobalKey<FormState>();
  User? user;
  var showCategories = false.obs;

  showCategory() {
    if (showCategories == true.obs) {
      showCategories = false.obs;
    } else {
      showCategories = true.obs;
    }
    update();
  }

  var categoryNameController = TextEditingController();

  @override
  void onInit() async {
    super.onInit();
    prefs = await SharedPreferences.getInstance();
    getCategories();
    getProducts();
    fetchCategoriesAndProducts();
    getuser();
  }

  @override
  void onReady() {
    super.onReady();
    getuser();
  }

  void getCategories() async {
    try {
      var url = Uri.http(ipAddress, 'ecom_api/getCategory');
      // await Future.delayed(const Duration(seconds: 3));

      var response = await http.get(
        url,
      );

      var result = jsonDecode(response.body);

      if (result['success']) {
        // Get.showSnackbar(GetSnackBar(
        //   backgroundColor: Colors.green,
        //   message: result['message'],
        //   duration: const Duration(seconds: 3),
        // ));
        categories = categoryFromJson(jsonEncode(result['categories']));
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

  void addCategory() async {
    try {
      if (addCategoryFormKey.currentState!.validate()) {
        try {
          var url = Uri.http(ipAddress, 'ecom_api/addCategory');

          var response = await http.post(url, body: {
            'title': categoryNameController.text,
            'token': MemoryManagement.getAccessToken()
          });

          var result = jsonDecode(response.body);

          if (result['success']) {
            Get.back();
            getCategories();
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
          Get.showSnackbar(const GetSnackBar(
            backgroundColor: Colors.red,
            message: 'Something went wrong',
            duration: Duration(seconds: 3),
          ));
        }
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  void onLogout() async {
    // await prefs.remove('token');
    MemoryManagement.removeAll();
    Get.offAllNamed(Routes.LOGIN);
  }

  void getProducts() async {
    try {
      var url = Uri.http(ipAddress, 'ecom_api/getProperty');
      var response = await http.get(url);

      var result = jsonDecode(response.body);

      if (result['success']) {
        // Get.showSnackbar(GetSnackBar(
        //   backgroundColor: Colors.green,
        //   message: result['message'],
        //   duration: const Duration(seconds: 3),
        // ));

        properties = propertyFromJson(
          jsonEncode(result['products']),
        );
        update();
      }
    } catch (e) {
      // print(e);

      Get.showSnackbar(GetSnackBar(
        backgroundColor: Colors.red,
        message: e.toString(),
        duration: const Duration(seconds: 3),
      ));
    }
  }

  void fetchCategoriesAndProducts() async {
    // Fetch categories
    categories = await fetchCategoryFromServer();
    fetchProductsFromServer();

    // Fetch products
    // List<Property> properties = await fetchProductsFromServer();
    // landProperty
    //     ?.assignAll(properties.where((p) => p.propertyType == 'land').toList());
    // residentialProperty?.assignAll(
    //     properties.where((p) => p.propertyType == 'residential').toList());
    // commercialProperty?.assignAll(
    //     properties.where((p) => p.propertyType == 'commercial').toList());
    // industrialProperty?.assignAll(
    //     properties.where((p) => p.propertyType == 'industrial').toList());

    // Organize products by category

    update();
  }

  fetchProductsFromServer() async {
    try {
      var url = Uri.http(ipAddress, 'ecom_api/getProperty');
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        // print(result['products']);
        List<Residential> residentialProperty =
            residentialFromJson(jsonEncode(result['residential']));
        List<Commercial> commercialProperty =
            commercialFromJson(jsonEncode(result['commercial']));
        List<Industrial> industrialProperty =
            industrialFromJson(jsonEncode(result['commercial']));
        List<Land> landProperty =
            landFromJson(jsonEncode(result['commercial']));

        for (var property in residentialProperty) {
          propertyByCategory.putIfAbsent(property.categoryId!, () => []);
          propertyByCategory[property.categoryId!]!.add(property);
        }

        update();
      } else {
        // Handle HTTP error
        print('HTTP error: ${response.statusCode}');
        Get.snackbar("Error", 'HTTP error: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      // Handle other errors, such as network errors or JSON parsing errors
      Get.snackbar("Error", e.toString());
      print(e);
      return [];
    }
  }

  Future<List<Category>> fetchCategoryFromServer() async {
    List<Category> categories = [];
    try {
      var url = Uri.http(ipAddress, 'ecom_api/getCategory');
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        if (result['success'] == true && result['categories'] != null) {
          // Directly parse the 'categories' part of the response
          categories = categoryFromJson(jsonEncode(result['categories']));
        } else {
          // print();
          Get.snackbar(
              "Error", 'Server returned an error: ${result['message']}');
        }
      } else {
        // Handle HTTP error

        Get.snackbar("Error", 'HTTP error: ${response.statusCode}');
      }
    } catch (e) {
      print(e);

      Get.snackbar("Error", e.toString());
    }

    // Notify listeners if you're using a state management solution like GetX
    update();

    return categories;
  }

  void getuser() async {
    try {
      var url = Uri.http(ipAddress, 'ecom_api/getUserDetail');
      var response = await http.post(url, body: {
        'token': MemoryManagement.getAccessToken(),
      });
      var result = jsonDecode(response.body);

      if (result['success']) {
        // print(result['data']);
        user = User.fromJson(result['data']);
        // print(user?.fullName);
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

      Get.snackbar("Error", e.toString());
    }
  }
}
