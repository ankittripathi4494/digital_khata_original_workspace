import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

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
      width: 100,
      height: 100,
      padding: const EdgeInsets.all(8),
      child: const LoadingIndicator(
          indicatorType: Indicator.lineSpinFadeLoader,

          /// Required, The loading type of the widget
          colors: [
            Colors.deepPurple,
            Colors.deepPurple,
            Colors.deepPurple,
            Colors.deepPurple,
            Colors.deepPurple
          ],

          /// Optional, The color collections
          strokeWidth: 2,

          /// Optional, The stroke of the line, only applicable to widget which contains line
          // backgroundColor: Colors.black,

          /// Optional, Background of the widget
          pathBackgroundColor: Colors.black

          /// Optional, the stroke backgroundColor
          ),
    );
  }
}
