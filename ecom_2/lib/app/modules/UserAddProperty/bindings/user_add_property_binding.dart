import 'package:get/get.dart';

import '../controllers/user_add_property_controller.dart';

class UserAddPropertyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserAddPropertyController>(
      () => UserAddPropertyController(),
    );
  }
}
