// ignore_for_file: avoid_print

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class FirebaseMessagingHelper {
  static final FirebaseMessagingHelper _instance =
      FirebaseMessagingHelper._internal();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  // Private constructor
  FirebaseMessagingHelper._internal() {
    _initializeFCM();
  }

  // Public factory method to provide access to the singleton instance
  factory FirebaseMessagingHelper() {
    return _instance;
  }

  void initialize() {
    _initializeFCM();
    _initializeAwesomeNotifications();
  }

  // Initialize Awesome Notifications
  void _initializeAwesomeNotifications() {
    AwesomeNotifications().initialize(
      'resource://drawable/res_app_icon',
      [
        NotificationChannel(
          channelKey: 'vardan.com/dkapp',
          channelName: 'Basic notifications',
          channelDescription: 'Notification channel for basic tests',
          defaultColor: const Color(0xFF9D50DD),
          ledColor: const Color(0xFF9D50DD),
          playSound: true,
          importance: NotificationImportance.High,
        ),
      ],
    );
  }

  // Initialize FCM settings and request permissions
  void _initializeFCM() {
    _requestPermission();
    _firebaseMessaging.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        _showNotification(message);
      }
    });
    FirebaseMessaging.onMessage.listen(_onMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenedApp);
  }

  // Request notification permissions
  void _requestPermission() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    print('User granted permission: ${settings.authorizationStatus}');
   
  }

// Handle foreground messages
  void _onMessage(RemoteMessage message) {
    print('Received a message while in the foreground: ${message.messageId}');
    // Handle the message here
    _showNotification(message);
  }

  // Handle messages when the app is opened from a notification
  void _onMessageOpenedApp(RemoteMessage message) {
    print('Message clicked!: ${message.messageId}');
    // Handle the message here
    _showNotification(message);
  }

  // Subscribe to a topic
  Future<void> subscribeToTopic(String topic) async {
    await _firebaseMessaging.subscribeToTopic(topic);
  }

  // Unsubscribe from a topic
  Future<void> unsubscribeFromTopic(String topic) async {
    await _firebaseMessaging.unsubscribeFromTopic(topic);
  }

// Handle notification tap when app is terminated or in the background
  Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    await Firebase.initializeApp();
     print("background Notification is empty");
    if (message.data.isNotEmpty) {
      _showNotification(message);
    } else {
      print("background Notification is empty");
    }
  }

  // Handle the received message
  void _showNotification(RemoteMessage message) {
    // Custom logic for handling the message
    print('Handling message: ${message.data}');

    String? title = (message.notification!=null)
        ? message.notification?.title
        : 'Default Title';
    String? body = (message.notification!=null)
        ? message.notification?.body
        : 'Default Body';
    String imageUrl = (message.data.isNotEmpty) ? message.data['image'] : '';

    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: DateTime.now().millisecondsSinceEpoch.remainder(100000),
        channelKey: 'vardan.com/dkapp',
        title: title,
        body: body,
        bigPicture: imageUrl,
        notificationLayout: imageUrl.isNotEmpty
            ? NotificationLayout.BigPicture
            : NotificationLayout.Default,
      ),
    );
  }
}
