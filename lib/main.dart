import 'package:flutter/material.dart';
import 'package:ureveryday_ppb/pages/profilePage.dart';
import 'package:ureveryday_ppb/pages/riwayatPembelian.dart';

  void main() {
    runApp(const MyApp());
  }

  class MyApp extends StatelessWidget {
    const MyApp({super.key});

    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
          useMaterial3: true,
        ),
        home:  Profilepage(),
      );
    }
  }
