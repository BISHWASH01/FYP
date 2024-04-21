import 'package:get/get.dart';

import '../controllers/detailed_commercial_property_controller.dart';

class DetailedCommercialPropertyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailedCommercialPropertyController>(
      () => DetailedCommercialPropertyController(),
    );
  }
}
