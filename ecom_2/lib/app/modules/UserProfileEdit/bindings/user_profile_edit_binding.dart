import 'package:get/get.dart';

import '../controllers/user_profile_edit_controller.dart';

class UserProfileEditBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserProfileEditController>(
      () => UserProfileEditController(),
    );
  }
}
