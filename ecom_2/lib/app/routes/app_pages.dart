import 'package:get/get.dart';

import '../modules/Membership/bindings/membership_binding.dart';
import '../modules/Membership/views/membership_view.dart';
import '../modules/UserAddProperty/bindings/user_add_property_binding.dart';
import '../modules/UserAddProperty/views/user_add_property_view.dart';
import '../modules/UserDetailProperty/bindings/user_detail_property_binding.dart';
import '../modules/UserDetailProperty/views/user_detail_property_view.dart';
import '../modules/UserProfileEdit/bindings/user_profile_edit_binding.dart';
import '../modules/UserProfileEdit/views/user_profile_edit_view.dart';
import '../modules/UserPropertyEdit/bindings/user_property_edit_binding.dart';
import '../modules/UserPropertyEdit/views/user_property_edit_view.dart';
import '../modules/UserPropertyListing/bindings/user_property_listing_binding.dart';
import '../modules/UserPropertyListing/views/user_property_listing_view.dart';
import '../modules/User_Favourites/bindings/user_favourites_binding.dart';
import '../modules/User_Favourites/views/user_favourites_view.dart';
import '../modules/admin_categories/bindings/admin_categories_binding.dart';
import '../modules/admin_categories/views/admin_categories_view.dart';
import '../modules/admin_dashboard/bindings/admin_dashboard_binding.dart';
import '../modules/admin_dashboard/views/admin_dashboard_view.dart';
import '../modules/admin_main/bindings/admin_main_binding.dart';
import '../modules/admin_main/views/admin_main_view.dart';
import '../modules/admin_orders/bindings/admin_orders_binding.dart';
import '../modules/admin_orders/views/admin_orders_view.dart';
import '../modules/admin_products/bindings/admin_products_binding.dart';
import '../modules/admin_products/views/admin_products_view.dart';
import '../modules/admin_users/bindings/admin_users_binding.dart';
import '../modules/admin_users/views/admin_users_view.dart';
import '../modules/cart/bindings/cart_binding.dart';
import '../modules/cart/views/cart_view.dart';
import '../modules/detail_category/bindings/detail_category_binding.dart';
import '../modules/detail_category/views/detail_category_view.dart';
import '../modules/detailed_product/bindings/detailed_product_binding.dart';
import '../modules/detailed_product/views/detailed_product_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/main/bindings/main_binding.dart';
import '../modules/main/views/main_view.dart';
import '../modules/onboarding/bindings/onboarding_binding.dart';
import '../modules/onboarding/views/onboarding_view.dart';
import '../modules/order/bindings/order_binding.dart';
import '../modules/order/views/order_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const LOGIN = Routes.LOGIN;
  static const HOME = Routes.MAIN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.CART,
      page: () => const CartView(),
      binding: CartBinding(),
    ),
    GetPage(
      name: _Paths.ORDER,
      page: () => const OrderView(),
      binding: OrderBinding(),
    ),
    GetPage(
      name: _Paths.MAIN,
      page: () => const MainView(),
      binding: MainBinding(),
    ),
    GetPage(
      name: _Paths.ONBOARDING,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN_MAIN,
      page: () => const AdminMainView(),
      binding: AdminMainBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN_DASHBOARD,
      page: () => const AdminDashboardView(),
      binding: AdminDashboardBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN_PRODUCTS,
      page: () => const AdminProductsView(),
      binding: AdminProductsBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN_CATEGORIES,
      page: () => const AdminCategoriesView(),
      binding: AdminCategoriesBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN_ORDERS,
      page: () => const AdminOrdersView(),
      binding: AdminOrdersBinding(),
    ),
    GetPage(
      name: _Paths.DETAILED_PRODUCT,
      page: () => const DetailedProductView(),
      binding: DetailedProductBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN_USERS,
      page: () => const AdminUsersView(),
      binding: AdminUsersBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_CATEGORY,
      page: () => const DetailCategoryView(),
      binding: DetailCategoryBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.USER_FAVOURITES,
      page: () => const UserFavouritesView(),
      binding: UserFavouritesBinding(),
    ),
    GetPage(
      name: _Paths.USER_PROPERTY_LISTING,
      page: () => UserPropertyListingView(),
      binding: UserPropertyListingBinding(),
    ),
    GetPage(
      name: _Paths.USER_DETAIL_PROPERTY,
      page: () => const UserDetailPropertyView(),
      binding: UserDetailPropertyBinding(),
    ),
    GetPage(
      name: _Paths.USER_ADD_PROPERTY,
      page: () => const UserAddPropertyView(),
      binding: UserAddPropertyBinding(),
    ),
    GetPage(
      name: _Paths.USER_PROPERTY_EDIT,
      page: () => const UserPropertyEditView(),
      binding: UserPropertyEditBinding(),
    ),
    GetPage(
      name: _Paths.MEMBERSHIP,
      page: () => const MembershipView(),
      binding: MembershipBinding(),
    ),
    GetPage(
      name: _Paths.USER_PROFILE_EDIT,
      page: () => const UserProfileEditView(),
      binding: UserProfileEditBinding(),
    ),
  ];
}
