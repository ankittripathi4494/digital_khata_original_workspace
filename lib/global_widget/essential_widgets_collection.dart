import 'package:flutter/material.dart';

class EssentialWidgetsCollection {
  static showSuccessSnackbar(BuildContext context, String data) {
    return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(10),
          content: Text(
            data,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w300),
          ),
          duration: Durations.extralong3,
          elevation: 20,
        ),
        snackBarAnimationStyle: AnimationStyle(
            curve: Curves.easeInBack, duration: Durations.long2));
  }

  static showErrorSnackbar(BuildContext context, String data) {
    return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(10),
          content: Text(
            data,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.normal),
          ),
          duration: Durations.extralong3,
          elevation: 20,
        ),
        snackBarAnimationStyle: AnimationStyle(
            curve: Curves.easeInBack, duration: Durations.long2));
  }
}
