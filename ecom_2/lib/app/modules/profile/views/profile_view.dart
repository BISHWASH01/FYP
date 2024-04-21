import 'package:ecom_2/app/components/My_button.dart';
import 'package:ecom_2/app/routes/app_pages.dart';
import 'package:ecom_2/app/utils/memoryManagement.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:get/get.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('My Profile'),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                Get.toNamed(Routes.USER_PROFILE_EDIT);
              },
              icon: Icon(Icons.edit),
            )
          ],
        ),
        body: GetBuilder<ProfileController>(
          init: ProfileController(),
          builder: (controller) {
            if (controller.user == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CircleAvatar(
                  key: Key("profile"),
                  radius: 60,
                  // backgroundImage: AssetImage(
                  //   "assets/logo.png",
                  // ),
                  child: Text(
                    (controller.user?.fullName?[0].toUpperCase() ?? '') +
                        (controller.user?.fullName?[1].toUpperCase() ?? ''),
                    style: const TextStyle(
                      fontSize: 50,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    controller.user?.fullName?.toUpperCase() ?? '',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (controller.user?.isMember == "1")
                    const Icon(Icons.verified)
                ]),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  controller.user?.email ?? '',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  MemoryManagement.getAccessRole()?.toUpperCase() ?? '',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                if (controller.user?.isMember == "0")
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Still not a member??",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            Get.toNamed(Routes.MEMBERSHIP,
                                arguments: controller.user);
                          },
                          child: Text("Take membership")),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                MyButton(
                    tittle: 'Logout',
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          content: const Text(
                            'Are you sure you want to logout?',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: const Text(
                                'No',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                MemoryManagement.removeAll();
                                Get.offAllNamed(Routes.LOGIN);
                              },
                              child: const Text(
                                'Yes',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                      // MemoryManagement.removeAll();
                      // Get.offAllNamed(Routes.LOGIN);
                    })
              ],
            );
          },
        ));
  }
}
