import 'package:ecom_2/app/components/addProductPopup.dart';
import 'package:ecom_2/app/modules/UserAddProperty/views/user_add_property_view.dart';
import 'package:ecom_2/app/modules/UserPropertyListing/views/user_property_listing_view.dart';
import 'package:ecom_2/app/modules/User_Favourites/views/user_favourites_view.dart';
import 'package:ecom_2/app/modules/cart/views/cart_view.dart';
import 'package:ecom_2/app/modules/home/views/home_view.dart';
import 'package:ecom_2/app/modules/order/views/order_view.dart';
import 'package:ecom_2/app/modules/profile/views/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  List<Widget> screens = [
    const HomeView(),
    const UserFavouritesView(),
    UserPropertyListingView(),
    const UserAddPropertyView()
    // const AddProductPopup()
  ];

  var currentIndex = 0.obs;

  final count = 0.obs;

  void increment() => count.value++;
  void navigateToUserPropertyListing() {
    currentIndex.value = 2;
  }
}
