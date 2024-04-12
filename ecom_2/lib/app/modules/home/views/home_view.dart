import 'package:ecom_2/app/components/product_card.dart';
import 'package:ecom_2/app/constants.dart';
import 'package:ecom_2/app/model/category.dart';
import 'package:ecom_2/app/model/property.dart';
import 'package:ecom_2/app/modules/main/controllers/main_controller.dart';
import 'package:ecom_2/app/modules/profile/views/profile_view.dart';
import 'package:ecom_2/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());
    controller.getuser();
    controller.getCategories();

    return GetBuilder<HomeController>(builder: (controller) {
      return Scaffold(
          appBar: AppBar(
            title: const Text('HomeView'),
            centerTitle: true,
            actions: [
              IconButton(
                  onPressed: () {
                    showSearch(
                        context: context, delegate: SearchView(), query: '');
                  },
                  icon: const Icon(Icons.search))
            ],
          ),
          drawer: Drawer(
            // This is the sidebar/drawer
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                SizedBox(
                  height: 260,
                  child: DrawerHeader(
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                    ),
                    child: Column(
                      children: [
                        CircleAvatar(
                          key: const Key("profile"),
                          radius: 60,
                          child: Text(
                            (controller.user?.fullName?[0].toUpperCase() ??
                                    '') +
                                (controller.user?.fullName?[1].toUpperCase() ??
                                    ''),
                            style: const TextStyle(
                              fontSize: 50,
                            ),
                          ),
                        ),
                        Text(
                          controller.user?.fullName ?? 'Please Login',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(controller.user?.email ?? '')
                      ],
                    ),
                  ),
                ),
                // Divider between header and category list
                const Divider(),
                // Category list text

                Column(
                  children: [
                    GestureDetector(
                      child: const ListTile(
                        title: Text('Category List:'),
                        trailing: Icon(Icons.arrow_downward_outlined),
                      ),
                      onTap: () {
                        controller.showCategory();
                      },
                    ),

                    // Category list
                    SizedBox(
                      height: controller.showCategories.isTrue ? 200 : 0,
                      // height: 200, // Adjust height as needed
                      child: ListView.builder(
                        padding: const EdgeInsets.all(10),
                        itemCount: controller.showCategories.isTrue
                            ? controller.categories?.length ?? 0
                            : 0,
                        itemBuilder: (context, index) {
                          if (controller.showCategories.isTrue) {
                            String categoryName =
                                controller.categories![index].categoryTitle ??
                                    '';
                            // Build list tile for category
                            return Container(
                              decoration: BoxDecoration(
                                // Add border to each ListTile
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.grey.shade300)),
                              ),
                              child: ListTile(
                                leading: const Icon(Icons.category,
                                    color: Colors.blue), // Leading icon
                                title: Text(
                                  categoryName,
                                  style: const TextStyle(
                                    color: Colors.black87, // Text color
                                    fontWeight: FontWeight.bold, // Text weight
                                  ),
                                ),
                                trailing: const Icon(Icons.arrow_forward_ios,
                                    size: 16.0, color: Colors.grey),
                                onTap: () {
                                  Get.toNamed(Routes.DETAIL_CATEGORY,
                                      arguments: controller.categories?[index]);
                                },
                              ),
                            );
                          } else {
                            return const SizedBox.shrink();
                          }
                          // Extract category information
                        },
                      ),
                    ),
                  ],
                ),
                // Divider between category list and other list tiles
                const Divider(),
                // Other list tiles
                ListTile(
                  title: const Text('Profile'),
                  onTap: () {
                    Navigator.pop(context); // Close the drawer
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProfileView(),
                      ),
                    ); // Navigate to ProfileView
                  },
                ),
                ListTile(
                    title: const Text('Your Listing'),
                    onTap: () {
                      Navigator.pop(context); // Close the drawer
                      Get.find<MainController>()
                          .navigateToUserPropertyListing();
                    }),

                // ListTile(
                //     title: MemoryManagement.getMembershipStatus() != "Member"
                //         ? Text('Membership')
                //         : Text("See Profile"),
                //     onTap: () {
                //       if (MemoryManagement.getMembershipStatus() != "Member") {
                //         Navigator.pop(context); // Close the drawer
                //         Navigator.push(
                //           context,
                //           MaterialPageRoute(
                //             builder: (context) => const MembershipView(),
                //           ),
                //         );
                //       } else {
                //         Navigator.pop(context); // Close the drawer
                //         Navigator.push(
                //           context,
                //           MaterialPageRoute(
                //             builder: (context) => const ProfileView(),
                //           ),
                //         );
                //       }
                //     }),
                // Add more ListTiles for additional menu items
              ],
            ),
          ),
          body: GetBuilder<HomeController>(
            builder: (controller) {
              if (controller.categories == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              //to get only the categories which has products in it
              List<Category> categoriesWithProducts =
                  controller.categories!.where((category) {
                List<Property>? products =
                    controller.propertyByCategory[category.categoryId];
                return products != null && products.isNotEmpty;
              }).toList();
              return Padding(
                padding: const EdgeInsets.all(10),
                child: ListView.builder(
                  itemCount: categoriesWithProducts.length,
                  itemBuilder: (context, index) {
                    Category category = categoriesWithProducts[index];
                    List<Property>? products =
                        controller.propertyByCategory[category.categoryId];

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Display category title
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 0.0, horizontal: 0.0),
                          child: GestureDetector(
                            onTap: () {
                              Get.toNamed(Routes.DETAIL_CATEGORY,
                                  arguments: categoriesWithProducts[index]);
                            },
                            child: Row(
                              children: [
                                Text(
                                  category.categoryTitle ?? '',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Icon(Icons.arrow_forward)
                              ],
                            ),
                          ),
                        ),
                        // Display horizontal list of products
                        SizedBox(
                          height: 300,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: products?.length ?? 0,
                            itemBuilder: (context, index) {
                              return SizedBox(
                                  height: 150,
                                  child:
                                      ProductCard(property: products![index]));
                              // return Text("data");
                            },
                          ),
                        ),
                        const SizedBox(
                            height: 20), // Add spacing between categories
                      ],
                    );
                  },
                ),
              );
            },
          ));
    });
  }
}

HomeController controller = Get.find();

class SearchView extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [IconButton(onPressed: () {}, icon: const Icon(Icons.clear))];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return const BackButton();
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildSuggestions(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Property> suggestions = [];
    suggestions = controller.properties
            ?.where((element) =>
                (element.propertyName != null &&
                    element.title!
                        .toLowerCase()
                        .contains(query.toLowerCase())) ||
                (element.locationName != null &&
                    element.locationName!
                        .toLowerCase()
                        .contains(query.toLowerCase())))
            .toList() ??
        [];

    return ListView.builder(
        shrinkWrap: true,
        itemCount: suggestions.length,
        itemBuilder: (context, index) => SizedBox(
              height: 100,
              child: SearchListCard(property: suggestions[index]),
            ));
  }
}

class SearchListCard extends StatelessWidget {
  final Property property;

  const SearchListCard({
    Key? key,
    required this.property,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.DETAILED_PRODUCT, arguments: property);
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        margin: const EdgeInsets.only(bottom: 20),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.network(
                    getImageUrl(property.imageUrl),
                    fit: BoxFit.cover,
                    height: 90,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      property.propertyName ?? '',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Price: ${property.price}',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
