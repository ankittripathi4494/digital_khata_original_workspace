// ignore_for_file: avoid_print

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:duration_button/duration_button.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class EssentialWidgetsCollection {
  static showSuccessSnackbar(BuildContext context,
      {String? title, String? description}) {
    // return toastification.show(
    //   context: context, // optional if you use ToastificationWrapper
    //   type: ToastificationType.success,
    //   style: ToastificationStyle.fillColored,
    //   autoCloseDuration: const Duration(seconds: 2),
    //   title: Text(title ?? 'Success',style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),),
    //   // you can also use RichText widget for title and description parameters
    //   description: RichText(text: TextSpan(text: description)),
    //   alignment: Alignment.bottomCenter,
    //   direction: TextDirection.ltr,
    //   animationDuration: const Duration(milliseconds: 300),
    //   animationBuilder: (context, animation, alignment, child) {
    //     return FadeTransition(
    //       opacity: animation,
    //       child: child,
    //     );
    //   },
    //   icon: const Icon(Icons.check_circle_rounded, color: Colors.white,),
    //   primaryColor: Colors.green,
    //   backgroundColor: Colors.green,
    //   foregroundColor: Colors.black,
    //   padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
    //   margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    //   borderRadius: BorderRadius.circular(12),
    //   boxShadow: const [
    //     BoxShadow(
    //       color: Color(0x07000000),
    //       blurRadius: 16,
    //       offset: Offset(0, 16),
    //       spreadRadius: 0,
    //     )
    //   ],
    //   showProgressBar: true,
    //   closeButtonShowType: CloseButtonShowType.onHover,
    //   closeOnClick: false,
    //   pauseOnHover: true,
    //   dragToClose: true,
    //   applyBlurEffect: false,
    //   callbacks: ToastificationCallbacks(
    //     onTap: (toastItem) => print('Toast ${toastItem.id} tapped'),
    //     onCloseButtonTap: (toastItem) =>
    //         print('Toast ${toastItem.id} close button tapped'),
    //     onAutoCompleteCompleted: (toastItem) =>
    //         print('Toast ${toastItem.id} auto complete completed'),
    //     onDismissed: (toastItem) => print('Toast ${toastItem.id} dismissed'),
    //   ),
    // );

    return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.transparent,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(10),
          content: AwesomeSnackbarContent(
            title: title ?? "Success",
            message: description ?? '',

            /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
            contentType: ContentType.success,
          ),
          duration: Durations.extralong3,
          elevation: 20,
        ),
        snackBarAnimationStyle: AnimationStyle(
            curve: Curves.easeInBack, duration: Durations.long2));
  }

  static showErrorSnackbar(BuildContext context,
      {String? title, String? description}) {
    // return toastification.show(
    //   context: context, // optional if you use ToastificationWrapper
    //   type: ToastificationType.error,
    //   style: ToastificationStyle.fillColored,
    //   autoCloseDuration: const Duration(seconds: 2),
    //   title: Text(
    //     title ?? 'Error',
    //     style: const TextStyle(
    //         color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
    //   ),
    //   // you can also use RichText widget for title and description parameters
    //   description: RichText(text: TextSpan(text: description)),
    //   alignment: Alignment.bottomCenter,
    //   direction: TextDirection.ltr,
    //   animationDuration: const Duration(milliseconds: 300),
    //   animationBuilder: (context, animation, alignment, child) {
    //     return FadeTransition(
    //       opacity: animation,
    //       child: child,
    //     );
    //   },
    //   icon: const Icon(
    //     Icons.cancel_rounded,
    //     color: Colors.white,
    //   ),
    //   primaryColor: Colors.red,
    //   backgroundColor: Colors.red,
    //   foregroundColor: Colors.black,
    //   padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
    //   margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    //   borderRadius: BorderRadius.circular(12),
    //   boxShadow: const [
    //     BoxShadow(
    //       color: Color(0x07000000),
    //       blurRadius: 16,
    //       offset: Offset(0, 16),
    //       spreadRadius: 0,
    //     )
    //   ],
    //   showProgressBar: true,
    //   closeButtonShowType: CloseButtonShowType.onHover,
    //   closeOnClick: false,
    //   pauseOnHover: true,
    //   dragToClose: true,
    //   applyBlurEffect: false,
    //   callbacks: ToastificationCallbacks(
    //     onTap: (toastItem) => print('Toast ${toastItem.id} tapped'),
    //     onCloseButtonTap: (toastItem) =>
    //         print('Toast ${toastItem.id} close button tapped'),
    //     onAutoCompleteCompleted: (toastItem) =>
    //         print('Toast ${toastItem.id} auto complete completed'),
    //     onDismissed: (toastItem) => print('Toast ${toastItem.id} dismissed'),
    //   ),
    // );

    return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.transparent,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(10),
          content: AwesomeSnackbarContent(
            title: title ?? "Error",
            message: description ?? '',

            /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
            contentType: ContentType.failure,
          ),
          duration: Durations.extralong3,
          elevation: 20,
        ),
        snackBarAnimationStyle: AnimationStyle(
            curve: Curves.easeInBack, duration: Durations.long2));
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
