// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

import 'notification.dart';

void main() async {
  await AwesomeNotifications().initialize(null, [
    NotificationChannel(
        channelGroupKey: "basic_channel_group",
        channelKey: "Basic_Channel",
        channelName: "Basic Name",
        channelDescription: "test")
  ], channelGroups: [
    NotificationChannelGroup(
        channelGroupKey: "basic_channel_group", channelGroupName: "Basic Group")
  ]);
  bool isAllowedToSendNotification =
      await AwesomeNotifications().isNotificationAllowed();
  if (!isAllowedToSendNotification) {
    AwesomeNotifications().requestPermissionToSendNotifications();
  }
  runApp(ChatApp());
}

class ChatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Chat2(),
    );
  }
}

class Chat2 extends StatefulWidget {
  const Chat2({super.key});

  @override
  _Chat2State createState() => _Chat2State();
}

class _Chat2State extends State<Chat2> {
  final List<Map<String, dynamic>> profileseller = [
    {
      'image': 'Images/ProfilePicSeller.png',
      'store': 'JisooNampyeon',
      'status': 'Online',
    }
  ];

  @override
  void initState() {
    AwesomeNotifications().setListeners(
        onActionReceivedMethod: NotificationController.onActionReceivedMethod,
        onNotificationCreatedMethod:
            NotificationController.onNotificationCreatedMethod,
        onNotificationDisplayedMethod:
            NotificationController.onNotificationDisplayedMethod,
        onDismissActionReceivedMethod:
            NotificationController.onDismissActionReceivedMethod);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final seller = profileseller[0];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 60,
        backgroundColor: Colors.white,
        elevation: 1,
        title: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded,
                  color: Colors.black),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            const SizedBox(width: 8),

            // Profile Image
            CircleAvatar(
              backgroundImage: AssetImage(seller['image']),
              radius: 20,
            ),
            const SizedBox(width: 12),

            // Store Name and Status
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  seller['store'],
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  seller['status'],
                  style: const TextStyle(
                    color: Colors.green,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ChatBubble(
                  message: "Hello!!",
                  time: "18.57",
                ),
              ),
            ),
          ),
          ChatInputField(),
        ],
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String message;
  final String time;

  ChatBubble({required this.message, required this.time});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.07,
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  message,
                  style: const TextStyle(color: Colors.black),
                ),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: const TextStyle(color: Colors.grey, fontSize: 10),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ChatInputField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                  hintText: "Write Your Message Here...",
                  hintStyle: const TextStyle(color: Colors.black45),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30))),
              style: const TextStyle(color: Colors.grey),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send_rounded, color: Colors.black),
            onPressed: () {
              AwesomeNotifications().createNotification(
                content: NotificationContent(
                  id: 2,
                  channelKey: "Basic_Channel",
                  title: "JisooNampyeon",
                  body: "Nilai A ya pak"
                )
              );
            },
          ),
        ],
      ),
    );
  }
}
