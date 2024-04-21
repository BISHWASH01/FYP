import 'package:get/get.dart';

import '../controllers/detailed_residential_property_controller.dart';

class DetailedResidentialPropertyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailedResidentialPropertyController>(
      () => DetailedResidentialPropertyController(),
    );
  }
}
