import 'package:get/get.dart';

import '../controllers/user_search_page_controller.dart';

class UserSearchPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserSearchPageController>(
      () => UserSearchPageController(),
    );
  }
}
