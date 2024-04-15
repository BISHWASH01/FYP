import 'package:ecom_2/app/components/admin_product_card.dart';
import 'package:ecom_2/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/admin_products_controller.dart';

class AdminProductsView extends GetView<AdminProductsController> {
  const AdminProductsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AdminProductsController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('AdminProductsView'),
        centerTitle: true,
      ),
      body: GetBuilder<HomeController>(
          init: HomeController(),
          builder: (controller) {
            if (controller.properties == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            var verifiedProperties = controller.properties
                    ?.where((property) => property.isVerified == "verified")
                    .toList() ??
                [];

            var pendingProperties = controller.properties
                    ?.where((property) => property.isVerified == "pending")
                    .toList() ??
                [];
            var normalProperties = controller.properties
                    ?.where((property) => property.isVerified == "not")
                    .toList() ??
                [];
            return DefaultTabController(
                length: 3,
                child: Column(
                  children: [
                    TabBar(tabs: [
                      Tab(
                        text: "verified",
                      ),
                      Tab(
                        text: "Unverified",
                      ),
                      Tab(
                        text: "Normal",
                      )
                    ]),
                    Expanded(
                        child: TabBarView(children: [
                      ListView.builder(
                          itemCount: verifiedProperties.length,
                          itemBuilder: (context, index) {
                            return AdminProductCard(
                              property: verifiedProperties[index],
                            );
                          }),
                      ListView.builder(
                          itemCount: pendingProperties.length,
                          itemBuilder: (context, index) {
                            return AdminProductCard(
                              property: pendingProperties[index],
                            );
                          }),
                      ListView.builder(
                          itemCount: normalProperties.length,
                          itemBuilder: (context, index) {
                            return AdminProductCard(
                              property: normalProperties[index],
                            );
                          }),
                    ]))
                  ],
                ));
            // return ListView.builder(
            //     itemCount: controller.properties?.length ?? 0,
            //     itemBuilder: (context, index) {
            //       return AdminProductCard(
            //         property: controller.properties![index],
            //       );
            //     });
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.onAdd,
        child: const Icon(Icons.add),
      ),
    );
  }
}
