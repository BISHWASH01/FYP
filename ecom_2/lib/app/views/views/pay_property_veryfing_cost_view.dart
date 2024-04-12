import 'package:flutter/material.dart';

import 'package:get/get.dart';

class PayPropertyVeryfingCostView extends GetView {
  const PayPropertyVeryfingCostView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PayPropertyVeryfingCostView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'PayPropertyVeryfingCostView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
