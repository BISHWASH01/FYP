import 'package:shared_preferences/shared_preferences.dart';

class MemoryManagement {
  static SharedPreferences? prefs;
  static Future<bool> init() async {
    prefs = await SharedPreferences.getInstance();
    return true;
  }

  static String? getAccessToken() {
    return prefs != null ? prefs!.getString('token') : null;
  }

  static void setAccessToken(String token) {
    prefs!.setString('token', token);
  }

  static void removeAccessToken() {
    prefs!.remove('token');
  }

  static String? getAccessRole() {
    return prefs != null ? prefs!.getString('role') : null;
  }

  static void setAccessRole(String role) {
    prefs!.setString('role', role);
  }

  static void removeAccessRole() {
    prefs!.remove('role');
  }

  static void setMembershipStatus(String status) {
    prefs!.setString('status', status);
  }

  static String? getMembershipStatus() {
    return prefs != null ? prefs!.getString('status') : null;
  }

  static String? getMyCart() {
    return prefs != null ? prefs!.getString('cart') : null;
  }

  static void setMyCart(String cart) {
    prefs!.setString('cart', cart);
  }

  static String? getUserFav() {
    return prefs != null ? prefs!.getString('fav') : null;
  }

  static void setUserfav(String fav) {
    prefs!.setString('fav', fav);
  }

  static void removeAll() async {
    await prefs!.clear();
  }
}
