import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class PlatformWidget extends StatelessWidget {

  final Widget androidBuilder;
  final Widget iosBuilder;


  const PlatformWidget({Key? key,
    required this.androidBuilder,
    required this.iosBuilder
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return androidBuilder;
      case TargetPlatform.iOS:
        return iosBuilder;
      default:
        return androidBuilder;
    }
  }
}