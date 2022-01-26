import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:submission_bfaf_v2/model/response/restaurant.dart';

class ImageRestaurantListWidget extends StatelessWidget {

  final Restaurant restaurant;

  const ImageRestaurantListWidget({Key? key,
    required this.restaurant
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0)
          ),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(8.0),
                  topLeft: Radius.circular(8.0)
                ),
                child: Image.network(
                  "https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId}"
                ),
              ),
              const SizedBox(height: 8.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      restaurant.name,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Row(
                      children: [
                        Icon(
                          defaultTargetPlatform == TargetPlatform.android
                              ? Icons.star
                              : CupertinoIcons.star_circle,
                          color: Colors.yellow,
                        ),
                        const SizedBox(
                          width: 2.0,
                        ),
                        Text(
                            restaurant.rating.toString()
                        )
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 8.0),
            ],
          ),
        ),
      ],
    );
  }
}