import 'package:ecom_2/app/modules/User_Favourites/controllers/user_favourites_controller.dart';
import 'package:ecom_2/app/utils/memoryManagement.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

import 'app/routes/app_pages.dart';

void main() async {
  // Get.put(LoginController(), permanent: true);
  WidgetsFlutterBinding.ensureInitialized();
  await MemoryManagement.init();
  // final SharedPreferences prefs = await SharedPreferences.getInstance();
  // var token = prefs.getString('token');
  // var role = prefs.getString('role');
  Get.put(UserFavouritesController(), permanent: true);
  var token = MemoryManagement.getAccessToken();
  var role = MemoryManagement.getAccessRole();

  runApp(
    KhaltiScope(
      // enabledDebugging: true,
      publicKey: "test_public_key_71a2f1a1b0ea4a5f8c9cfa33447f1e0c",
      builder: (context, navigatorKey) => GetMaterialApp(
        navigatorKey: navigatorKey,
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('ne', 'NP'),
        ],
        localizationsDelegates: const [
          KhaltiLocalizations.delegate,
        ],
        debugShowCheckedModeBanner: false,
        title: "Application",
        initialRoute: Routes.SPLASH,
        // initialRoute: Routes.LOGIN,
        getPages: AppPages.routes,
        defaultTransition: Transition.cupertino,
      ),
    ),
  );
}
