import 'package:get/get.dart';

import '../controllers/detailed_land_property_controller.dart';

class DetailedLandPropertyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailedLandPropertyController>(
      () => DetailedLandPropertyController(),
    );
  }
}
