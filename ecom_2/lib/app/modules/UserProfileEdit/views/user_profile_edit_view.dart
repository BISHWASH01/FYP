import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/user_profile_edit_controller.dart';

class UserProfileEditView extends GetView<UserProfileEditController> {
  const UserProfileEditView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UserProfileEditView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'UserProfileEditView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
