import 'package:ecom_2/app/components/My_button.dart';
import 'package:ecom_2/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/admin_dashboard_controller.dart';

class AdminDashboardView extends GetView<AdminDashboardController> {
  const AdminDashboardView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Dashboard'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            GetBuilder<AdminDashboardController>(
              init: AdminDashboardController(),
              builder: (controller) {
                if (controller.stats == null) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return SingleChildScrollView(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      // await Future.delayed(Duration(seconds: 5));
                      await controller.getStats();
                    },
                    child: GridView(
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(10),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 5.0,
                                crossAxisSpacing: 5),
                        children: [
                          StatsCard(
                            label: 'Total Membership Income',
                            icon: const Icon(Icons.money),
                            isAmount: true,
                            value:
                                controller.stats?.membershipIncome.toString() ??
                                    '',
                          ),
                          StatsCard(
                            label: 'Total Users',
                            icon: const Icon(Icons.person),
                            value:
                                controller.stats?.totalUsers.toString() ?? '',
                          ),
                          StatsCard(
                            label: 'Total Property Income',
                            value:
                                controller.stats?.propertyIncome.toString() ??
                                    '',
                          ),
                          StatsCard(
                            label: 'Total reviews',
                            value:
                                controller.stats?.totalReviews.toString() ?? '',
                          ),
                          StatsCard(
                            label: 'Total Property Income',
                            value:
                                controller.stats?.propertyIncome.toString() ??
                                    '',
                          ),
                          StatsCard(
                            label: 'Total Property Income',
                            value:
                                controller.stats?.propertyIncome.toString() ??
                                    '',
                          )
                        ]),
                  ),
                );
              },
            ),
            const SizedBox(
              height: 50,
            ),
            MyButton(
              tittle: 'View Orders',
              onPressed: () {
                Get.toNamed(Routes.ORDER);
              },
            )
          ],
        ));
  }
}

class StatsCard extends StatelessWidget {
  final String label;
  final String value;
  final Icon? icon;
  final bool isAmount;
  final Color? color;
  const StatsCard(
      {super.key,
      required this.label,
      required this.value,
      this.isAmount = false,
      this.color,
      this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            spreadRadius: 2,
            color: Colors.black.withOpacity(0.2),
            offset: const Offset(1, 1))
      ], color: color ?? const Color.fromRGBO(242, 242, 242, 1)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            (isAmount ? 'Rs.' : '') + value == "null" ? "0" : value,
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 67, 147, 239),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
              icon ?? const SizedBox.shrink()
            ],
          )
        ],
      ),
    );
  }
}
