import 'package:duration_button/duration_button.dart';
import 'package:flutter/material.dart';

class EssentialWidgetsCollection {
  static showSuccessSnackbar(BuildContext context,
      {String? title, String? description}) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      backgroundColor: Color.fromARGB(255, 231, 199, 210),
      padding: const EdgeInsets.all(0),
      margin: EdgeInsets.symmetric(
          vertical: 10, horizontal: MediaQuery.of(context).size.width * 0.2),
      behavior: SnackBarBehavior.floating,
      duration: Durations.long2,
      content: TextButton.icon(
        onPressed: null,
        icon: Image.asset(
          "resources/images/logo.png",
          width: 20,
          height: 20,
        ),
        label: Text(
          description!,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 15,
          ),
        ),
      ),
    ));
  }

  static showErrorSnackbar(BuildContext context,
      {String? title, String? description}) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      backgroundColor: Color.fromARGB(255, 231, 199, 210),
      padding: const EdgeInsets.all(0),
      margin: EdgeInsets.symmetric(
          vertical: 10, horizontal: MediaQuery.of(context).size.width * 0.2),
      behavior: SnackBarBehavior.floating,
      duration: Durations.long2,
      content: TextButton.icon(
        onPressed: null,
        icon: Image.asset(
          "resources/images/logo.png",
          width: 20,
          height: 20,
        ),
        label: Text(
          description!,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 15,
          ),
        ),
      ),
    ));
  }

  static showSuggestionSnackbar(BuildContext context,
      {String? title, String? description}) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      backgroundColor: Color.fromARGB(255, 231, 199, 210),
      padding: const EdgeInsets.all(0),
      margin: EdgeInsets.symmetric(
          vertical: 10, horizontal: MediaQuery.of(context).size.width * 0.2),
      behavior: SnackBarBehavior.floating,
      duration: Durations.long2,
      content: TextButton.icon(
        onPressed: null,
        icon: Image.asset(
          "resources/images/logo.png",
          width: 20,
          height: 20,
        ),
        label: Text(
          description!,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 15,
          ),
        ),
      ),
    ));
  }

  static showWarningSnackbar(BuildContext context,
      {String? title, String? description}) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      backgroundColor: Color.fromARGB(255, 231, 199, 210),
      padding: const EdgeInsets.all(0),
      margin: EdgeInsets.symmetric(
          vertical: 10, horizontal: MediaQuery.of(context).size.width * 0.2),
      behavior: SnackBarBehavior.floating,
      duration: Durations.long2,
      content: TextButton.icon(
        onPressed: null,
        icon: Image.asset(
          "resources/images/logo.png",
          width: 20,
          height: 20,
        ),
        label: Text(
          description!,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 15,
          ),
        ),
      ),
    ));
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
