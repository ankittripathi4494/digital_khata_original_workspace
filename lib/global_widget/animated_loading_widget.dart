import 'package:flutter/material.dart';

class AnimatedImageLoader extends StatefulWidget {
  const AnimatedImageLoader({super.key});

  @override
  State<AnimatedImageLoader> createState() => _AnimatedImageLoaderState();
}

/// AnimationControllers can be created with `vsync: this` because of
/// TickerProviderStateMixin.
class _AnimatedImageLoaderState extends State<AnimatedImageLoader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      padding: const EdgeInsets.all(8),
      // child: const Material(
      //   child: TextLoaderIndicator(
      //     size: 25,
      //   ),
      // ),
      child: const CircularProgressIndicator(
        backgroundColor: Colors.black,
        color: Colors.blue,
      ),
      // child: const CircularProgressIndicator(
      //   // backgroundColor: Colors.blueGrey,
      //   color: Colors.deepPurple,
      // ),
      // child: const LoadingIndicator(
      //     indicatorType: Indicator.ballClipRotatePulse,

      //     /// Required, The loading type of the widget
      //     colors: [
      //       Colors.deepPurple,
      //       Colors.deepPurple,
      //       Colors.deepPurple,
      //       Colors.deepPurple,
      //       Colors.deepPurple
      //     ],

      //     /// Optional, The color collections
      //     strokeWidth: 2,

      //     /// Optional, The stroke of the line, only applicable to widget which contains line
      //     // backgroundColor: Colors.black,

      //     /// Optional, Background of the widget
      //     pathBackgroundColor: Colors.black

      //     /// Optional, the stroke backgroundColor
      //     ),
    );
  }
}
