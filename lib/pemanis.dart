import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Pemanis extends StatefulWidget {
  const Pemanis({super.key});

  @override
  State<Pemanis> createState() => _PemanisState();
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class _PemanisState extends State<Pemanis> {
  @override
  void initState() {
    super.initState();
    _requestNotificationPermission();
  }

  void _requestNotificationPermission() async {
    final bool? granted = await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    if (granted != null && !granted) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Izin notifikasi ditolak oleh pengguna ')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'WELCOME',
              style: GoogleFonts.inter(
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'TO',
              style: GoogleFonts.inter(
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'UREveryday',
              style: GoogleFonts.inter(
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
            Center(
              child: Image.asset(
                'assets/Woman shopping online on tablet.png',
                width: 338,
                height: 339,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 5),
            Center(
              child: Text(
                'A platform for you to sell or buy\n anything you need second-hand',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 50),
            Center(
              child: OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Login(),
                    ),
                  );
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.black, width: 2.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 15.0),
                ),
                child: Text(
                  'Shop Now',
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
