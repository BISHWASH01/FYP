import 'package:ecom_2/app/constants.dart';
import 'package:ecom_2/app/model/property.dart';
// import 'package:ecom_2/app/modules/cart/controllers/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:get/get.dart';

import '../controllers/detailed_product_controller.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class DetailedProductView extends GetView<DetailedProductController> {
  const DetailedProductView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var property = Get.arguments as Property;
    // controller.fetchReviews(property.propertyID!);

    // var cartController = Get.put(CartController());
    return Scaffold(
        appBar: AppBar(
          title: Text(property.propertyName?.toUpperCase() ?? ''),
          centerTitle: true,
        ),
        body: GetBuilder<DetailedProductController>(
          builder: (controller) => SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Hero(
                      tag: 'product+${property.propertyId}',
                      child: Image.network(
                        width: double.infinity,
                        height: Get.height * 0.4,
                        getImageUrl(property.imageUrl ?? ''),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            property.propertyName?.toUpperCase() ?? '',
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            'रु. ${property.price.toString()}',
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            'location : ${property.locationName}',
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            property.propertyDescription ?? '',
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              _showReviewDialog(context, property);
                            },
                            child: const Text('Give Review'),
                          ),
                          // Inside DetailedProductView
                          SizedBox(
                            height: 250,
                            child: Obx(() => ListView.builder(
                                  itemCount: controller.ratings
                                      .length, // Use the .length of the RxList
                                  itemBuilder: (context, index) {
                                    final rating = controller.ratings[index];
                                    if (controller.ratings.isEmpty) {
                                      return const SizedBox(
                                        child: Column(
                                          children: [Text("No reviews")],
                                        ),
                                      );
                                    } else {
                                      return RatingCard(
                                        userName: rating.fullName!,
                                        reviewText: rating.review ?? '',
                                        rating:
                                            rating.rating?.toDouble() ?? 0.0,
                                        date: formatDate(rating.date),
                                      );
                                    }
                                  },
                                )),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                // Button to launch Dail pad
                ElevatedButton(
                  onPressed: () {
                    launchDialer(property.phoneNumber!);
                  },
                  child: const Text('Open Dial Pad'),
                ),
              ],
            ),
          ),
        ));
  }

  Future<void> launchDialer(String phoneNumber) async {
    final Uri telUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(telUri)) {
      await launchUrl(telUri);
    } else {
      // Handle the error or notify the user
      // print('Could not launch $telUri');
    }
  }

  void _showReviewDialog(BuildContext context, Property property) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        double rating = 3; // Initial rating
        String review = ''; // Initial review

        return AlertDialog(
          title: const Text('Give Review'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RatingBar.builder(
                initialRating: rating,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: false,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (newRating) {
                  rating = newRating;
                },
              ),
              const SizedBox(height: 16),
              TextField(
                maxLength: 60,
                onChanged: (value) {
                  review = value;
                },
                decoration: const InputDecoration(
                  hintText: 'Write your review...',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Here, you can use the 'rating' and 'review' variables
                controller.giveRating(
                    propertyID: property.propertyId.toString(),
                    rating: rating,
                    review: review);
                // print('Rating: $rating, Review: $review');
                Navigator.of(context).pop();
              },
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }
}

class RatingCard extends StatelessWidget {
  final String userName;
  final String reviewText;
  final double rating;
  final String date; // Assuming you have a date field

  const RatingCard({
    Key? key,
    required this.userName,
    required this.reviewText,
    required this.rating,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              userName,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            RatingBarIndicator(
              rating: rating,
              itemBuilder: (context, index) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              itemCount: 5,
              itemSize: 20.0,
              direction: Axis.horizontal,
            ),
            const SizedBox(height: 8),
            Text(
              reviewText,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              date,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
