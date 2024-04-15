import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/user_profile_edit_controller.dart';

class UserProfileEditView extends GetView<UserProfileEditController> {
  const UserProfileEditView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Profile Edit'),
          centerTitle: true,
        ),
        body: GetBuilder<UserProfileEditController>(
          builder: (controller) => SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(30),
              child: Column(
                children: [
                  TextFormField(
                    controller: controller.fullNameController,
                    decoration: const InputDecoration(labelText: 'Full Name'),
                  ),
                  TextFormField(
                    controller: controller.phoneNumberController,
                    decoration:
                        const InputDecoration(labelText: 'Phone Number'),
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        await controller.updateUserDetail();
                      },
                      child: const Text('Update Property')),
                  TextFormField(
                    controller: controller.oldPasswordController,
                    decoration:
                        const InputDecoration(labelText: 'Old Password'),
                  ),
                  TextFormField(
                    controller: controller.newPasswordController,
                    decoration:
                        const InputDecoration(labelText: 'New Password'),
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        await controller.updateUserPassword();
                      },
                      child: const Text('Update Password')),
                ],
              ),
            ),
          ),
        ));
  }
}
