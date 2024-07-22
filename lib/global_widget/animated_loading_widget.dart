// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:animated_loading_indicators/animated_loading_indicators.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

enum LoaderType { general, placeholder, refresher, splash }

class AnimatedImageLoader extends StatefulWidget {
  Indicator? customeIndicatorType;
  LoaderType? customLoaderType;
  AnimatedImageLoader(
      {super.key, Indicator? indicatorType, LoaderType? loaderType}) {
    customeIndicatorType = indicatorType;
    customLoaderType = loaderType;
  }
  @override
  State<AnimatedImageLoader> createState() => _AnimatedImageLoaderState();
}

/// AnimationControllers can be created with `vsync: this` because of
/// TickerProviderStateMixin.
class _AnimatedImageLoaderState extends State<AnimatedImageLoader> {
  @override
  Widget build(BuildContext context) {
    if (widget.customLoaderType == LoaderType.placeholder) {
      return placeholderLoaderType(
          indicatorType: widget.customeIndicatorType,
          loaderType: widget.customLoaderType);
    } else if (widget.customLoaderType == LoaderType.splash) {
      return splashLoaderType(
          indicatorType: widget.customeIndicatorType,
          loaderType: widget.customLoaderType);
    } else if (widget.customLoaderType == LoaderType.refresher) {
      return refershLoaderType(
          indicatorType: widget.customeIndicatorType,
          loaderType: widget.customLoaderType);
    } else {
      return generalLoaderType(
          indicatorType: widget.customeIndicatorType,
          loaderType: widget.customLoaderType);
    }
  }

  generalLoaderType({Indicator? indicatorType, LoaderType? loaderType}) {
    return Container(
      height: 50,
      width: 50,
      padding: const EdgeInsets.all(8),
      child: (indicatorType == null)
          ? const CircularProgressIndicator(
              backgroundColor: Colors.black,
              color: Colors.blue,
            )
          : LoadingIndicator(
              indicatorType: indicatorType,
              colors: const [
                Colors.deepPurple,
                Colors.deepPurple,
                Colors.deepPurple,
                Colors.deepPurple,
                Colors.deepPurple
              ],
              strokeWidth: 2,
              backgroundColor: null,
              pathBackgroundColor: null),
    );
  }

  placeholderLoaderType({Indicator? indicatorType, LoaderType? loaderType}) {
    return Container(
      width: 35,
      height: 35,
      padding: const EdgeInsets.all(8),
      child: (indicatorType == null)
          ? const ClockLoader(
              size: 35,
              frameColor: Colors.deepOrange,
              minuteColor: Colors.blue,
              hourColor: Colors.green,
            )
          : LoadingIndicator(
              indicatorType: indicatorType,
              colors: const [
                Colors.deepPurple,
                Colors.deepPurple,
                Colors.deepPurple,
                Colors.deepPurple,
                Colors.deepPurple
              ],
              strokeWidth: 2,
              backgroundColor: null,
              pathBackgroundColor: null),
    );
  }

  refershLoaderType({Indicator? indicatorType, LoaderType? loaderType}) {
    return Container(
      width: 35,
      height: 35,
      padding: const EdgeInsets.all(8),
      child: (indicatorType == null)
          ? const ClockLoader(
              size: 35,
              frameColor: Colors.deepOrange,
              minuteColor: Colors.blue,
              hourColor: Colors.green,
            )
          : LoadingIndicator(
              indicatorType: indicatorType,
              colors: const [
                Colors.white,
                Colors.white,
                Colors.white,
                Colors.white,
                Colors.white
              ],
              strokeWidth: 2,
              backgroundColor: null,
              pathBackgroundColor: null),
    );
  }

  splashLoaderType({Indicator? indicatorType, LoaderType? loaderType}) {
    return Container(
      height: 80,
      width: 80,
      padding: const EdgeInsets.all(8),
      child: (indicatorType == null)
          ? const CircularProgressIndicator(
              backgroundColor: Colors.black,
              color: Colors.blue,
            )
          : LoadingIndicator(
              indicatorType: indicatorType,
              colors: const [
                Colors.white,
                Colors.white,
                Colors.white,
                Colors.white,
                Colors.white
              ],
              strokeWidth: 3,
              backgroundColor: null,
              pathBackgroundColor: null),
    );
  }
}
