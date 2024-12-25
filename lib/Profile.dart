import 'package:flutter/material.dart';
import 'package:ureveryday_ppb/Navbar.dart';
import 'package:ureveryday_ppb/components/fields.dart';
import 'package:ureveryday_ppb/riwayatPembelian.dart';

class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final TextEditingController UsernameController = TextEditingController();
  final TextEditingController EmailController = TextEditingController();
  final TextEditingController NumberController = TextEditingController();
  final TextEditingController AddressController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Image.asset(
          'assets/catSleeping.png', // Replace with your image path
          width: 73,
          height: 43, // Adjust height as needed
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.push(
              context, 
              MaterialPageRoute(builder: (context) => Navbar())
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              SizedBox(height: 20),
              // Gambar Profil dan Icon Edit
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Your Profile',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),

              Divider(color: Colors.grey[700], thickness: 1, height: 30),
              Stack(
                alignment: Alignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.pink[100],
                    backgroundImage:
                        AssetImage('assets/pp.jpg'), // Path ke gambar profil
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      radius: 16,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.camera_alt,
                        size: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              // Title Profil

              SizedBox(height: 20),
              // Form Profil
              Fields(
                  FieldsController: UsernameController,
                  label: 'username',
                  value: 'value'),
              SizedBox(height: 20),
              Fields(
                  FieldsController: EmailController,
                  label: 'email',
                  value: 'value'),
              SizedBox(height: 20),
              Fields(
                  FieldsController: NumberController,
                  label: 'number',
                  value: 'value'),
              SizedBox(height: 20),
              Fields(
                  FieldsController: AddressController,
                  label: 'address',
                  value: 'value'),
              SizedBox(height: 20),
              // Tombol Change Account dan Log Out
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context) => RiwayatPembelian())
                  );
                }, 
                child: Text(
                  'Riwayat Pembelian',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                )
              ),
              GestureDetector(
                onTap: () {
                  // Aksi untuk ganti akun
                },
                child: Text(
                  'Change Account',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 16,
                  ),
                ),
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  // Aksi untuk log out
                },
                child: Text(
                  'Log Out',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
