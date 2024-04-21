import 'package:ecom_2/app/model/category.dart';
import 'package:ecom_2/app/model/property.dart';
import 'package:ecom_2/app/modules/home/controllers/home_controller.dart';
import 'package:get/get.dart';

class DetailCategoryController extends GetxController {
  List<Property> properties = [];

  final count = 0.obs;

  @override
  void onInit() {
    super.onInit();
    var homeController = Get.find<HomeController>();
    var category = Get.arguments as Category;
    properties = homeController.properties
            ?.where((element) => element.categoryId! == category.categoryId!)
            .toList() ??
        [];
    print(homeController.properties);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
