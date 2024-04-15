import 'package:ecom_2/app/model/stats.dart';
import 'package:ecom_2/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/widgets.dart';

import 'package:get/get.dart';

import '../controllers/admin_dashboard_controller.dart';

class AdminDashboardView extends GetView<AdminDashboardController> {
  const AdminDashboardView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(AdminDashboardController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        centerTitle: true,
      ),
      body: GetBuilder<AdminDashboardController>(
        init: AdminDashboardController(),
        builder: (controller) {
          if (controller.stats == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          var stats = controller.stats!;
          return SingleChildScrollView(
            child: RefreshIndicator(
              onRefresh: () async {
                // await Future.delayed(Duration(seconds: 5));
                await controller.getStats();
              },
              child: Column(
                children: [
                  GridView(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(10),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 15.0,
                              crossAxisSpacing: 5),
                      children: [
                        StatsCard(
                          label: ' Membership \n     Income',
                          icon: const Icon(Icons.money),
                          isAmount: true,
                          value:
                              controller.stats?.membershipIncome.toString() ??
                                  '',
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(Routes.ADMIN_USERS);
                          },
                          child: StatsCard(
                            label: 'Total Users',
                            icon: const Icon(Icons.person),
                            value:
                                controller.stats?.totalUsers.toString() ?? '',
                          ),
                        ),
                        StatsCard(
                          label: 'Total Property Income',
                          value:
                              controller.stats?.propertyIncome.toString() ?? '',
                        ),
                        StatsCard(
                          label: 'Total reviews',
                          value:
                              controller.stats?.totalReviews.toString() ?? '',
                        ),
                        StatsCard(
                          label: 'Total Property Income',
                          value:
                              controller.stats?.propertyIncome.toString() ?? '',
                        ),
                        StatsCard(
                          label: 'Total Property Income',
                          value:
                              controller.stats?.propertyIncome.toString() ?? '',
                        ),
                      ]),
                  // Text.rich(),
                  MyPieChart(topCategories: controller.stats!.topCategories!)
                ],
              ),
            ),
          );
        },
      ),
      // const SizedBox(
      //   height: 50,
      // ),
      // MyButton(
      //   tittle: 'View Orders',
      //   onPressed: () {
      //     Get.toNamed(Routes.ORDER);
      //   },
      // ),
      //
    );
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
      width: 50,
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
                overflow: TextOverflow.clip,
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

class MyPieChart extends StatelessWidget {
  final List<TopCategory> topCategories;
  const MyPieChart({super.key, required this.topCategories});

  @override
  Widget build(BuildContext context) {
    List<Color> colors = [
      AppColors.contentColorBlue,
      AppColors.contentColorYellow,
      AppColors.contentColorPurple,
      AppColors.contentColorGreen,
      Colors.purpleAccent,
      Colors.orange,
    ];

    return AspectRatio(
      aspectRatio: 1.3,
      child: Row(
        children: <Widget>[
          const SizedBox(
            height: 18,
          ),
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: PieChart(
                PieChartData(
                  pieTouchData: PieTouchData(),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  sectionsSpace: 0,
                  centerSpaceRadius: 40,
                  sections: showingSections(),
                ),
              ),
            ),
          ),
          Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              // Indicator(
              //   color: AppColors.contentColorBlue,
              //   text: 'First',
              //   isSquare: true,
              // ),
              children: topCategories
                  .map((e) => Indicator(
                        isSquare: true,
                        color: colors[topCategories.indexOf(e)],
                        text: e.category ?? '',
                      ))
                  .toList()),
          const SizedBox(
            width: 28,
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    List<PieChartSectionData> list = [];
    List<Color> colors = [
      AppColors.contentColorBlue,
      AppColors.contentColorYellow,
      AppColors.contentColorPurple,
      AppColors.contentColorGreen,
      Colors.purpleAccent,
      Colors.orange,
    ];

    list = topCategories
        .map((e) => PieChartSectionData(
              color: colors[topCategories.indexOf(e)],
              value: e.percentage!,
              title: '${e.percentage}%',
              radius: 80,
              titleStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.mainTextColor1,
              ),
            ))
        .toList();
    return list;
  }
}

class Indicator extends StatelessWidget {
  const Indicator({
    super.key,
    required this.color,
    required this.text,
    required this.isSquare,
    this.size = 16,
    this.textColor,
  });
  final Color color;
  final String text;
  final bool isSquare;
  final double size;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        )
      ],
    );
  }
}

class AppColors {
  static const Color primary = contentColorCyan;
  static const Color menuBackground = Color(0xFF090912);
  static const Color itemsBackground = Color(0xFF1B2339);
  static const Color pageBackground = Color(0xFF282E45);
  static const Color mainTextColor1 = Colors.white;
  static const Color mainTextColor2 = Colors.white70;
  static const Color mainTextColor3 = Colors.white38;
  static const Color mainGridLineColor = Colors.white10;
  static const Color borderColor = Colors.white54;
  static const Color gridLinesColor = Color(0x11FFFFFF);

  static const Color contentColorBlack = Colors.black;
  static const Color contentColorWhite = Colors.white;
  static const Color contentColorBlue = Color(0xFF2196F3);
  static const Color contentColorYellow = Color(0xFFFFC300);
  static const Color contentColorOrange = Color(0xFFFF683B);
  static const Color contentColorGreen = Color(0xFF3BFF49);
  static const Color contentColorPurple = Color(0xFF6E1BFF);
  static const Color contentColorPink = Color(0xFFFF3AF2);
  static const Color contentColorRed = Color(0xFFE80054);
  static const Color contentColorCyan = Color(0xFF50E4FF);
}
