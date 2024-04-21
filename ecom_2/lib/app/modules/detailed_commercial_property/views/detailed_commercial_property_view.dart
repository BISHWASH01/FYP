import 'package:ecom_2/app/constants.dart';
import 'package:ecom_2/app/model/commercial.dart';
import 'package:ecom_2/app/routes/app_pages.dart';
import 'package:ecom_2/app/utils/memoryManagement.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/detailed_commercial_property_controller.dart';

class DetailedCommercialPropertyView
    extends GetView<DetailedCommercialPropertyController> {
  const DetailedCommercialPropertyView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var property = Get.arguments as Commercial;

    return Scaffold(
      appBar: AppBar(
        title: Text(property.propertyName?.toUpperCase() ?? ''),
        centerTitle: true,
        actions: [
          if (property.userId.toString() == MemoryManagement.getuserID())
            IconButton(
              onPressed: () {
                Get.toNamed(Routes.USER_PROFILE_EDIT);
              },
              icon: Icon(Icons.edit),
            )
        ],
      ),
      body: GetBuilder<DetailedCommercialPropertyController>(
        builder: (controller) => SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: 'property_${property.propertyId}',
                child: Image.network(
                  getImageUrl(property.imageUrl ?? ''),
                  width: double.infinity,
                  height: Get.height * 0.4,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      property.propertyName?.toUpperCase() ?? '',
                      style: const TextStyle(fontSize: 20),
                    ),
                    Text(
                      'रु. ${property.price.toString()}',
                      style: const TextStyle(fontSize: 15),
                    ),
                    Text(
                      'Location: ${property.name}, ${property.city}',
                      style: const TextStyle(fontSize: 15),
                    ),
                    Text(
                      property.propertyDescription ?? '',
                      style: const TextStyle(fontSize: 15),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Commercial Property Details',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Floor Area: ${property.floorArea}',
                              style: TextStyle(fontSize: 15),
                            ),
                            Text(
                              'Parking Spaces: ${property.parkingSpaces}',
                              style: TextStyle(fontSize: 15),
                            ),
                            Text(
                              'Building Class: ${property.buildingClass}',
                              style: TextStyle(fontSize: 15),
                            ),
                            Text(
                              'Tenant Capacity: ${property.tenantCapacity}',
                              style: TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _showReviewDialog(context, property);
                      },
                      child: const Text('Give Review'),
                    ),
                    SizedBox(
                        height: 250,
                        child: ListView.builder(
                          itemCount: controller
                              .ratings.length, // Use the .length of the RxList
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
                                rating: rating.rating?.toDouble() ?? 0.0,
                                date: formatDate(rating.date),
                              );
                            }
                          },
                        )),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        launchDialer(property.phoneNumber);
      }),
    );
  }

  Future<void> launchDialer(String? phoneNumber) async {
    final Uri telUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(telUri)) {
      await launchUrl(telUri);
    } else {
      // Handle the error or notify the user
      print('Could not launch $telUri');
    }
  }

  void _showReviewDialog(BuildContext context, Commercial property) {
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
