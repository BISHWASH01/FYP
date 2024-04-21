import 'dart:convert';
import 'dart:typed_data';

import 'package:ecom_2/app/constants.dart';
import 'package:ecom_2/app/model/category.dart';
import 'package:ecom_2/app/model/location.dart';
import 'package:ecom_2/app/model/type.dart';
import 'package:ecom_2/app/modules/UserPropertyListing/controllers/user_property_listing_controller.dart';
import 'package:ecom_2/app/modules/home/controllers/home_controller.dart';

import 'package:ecom_2/app/modules/main/controllers/main_controller.dart';
import 'package:ecom_2/app/utils/memoryManagement.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

enum PropertyType { residential, commercial, industrial, land }

class UserAddPropertyController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  // Residential
  TextEditingController bedroomsController = TextEditingController();
  TextEditingController bathroomsController = TextEditingController();
  TextEditingController sizeController = TextEditingController();
  TextEditingController parkingSpacesResidentialController =
      TextEditingController();

  // Commercial
  TextEditingController floorAreaController = TextEditingController();
  TextEditingController parkingSpacesCommercialController =
      TextEditingController();
  TextEditingController buildingClassController = TextEditingController();
  TextEditingController tenantCapacityController = TextEditingController();

  // Industrial
  TextEditingController industrialSizeController = TextEditingController();
  TextEditingController clearHeightController = TextEditingController();
  TextEditingController powerSupplyController = TextEditingController();

  // Land
  TextEditingController landSizeController = TextEditingController();
  TextEditingController landTypeController = TextEditingController();

  // Property Type Visibility
  bool showResidentialForm = false;
  bool showCommercialForm = false;
  bool showIndustrialForm = false;
  bool showLandForm = false;

  PropertyType? selectedPropertyType;

  // Toggle Property Forms
  void togglePropertyForm(PropertyType type) {
    selectedPropertyType = type;
    showResidentialForm = type == PropertyType.residential;
    showCommercialForm = type == PropertyType.commercial;
    showIndustrialForm = type == PropertyType.industrial;
    showLandForm = type == PropertyType.land;

    update(); // Notify listeners to rebuild GetBuilder
  }

  // Dropdown selections
  String? selectedCategory;
  String? selectedType;
  String? selectedLocation;
  // List<DropdownMenuItem<String>>? categoryItems =
  //     []; // Populate these in `onInit`
  // List<DropdownMenuItem<String>> typeItems = [];
  // List<DropdownMenuItem<String>> locationItems = [];

  List<Category> categories = [];
  List<Location> locations = [];
  List<Types> types = [];
  List<DropdownMenuItem<String>> get categoryItems {
    return categories.map((category) {
      return DropdownMenuItem<String>(
        value: category
            .categoryId, // Assuming id is a unique identifier for each category
        child:
            Text(category.categoryTitle!), // Assuming name is the display value
      );
    }).toList();
  }

  List<DropdownMenuItem<String>> get locationItems {
    return locations.map((location) {
      return DropdownMenuItem<String>(
        value:
            location.id, // Assuming id is a unique identifier for each location
        child: Text(
            "${location.name}, ${location.city}"), // Assuming name is the display value
      );
    }).toList();
  }

  List<DropdownMenuItem<String>> get typeItems {
    return types.map((type) {
      return DropdownMenuItem<String>(
        value: type.typeId,
        child: Text(type.typeName!),
      );
    }).toList();
  }

  XFile? propertyImage;
  Uint8List? imageBytes;
  final ImagePicker picker = ImagePicker();
  void onPickImage() async {
    try {
      propertyImage = await picker.pickImage(source: ImageSource.gallery);
      imageBytes = await propertyImage!.readAsBytes();
      update();
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  // String? selectedCategory;
  // String? selectedPropertyType;
  // List<Category>? categories;
  // String? selectedLocation = "40";

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    getCategories();
    getLocations();
    gettypes();
    // selectedLocation =
    //     locations != null && locations!.isNotEmpty ? locations!.first.id : null;
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
        // buildCategoryDropdownItems();
        print(categories);
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

  // Method to handle category selection
  void onCategorySelected(String? value) {
    selectedCategory = value;
    update();
  }

  // List<Location>? locations;

  void getLocations() async {
    try {
      var url = Uri.http(ipAddress, 'ecom_api/getLocation');

      var response = await http.get(
        url,
      );

      var result = jsonDecode(response.body);

      if (result['success']) {
        locations = locationFromJson(jsonEncode(result['locations']));
        // buildLocationDropdownItems();
        print(locations);
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

  void gettypes() async {
    try {
      var url = Uri.http(ipAddress, 'ecom_api/getTypes');

      var response = await http.get(
        url,
      );

      var result = jsonDecode(response.body);

      if (result['success']) {
        types = typesFromJson(jsonEncode(result['types']));
        // buildLocationDropdownItems();
        print(locations);
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

  // Method to handle location selection
  void onLocationSelected(String? value) {
    selectedLocation = value;
    update();
  }

  // Form Submission
  submitForm(PropertyType? selectedType) {
    try {
      if (formKey.currentState!.validate()) {
        if (selectedType == PropertyType.residential) {
          print("residential Submitted Successfully");
          addResidential();
        } else if (selectedType == PropertyType.commercial) {
          print("commercial Submitted Successfully");
          addCommercial();
        } else if (selectedType == PropertyType.industrial) {
          print("industrial Submitted Successfully");
          addIndustrial();
        } else if (selectedType == PropertyType.land) {
          print("land Submitted Successfully");
          addLand();
        }
      }
    } catch (e) {
      print("Failed to submit form: $e");
    }
  }

  void addResidential() async {
    print(selectedLocation);

    try {
      var url = Uri.http(ipAddress, 'ecom_api/addProperty/addResidential');

      var request = http.MultipartRequest('POST', url);

      request.fields['propertyName'] = titleController.text;
      request.fields['propertyDescription'] = descriptionController.text;
      request.fields['price'] = priceController.text;
      request.fields['category'] = selectedCategory!;
      request.fields['location'] = selectedLocation!;
      request.fields['location'] = selectedLocation!;
      request.fields['type'] = selectedType!;

      request.fields['bedrooms'] = bedroomsController.text;
      request.fields['bathrooms'] = bathroomsController.text;
      request.fields['size'] = sizeController.text;
      request.fields['parking_spaces'] =
          parkingSpacesResidentialController.text;

      request.fields['token'] = MemoryManagement.getAccessToken()!;
      // request.fields['isVerified'] = "0";

      request.files.add(
        http.MultipartFile.fromBytes(
          'image',
          imageBytes!,
          filename: propertyImage!.name,
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
        HomeController().onInit();
        Get.put(UserPropertyListingController()).fetchUserProducts;
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

  void addCommercial() async {
    print(selectedLocation);

    try {
      var url = Uri.http(ipAddress, 'ecom_api/addProperty/addCommercial');

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
          filename: propertyImage!.name,
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

  void addIndustrial() async {
    print(selectedLocation);

    try {
      var url = Uri.http(ipAddress, 'ecom_api/addProperty/addIndustrial');

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
          filename: propertyImage!.name,
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

  void addLand() async {
    print(selectedLocation);

    try {
      var url = Uri.http(ipAddress, 'ecom_api/addProperty/addLand');

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
          filename: propertyImage!.name,
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

  void clearFields() {
    titleController.clear();
    descriptionController.clear();
    priceController.clear();
    propertyImage = null;
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
