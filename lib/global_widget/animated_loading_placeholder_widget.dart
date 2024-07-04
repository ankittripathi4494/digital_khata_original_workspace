import 'package:animated_loading_indicators/animated_loading_indicators.dart';
import 'package:flutter/material.dart';

class AnimatedImagePlaceholderLoader extends StatefulWidget {
  const AnimatedImagePlaceholderLoader({super.key});

  @override
  State<AnimatedImagePlaceholderLoader> createState() =>
      _AnimatedImageLoaderState();
}

/// AnimationControllers can be created with `vsync: this` because of
/// TickerProviderStateMixin.
class _AnimatedImageLoaderState extends State<AnimatedImagePlaceholderLoader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 35,
      height: 35,
      padding: const EdgeInsets.all(8),
      
      child: const ClockLoader(
        size: 35,
        frameColor: Colors.deepOrange,
        minuteColor: Colors.blue,
        hourColor: Colors.green,
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
