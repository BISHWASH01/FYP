import 'package:ecom_2/app/model/user.dart';
import 'package:ecom_2/app/modules/Membership/controllers/membership_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

class MembershipView extends GetView<MembershipController> {
  const MembershipView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var user = Get.arguments as User;
    return Scaffold(
      appBar: AppBar(
        title: const Text('MembershipView'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          Text(
            'Membership Benefits',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          BenefitCard(
            title: 'Exclusive Discounts',
            description: 'Get property verified witn no charge.',
            icon: Icons.local_offer,
          ),
          // BenefitCard(
          //   title: 'Early Access',
          //   description: 'Be the first to access new products and features.',
          //   icon: Icons.access_time,
          // ),
          BenefitCard(
            title: 'Priority Support',
            description: 'Receive priority customer support assistance.',
            icon: Icons.priority_high,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              KhaltiScope.of(Get.context!).pay(
                preferences: [
                  PaymentPreference.khalti,
                  PaymentPreference.connectIPS
                ],
                config: PaymentConfig(
                  amount: 19900,
                  productIdentity: user.userId.toString(),
                  productName: "membership",
                ),
                onSuccess: (PaymentSuccessModel v) {
                  controller.makePayment(
                    total: (v.amount / 100).toString(),
                    userID: user.userId.toString(),
                    otherData: v.toString(),
                  );
                  // user.isMember = '1'; // Update isVerified directly
                  // print(product.isVerified);
                },
                onFailure: (v) {
                  Get.showSnackbar(const GetSnackBar(
                    backgroundColor: Colors.red,
                    message: 'Payment failed!',
                    duration: Duration(seconds: 3),
                  ));
                },
                onCancel: () {
                  Get.showSnackbar(const GetSnackBar(
                    backgroundColor: Colors.red,
                    message: 'Payment cancelled!',
                    duration: Duration(seconds: 3),
                  ));
                },
              );
            },
            child: Text('Initiate Payment'),
          ),
        ],
      ),
    );
  }
}

class BenefitCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;

  const BenefitCard({
    Key? key,
    required this.title,
    required this.description,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListTile(
        leading: Icon(icon),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(description),
      ),
    );
  }
}
