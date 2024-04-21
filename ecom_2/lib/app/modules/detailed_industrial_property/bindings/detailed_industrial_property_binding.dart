import 'package:get/get.dart';

import '../controllers/detailed_industrial_property_controller.dart';

class DetailedIndustrialPropertyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailedIndustrialPropertyController>(
      () => DetailedIndustrialPropertyController(),
    );
  }
}
