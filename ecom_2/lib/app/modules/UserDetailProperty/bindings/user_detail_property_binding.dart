import 'package:get/get.dart';

import '../controllers/user_detail_property_controller.dart';

class UserDetailPropertyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserDetailPropertyController>(
      () => UserDetailPropertyController(),
    );
  }
}
