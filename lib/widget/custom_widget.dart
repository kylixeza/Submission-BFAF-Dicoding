import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:submission_bfaf/model/restaurant.dart';

class ImageRestaurantListWidget extends StatelessWidget {

  final Restaurant restaurant;

  ImageRestaurantListWidget({
    required this.restaurant
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0)
            ),
            child: Image.network(restaurant.pictureId),
          ),
        ),
        Card(
          shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(4.0))
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  defaultTargetPlatform == TargetPlatform.android
                      ? Icons.star
                      : CupertinoIcons.star_circle,
                  color: Colors.yellow,
                ),
                SizedBox(
                  width: 2.0,
                ),
                Text(
                  restaurant.rating.toString()
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}