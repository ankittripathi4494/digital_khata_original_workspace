// ignore_for_file: avoid_print

import 'package:firebase_messaging/firebase_messaging.dart';

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

  // Initialize FCM settings and request permissions
  void _initializeFCM() {
    _requestPermission();
    _firebaseMessaging.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        _handleMessage(message);
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
    _handleMessage(message);
  }

  // Handle messages when the app is opened from a notification
  void _onMessageOpenedApp(RemoteMessage message) {
    print('Message clicked!: ${message.messageId}');
    // Handle the message here
    _handleMessage(message);
  }

  // Subscribe to a topic
  Future<void> subscribeToTopic(String topic) async {
    await _firebaseMessaging.subscribeToTopic(topic);
  }

  // Unsubscribe from a topic
  Future<void> unsubscribeFromTopic(String topic) async {
    await _firebaseMessaging.unsubscribeFromTopic(topic);
  }

  // Handle the received message
  void _handleMessage(RemoteMessage message) {
    // Custom logic for handling the message
    print('Handling message: ${message.data}');
  }
}
