import 'package:duration_button/duration_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

class EssentialWidgetsCollection {
  static showSuccessSnackbar(BuildContext context,
      {String? title, String? description}) {
    return showToast(description,
        context: context,
        backgroundColor: Colors.green,
        position: const StyledToastPosition(
            align: Alignment.bottomCenter, offset: 30),
        textStyle: const TextStyle(fontSize: 15.0, color: Colors.white),
        animation: StyledToastAnimation.scale,
        reverseAnimation: StyledToastAnimation.fade,
        animDuration: const Duration(seconds: 1),
        duration: const Duration(seconds: 4),
        curve: Curves.elasticOut,
        reverseCurve: Curves.linear);
  }

  static showErrorSnackbar(BuildContext context,
      {String? title, String? description}) {
    return showToast(description,
        context: context,
        backgroundColor: Colors.red,
        position: const StyledToastPosition(
            align: Alignment.bottomCenter, offset: 30),
        textStyle: const TextStyle(fontSize: 15.0, color: Colors.white),
        animation: StyledToastAnimation.scale,
        reverseAnimation: StyledToastAnimation.fade,
        animDuration: const Duration(seconds: 1),
        duration: const Duration(seconds: 4),
        curve: Curves.elasticOut,
        reverseCurve: Curves.linear);
  }

  static showSuggestionSnackbar(BuildContext context,
      {String? title, String? description}) {
    return showToast(description,
        context: context,
        backgroundColor: Colors.blue,
        position: const StyledToastPosition(
            align: Alignment.bottomCenter, offset: 30),
        textStyle: const TextStyle(fontSize: 15.0, color: Colors.white),
        animation: StyledToastAnimation.scale,
        reverseAnimation: StyledToastAnimation.fade,
        animDuration: const Duration(seconds: 1),
        duration: const Duration(seconds: 4),
        curve: Curves.elasticOut,
        reverseCurve: Curves.linear);
  }

  static showWarningSnackbar(BuildContext context,
      {String? title, String? description}) {
    return showToast(description,
        context: context,
        backgroundColor: Colors.orange,
        position: const StyledToastPosition(
            align: Alignment.bottomCenter, offset: 30),
        textStyle: const TextStyle(fontSize: 15.0, color: Colors.white),
        animation: StyledToastAnimation.scale,
        reverseAnimation: StyledToastAnimation.fade,
        animDuration: const Duration(seconds: 1),
        duration: const Duration(seconds: 4),
        curve: Curves.elasticOut,
        reverseCurve: Curves.linear);
  }

  static showAlertDialogForLogout(
    BuildContext context, {
    Widget? icon,
    String? title,
    String? content,
    Function()? taskOne,
    Function()? taskTwo,
  }) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          icon: (icon != null) ? icon : null,
          title: (title != null)
              ? Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.black),
                )
              : null,
          content: (content != null)
              ? Text(
                  content,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.black),
                )
              : null,
          actionsAlignment: MainAxisAlignment.spaceAround,
          actions: [
            OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.green, foregroundColor: Colors.white),
              onPressed: taskOne,
              label: const Text("Yes"),
              icon: const Icon(Icons.check_circle),
            ),
            OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.red, foregroundColor: Colors.white),
              onPressed: taskTwo,
              label: const Text("No"),
              icon: const Icon(Icons.cancel_rounded),
            )
          ],
        );
      },
    );
  }

  static showAlertDialogForLogoutMain(
    BuildContext context, {
    Widget? icon,
    String? title,
    String? content,
    Function()? taskOne,
    Function()? taskTwo,
  }) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          icon: (icon != null) ? icon : null,
          title: (title != null)
              ? Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.black),
                )
              : null,
          content: (content != null)
              ? Text(
                  content,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.black),
                )
              : null,
          actionsAlignment: MainAxisAlignment.spaceAround,
          actions: [
            OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.green, foregroundColor: Colors.white),
              onPressed: taskOne,
              label: const Text("Yes"),
              icon: const Icon(Icons.check_circle),
            ),
            OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.red, foregroundColor: Colors.white),
              onPressed: taskTwo,
              label: const Text("No"),
              icon: const Icon(Icons.cancel_rounded),
            )
          ],
        );
      },
    );
  }

  static showAlertDialog(
    BuildContext context, {
    Widget? icon,
    Widget? title,
    Widget? content,
  }) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          titlePadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          iconPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          actionsPadding:
              const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
          icon: (icon != null) ? icon : null,
          title: (title != null) ? title : null,
          content: (content != null) ? content : null,
        );
      },
    );
  }

  static showAlertDialogBack(
    BuildContext context, {
    Widget? icon,
    Widget? title,
    Widget? content,
  }) {
    return showDialog(
      context: context,
  
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          shadowColor: Colors.transparent,
          titlePadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          iconPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          actionsPadding:
              const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
          icon: (icon != null) ? icon : null,
          title: (title != null) ? title : null,
          content: (content != null) ? content : null,
        );
      },
    );
  }

  static DurationButton autoScheduleTask(BuildContext context,
      {Duration? taskWaitDuration, Function()? task, Widget? childWidget}) {
    return DurationButton(
        width: 1,
        height: 1,
        hoverColor: Colors.transparent,
        coverColor: Colors.transparent,
        splashColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        onComplete: task,
        onPressed: () {},
        duration: taskWaitDuration!,
        child: childWidget);
  }
}
