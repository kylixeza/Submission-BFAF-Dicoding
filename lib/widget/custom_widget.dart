import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:submission_bfaf/model/response/restaurant.dart';

class ImageRestaurantListWidget extends StatelessWidget {

  final Restaurant restaurant;

  ImageRestaurantListWidget({
    required this.restaurant
  });

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
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(8.0),
                  topLeft: Radius.circular(8.0)
                ),
                child: Image.network(
                  "https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId}"
                ),
              ),
              SizedBox(height: 8.0),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      restaurant.name,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Row(
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
                    )
                  ],
                ),
              ),
              SizedBox(height: 8.0),
            ],
          ),
        ),
      ],
    );
  }
}

class TextFieldSearch extends StatefulWidget {
  @override
  _TextFieldSearchState createState() => _TextFieldSearchState();
}

class _TextFieldSearchState extends State<TextFieldSearch> {

  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TextField(
      controller: _controller,
      onSubmitted: (String value) {

      },
    );
  }
}