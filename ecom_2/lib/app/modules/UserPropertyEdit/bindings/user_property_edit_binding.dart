import 'package:get/get.dart';

import '../controllers/user_property_edit_controller.dart';

class UserPropertyEditBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserPropertyEditController>(
      () => UserPropertyEditController(),
    );
  }
}
