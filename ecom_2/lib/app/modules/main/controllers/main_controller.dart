import 'package:ecom_2/app/modules/UserAddProperty/views/user_add_property_view.dart';
import 'package:ecom_2/app/modules/UserPropertyListing/views/user_property_listing_view.dart';
import 'package:ecom_2/app/modules/UserSearchPage/views/user_search_page_view.dart';
import 'package:ecom_2/app/modules/User_Favourites/views/user_favourites_view.dart';
import 'package:ecom_2/app/modules/home/views/home_view.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  List<Widget> screens = [
    const HomeView(),
    const UserFavouritesView(),
    UserPropertyListingView(),
    const UserAddPropertyView(),
    UserSearchPageView()
  ];

  var currentIndex = 0.obs;

  final count = 0.obs;

  void increment() => count.value++;
  void navigateToUserPropertyListing() {
    currentIndex.value = 2;
  }
}
