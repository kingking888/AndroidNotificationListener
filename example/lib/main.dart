import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:android_notification_listener/android_notification_listener.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AndroidNotificationListener _notifications;
  StreamSubscription<NotificationEvent> _subscription;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    startListening();
  }

  void onData(NotificationEvent event) {
    
    print(event);
    print('converting package extra to json');
    var jsonDatax = json.decode(event.packageExtra);
    print(jsonDatax);
  }

  void startListening() {
    _notifications = new AndroidNotificationListener();
    try {
      _subscription = _notifications.notificationStream.listen(onData);
    } on NotificationException catch (exception) {
      print(exception);
    }
  }

  void stopListening() {
    _subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
      ),
    );
  }
}
