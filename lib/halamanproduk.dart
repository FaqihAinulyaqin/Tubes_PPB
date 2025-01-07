// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'Navbar.dart';
import 'chat.dart';
import 'Ulasan.dart';

class Halamanproduk extends StatelessWidget {
  final Map<String, dynamic> product;

  const Halamanproduk({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Mirip Appbar
            Container(
              margin: const EdgeInsets.only(top: 20),
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Container(
                        height: 36,
                        width: 36,
                        margin: EdgeInsets.only(left: 20, top: 12),
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
                                MaterialPageRoute(
                                  builder: (context) => const Navbar(),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Logo
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: Image.asset(
                          'Images/Logo.png',
                          width: 73,
                          height: 43,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),

                  // Notif dan Pesan
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 12, top: 12),
                        padding: const EdgeInsets.all(5),
                        child: Icon(Icons.notifications),
                        decoration: BoxDecoration(
                          color: Color(0xFFC2D2E5),
                          borderRadius: BorderRadius.circular(180),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(5),
                        margin: const EdgeInsets.only(right: 20, top: 12),
                        child: Icon(Icons.chat),
                        decoration: BoxDecoration(
                          color: Color(0xFFC2D2E5),
                          borderRadius: BorderRadius.circular(180),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Nama Produk
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  product["name"], // Menampilkan nama produk yang dipilih
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 38),

            // Foto Produk
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  product["image"], // Menggunakan gambar produk yang dipilih
                  width: 282,
                  height: 272,
                ),
              ],
            ),

            const SizedBox(height: 18),

            // Product Description Text
            const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  Text(
                    'Product Description: ',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            // Deskripsi Produk
            const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  Text(
                    textAlign: TextAlign.justify,
                    '20.9 Megapixels, DX-Format CMOS Sensor,\n'
                    'EXPEED 5 Image Processor, 3.2" Touchscreen\n'
                    'LCD, 4K UHD Video at 30 fps, Multi-CAM\n'
                    '3500FX II 51-Point AF System, Bluetooth\n'
                    'and Wi-Fi, Include AF-S DX 18-140mm\n'
                    'f/3.5-5.6G ED VR Lens',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 7),

            // Harga Produk
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  Text(
                    product["price"], // Menggunakan harga produk yang dipilih
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // Profile Pic Seller
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Image.asset(
                    'Images/ProfilePicSeller.png',
                    alignment: Alignment.centerLeft,
                    height: 55,
                    width: 55,
                  ),
                ),

                // Nama Penjual
                const Padding(
                  padding: EdgeInsets.only(right: 80),
                  child: Text(
                    'JisooNampyeon',
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
                  ),
                ),

                // Ulasan Penjual
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Ulasan()),
                      );
                    },
                    child: Image.asset(
                      'Images/Bintang.png',
                      alignment: Alignment.centerRight,
                      height: 20,
                      width: 115,
                    ),
                  ),
                )
              ],
            ),

            const SizedBox(height: 22),

            // Button Chat penjual sekarang
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Chat()),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(35),
                        color: Colors.black,
                      ),
                      width: 314,
                      height: 56,
                      alignment: Alignment.center,
                      child: const Text(
                        'Chat Penjual Sekarang',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),

                // Button masukan ke wishlist
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: IconButton(
                    icon: Icon(
                      Icons.favorite, // Tombol untuk menambahkan ke wishlist
                      size: 36,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      // Logika untuk menambahkan ke wishlist (jika ada)
                    },
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
