import 'dart:convert';
import 'dart:typed_data';

import 'package:ecom_2/app/constants.dart';
import 'package:ecom_2/app/model/category.dart';
import 'package:ecom_2/app/model/location.dart';
import 'package:ecom_2/app/modules/UserPropertyListing/controllers/user_property_listing_controller.dart';
import 'package:ecom_2/app/modules/UserPropertyListing/views/user_property_listing_view.dart';
import 'package:ecom_2/app/modules/main/controllers/main_controller.dart';
import 'package:ecom_2/app/utils/memoryManagement.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class UserAddPropertyController extends GetxController {
  var addFlatFormKey = GlobalKey<FormState>();
  var addPHouseFormKey = GlobalKey<FormState>();
  var addEmptyFormKey = GlobalKey<FormState>();

  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  var priceController = TextEditingController();
  XFile? productImage;
  Uint8List? imageBytes;
  final ImagePicker picker = ImagePicker();

  String? selectedCategory;
  List<Category>? categories;
  String? selectedLocation = "40";
  List<Location>? locations;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    getCategories();
    getLocations();
    // selectedLocation = locations != null && locations!.isNotEmpty
    //     ? locations!.first.locationId
    //     : null;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
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

  void getLocations() async {
    try {
      var url = Uri.http(ipAddress, 'ecom_api/getLocation');

      var response = await http.get(
        url,
      );

      var result = jsonDecode(response.body);

      if (result['success']) {
        locations = locationFromJson(jsonEncode(result['locations']));
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

  void onPickImage() async {
    try {
      productImage = await picker.pickImage(source: ImageSource.gallery);
      imageBytes = await productImage!.readAsBytes();
      update();
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  void addProduct(String propertyType) async {
    print(selectedLocation);
    try {
      if (addEmptyFormKey.currentState!.validate()) {
        try {
          var url = Uri.http(ipAddress, 'ecom_api/addProperty');

          var request = http.MultipartRequest('POST', url);

          request.fields['propertyName'] = titleController.text;
          request.fields['propertyDescription'] = descriptionController.text;
          request.fields['price'] = priceController.text;
          request.fields['category'] = selectedCategory!;
          request.fields['location'] = selectedLocation!;
          request.fields['location'] = selectedLocation!;

          request.fields['token'] = MemoryManagement.getAccessToken()!;
          // request.fields['isVerified'] = "0";

          request.files.add(
            http.MultipartFile.fromBytes(
              'image',
              imageBytes!,
              filename: productImage!.name,
            ),
          );

          var responseData = await request.send();

          var response = await http.Response.fromStream(responseData);

          // var response = await http.post(url, body: {
          //   'title': titleController.text,
          //   'description': descriptionController.text,
          //   'price': priceController.text,
          //   'category': selectedCategory,
          //   'token': MemoryManagement.getAccessToken()
          //   // 'token':prefs.getString('token')
          // });

          var result = jsonDecode(response.body);

          if (result['success']) {
            // Get.close(1);
            // getProducts();
            // Get.showSnackbar(GetSnackBar(
            //   backgroundColor: Colors.green,
            //   message: result['message'],
            //   duration: const Duration(seconds: 3),
            // ));
            // Get.put(UserPropertyListingController()).fetchUserProducts;
            _showSuccessDialog();
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
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  void clearFields() {
    titleController.clear();
    descriptionController.clear();
    priceController.clear();
    productImage = null;
    imageBytes = null;

    update();
  }

  void _showSuccessDialog() {
    Get.dialog(
      AlertDialog(
        title: Text('Product Added'),
        content: Text('Your product has been successfully added.'),
        actions: <Widget>[
          TextButton(
            child: Text('Add Another'),
            onPressed: () {
              // Clear the fields and close the dialog
              clearFields();
              Get.back();
            },
          ),
          TextButton(
            child: Text('View Products'),
            onPressed: () {
              Get.close(1);
              Get.find<MainController>().navigateToUserPropertyListing();
            },
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }
}
