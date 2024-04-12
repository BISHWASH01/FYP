import 'package:get/get.dart';

import '../controllers/user_favourites_controller.dart';

class UserFavouritesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserFavouritesController>(
      () => UserFavouritesController(),
    );
  }
}
