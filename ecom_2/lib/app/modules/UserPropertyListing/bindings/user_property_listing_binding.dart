import 'package:get/get.dart';

import '../controllers/user_property_listing_controller.dart';

class UserPropertyListingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserPropertyListingController>(
      () => UserPropertyListingController(),
    );
  }
}
