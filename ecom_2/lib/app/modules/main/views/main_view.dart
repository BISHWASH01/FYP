import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import '../controllers/main_controller.dart';

class MainView extends GetView<MainController> {
  const MainView({Key? key}) : super(key: key);
  final Gradient selectedGradient =
      const LinearGradient(colors: [Colors.red, Colors.amber]);

  final Gradient unselectedGradient =
      const LinearGradient(colors: [Colors.red, Colors.blueGrey]);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          body: controller.screens[controller.currentIndex.value],

          // bottomNavigationBar: FloatingNavbar(
          //   // padding: EdgeInsets.all(10),
          //   margin: EdgeInsets.only(bottom: 0),
          //   iconSize: 15,
          //   // width: 350,
          //   onTap: (int val) {
          //     controller.currentIndex.value = val;
          //   },
          //   currentIndex: controller.currentIndex.value,
          //   items: [
          //     FloatingNavbarItem(icon: Icons.home, title: 'Home'),
          //     FloatingNavbarItem(icon: Icons.list, title: 'Favourites'),
          //     FloatingNavbarItem(icon: Icons.shopping_cart, title: 'MyProduct'),
          //     FloatingNavbarItem(icon: Icons.person, title: 'ListProperty'),
          //   ],
          // ),
          // extendBody: true,
          // bottomNavigationBar: Padding(
          //   padding: const EdgeInsets.all(30),
          //   child: DotNavigationBar(
          //     marginR: EdgeInsets.all(0),
          //     itemPadding: const EdgeInsets.symmetric(
          //       vertical: 8,
          //     ),
          //     backgroundColor: Color.fromARGB(255, 146, 100, 89),
          //     margin: const EdgeInsets.only(left: 10, right: 10),
          //     splashBorderRadius: 50,
          //     unselectedItemColor: const Color.fromARGB(255, 54, 88, 146),
          //     selectedItemColor: Colors.black,
          //     onTap: (int val) {
          //       controller.currentIndex.value = val;
          //     },
          //     currentIndex: controller.currentIndex.value,
          //     dotIndicatorColor: Colors.amber,
          //     curve: Curves.bounceOut,
          //     items: [
          //       /// Home
          //       DotNavigationBarItem(
          //         icon: const Icon(Icons.home),
          //         selectedColor: Colors.black,
          //       ),

          //       /// Likes
          //       DotNavigationBarItem(
          //         icon: const Icon(Icons.favorite),
          //         selectedColor: Colors.black,
          //       ),

          //       /// Search
          //       DotNavigationBarItem(
          //         icon: const Icon(Icons.list),
          //         selectedColor: Colors.black,
          //       ),

          //       /// Profile
          //       DotNavigationBarItem(
          //         icon: const Icon(Icons.add),
          //         selectedColor: Colors.black,
          //       ),
          //     ],
          //   ),
          // ),
          extendBody: true,
          bottomNavigationBar: SnakeNavigationBar.gradient(
            behaviour: SnakeBarBehaviour.floating,
            snakeShape: SnakeShape.circle,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25))),
            padding: const EdgeInsets.all(12),

            // ///configuration for SnakeNavigationBar.color
            // snakeViewColor: Colors.black,
            // selectedItemColor:
            //     SnakeShape.circle == SnakeShape.indicator ? Colors.black : null,
            // unselectedItemColor: Colors.blueGrey,

            ///configuration for SnakeNavigationBar.gradient
            // snakeViewGradient: selectedGradient,
            snakeViewGradient: selectedGradient,

            selectedItemGradient: SnakeShape.circle == SnakeShape.indicator
                ? selectedGradient
                : null,
            unselectedItemGradient: unselectedGradient,

            showUnselectedLabels: false,
            showSelectedLabels: false,

            currentIndex: controller.currentIndex.value,
            onTap: (int val) {
              controller.currentIndex.value = val;
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite), label: 'Favourites'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.list), label: 'MyProduct'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.add), label: 'ListProperty'),
              // BottomNavigationBarItem(
              //     icon: Icon(Icons.podcasts_sharp), label: 'popup'),
            ],
          ),
        ));
  }
}
