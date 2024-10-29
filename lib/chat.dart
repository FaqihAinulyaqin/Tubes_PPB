// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

import 'HalamanUtama.dart';
import 'chat2.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat>{
  //List
  List<Map<String, dynamic>> messages = [
    {
      'image': 'Images/ProfilePicSeller.png',
      'store': 'JisooNampyeon',
      'time': '<1 mnt',
      'message': 'Hello!!',
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(

        //Mirip Appbar
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 36,
                  width: 36,
                  margin: const EdgeInsets.only(left: 20, top: 20),
                  decoration: const BoxDecoration(
                    color: Color(0xFFC2D2E5),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Center(
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.black,
                        size: 20,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const HalamanUtama()),
                        );
                      },
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 20, left: 22),
                  child: Text(
                    'Chat',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
              ]
            ),
            const SizedBox(height: 20),

            //List Builder
            Expanded(
              child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index){
                  final message = messages[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Chat2(),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.grey.shade300, width: 1),
                          )
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //profile pic seller
                            Image.asset(
                              message['image'],
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(width: 8),

                            //informasi seller
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        message['store'],
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16
                                        ),
                                      ),
                                      Text(
                                        message['time'],
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12,
                                        )
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    message['message'],
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 14,
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    )
                  );
                }
              )
            ),
          ],
        ),
      )
    );
  }
}