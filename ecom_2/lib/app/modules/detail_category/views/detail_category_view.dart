import 'package:ecom_2/app/components/admin_product_card.dart';
import 'package:ecom_2/app/model/category.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/detail_category_controller.dart';

class DetailCategoryView extends GetView<DetailCategoryController> {
  const DetailCategoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var category = Get.arguments as Category;
    return Scaffold(
        appBar: AppBar(
          title: Text(category.categoryTitle ?? ''),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.builder(
              itemCount: controller.properties.length,
              itemBuilder: (context, index) => SizedBox(
                  height: 100,
                  child: AdminProductCard(
                    property: controller.properties[index],
                  ))),
        ));
  }
}
