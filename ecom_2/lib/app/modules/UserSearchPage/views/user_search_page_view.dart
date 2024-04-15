import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/user_search_page_controller.dart';

class UserSearchPageView extends GetView<UserSearchPageController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map'),
      ),
      // body: MapboxMap(
      //   accessToken:
      //       'sk.eyJ1IjoiYmlzaHdhc2hwb3VkZWwiLCJhIjoiY2x2MGs1a2l1MWRzdzJsbGtobzZvb2kyZyJ9.Zj1EoU-yn2BAo4Ds4kRHdg',
      //   styleString: MapboxStyles.LIGHT,
      //   initialCameraPosition: CameraPosition(
      //     target: LatLng(37.7749, -122.4194), // San Francisco coordinates
      //     zoom: 12.0,
      //   ),
      //   onMapCreated: (MapboxMapController controller) {
      //     // You can interact with the map controller here
      //   },
      // ),
    );
  }
}
