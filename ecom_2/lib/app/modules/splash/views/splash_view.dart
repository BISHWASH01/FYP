import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 250,
            ),
            Lottie.asset('assets/logo.json'),
            const SizedBox(
              height: 20,
            ),
            RichText(
              // textAlign: TextAlign.justify,
              text: const TextSpan(
                  text: 'Ghar',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(
                      text: 'Jagga',
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  ]),
            )

            // const Text(
            //   'Hamro',
            //   style: TextStyle(
            //     fontSize: 30,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
