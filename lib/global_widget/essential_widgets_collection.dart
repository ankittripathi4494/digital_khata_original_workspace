import 'package:duration_button/duration_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EssentialWidgetsCollection {
  static showSuccessSnackbar(BuildContext context,
      {String? title, String? description}) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      backgroundColor:
          const Color.fromARGB(255, 183, 166, 172).withOpacity(0.6),
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
      backgroundColor:
          const Color.fromARGB(255, 183, 166, 172).withOpacity(0.6),
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
      backgroundColor:
          const Color.fromARGB(255, 183, 166, 172).withOpacity(0.6),
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
      backgroundColor:
          const Color.fromARGB(255, 183, 166, 172).withOpacity(0.6),
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
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          shadowColor: Colors.white,
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

  static showCustomAlertDialog(BuildContext context,
      {Widget? icon,
      Widget? title,
      Widget? content,
      ShapeBorder? customShape,
      EdgeInsetsGeometry? customIconPadding,
      EdgeInsetsGeometry? customTitlePadding,
      EdgeInsetsGeometry? customContentPadding,
      EdgeInsetsGeometry? customActionPadding,
      List<Widget>? customActions,
      MainAxisAlignment? customActionAlignment,
      bool? isDissmissable,
      Color? customBackgroundColor,
      Color? customSurfaceTintColor,
      Color? customShadowColor}) {
    return showDialog(
      context: context,
      barrierDismissible: (isDissmissable != null) ? isDissmissable : true,
      builder: (context) {
        return AlertDialog(
          shape: customShape,
          backgroundColor: customBackgroundColor,
          surfaceTintColor: customSurfaceTintColor,
          shadowColor: customShadowColor,
          titlePadding: customTitlePadding,
          contentPadding: customContentPadding,
          iconPadding: customIconPadding,
          actionsPadding: customActionPadding,
          actionsAlignment: customActionAlignment,
          icon: (icon != null) ? icon : null,
          title: (title != null) ? title : null,
          content: (content != null) ? content : null,
          actions: (customActions != null) ? customActions : null,
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

  static imagePicker(BuildContext context,
      {Function()? galleryFunc, Function()? cameraFunc}) async {
    return showModalBottomSheet(
      backgroundColor: Colors.white,
      scrollControlDisabledMaxHeightRatio: 0.5,
      showDragHandle: true,
      context: context,
      builder: (context) {
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Choose an option",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 20),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                      style: IconButton.styleFrom(
                        foregroundColor: Colors.deepPurple,
                        iconSize: 30,
                      ),
                      onPressed: galleryFunc,
                      icon: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            FontAwesomeIcons.images,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Gallery",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 14),
                          ),
                        ],
                      )),
                  IconButton(
                      style: IconButton.styleFrom(
                        foregroundColor: Colors.green,
                        iconSize: 30,
                      ),
                      onPressed: cameraFunc,
                      icon: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            FontAwesomeIcons.camera,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Camera",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 14),
                          ),
                        ],
                      ))
                ],
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        );
      },
    );
  }
}
