import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:ureveryday_ppb/login.dart';
import 'package:url_launcher/url_launcher.dart';
import 'Navbar.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Halamanproduk extends StatefulWidget {
  final int productId;

  const Halamanproduk({super.key, required this.productId});

  @override
  _HalamanprodukState createState() => _HalamanprodukState();
}

class _HalamanprodukState extends State<Halamanproduk> {
  Map<String, dynamic>? product;
  bool isLoading = true;
  String? errorMessage;
  bool isWishlisted = false;
  final String apiUrl = dotenv.env['API_URL'].toString();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    fetchProductDetails(widget.productId);
    _initializeNotifications;
  }

  void _initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void showProfileUpdatedNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'add_wishlist_channel',
      'add new wishlist Notifications',
      channelDescription: 'Notifications for add new wishlist',
      importance: Importance.high,
      priority: Priority.high,
      ticker: 'ticker',
      icon: 'ic_notification', 
    );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      'Yeeey!!!!',
      'wishlist anda sudah ditambahkann!',
      platformChannelSpecifics,
    );
  }

  Future<void> fetchProductDetails(int productId) async {
    try {
      final response = await http.get(
        Uri.parse('$apiUrl/api/produk/getProdukById/$productId'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          if (data != null &&
              data is Map<String, dynamic> &&
              data["data"] != null) {
            if (data["data"] is List && (data["data"] as List).isNotEmpty) {
              product = data["data"][0];
            } else if (data["data"] is Map<String, dynamic>) {
              product = data["data"];
            } else {
              errorMessage = "Data produk tidak ditemukan.";
            }
          } else {
            errorMessage = "Data produk tidak ditemukan.";
          }
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = "Gagal memuat produk (Error ${response.statusCode})";
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = "Terjadi kesalahan: $e";
        isLoading = false;
      });
    }
  }

  Future<void> addWishlist(int product_id) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');

      if (token == null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Login()),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Harap login kembali.')),
        );

        return;
      }

      final response = await http.post(
        Uri.parse('$apiUrl/api/wishlist/addWishlist/$product_id'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        setState(() {
          isWishlisted = !isWishlisted;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('berhasil menambahkan wishlist.')),
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Navbar()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal menambahkan wishlist.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('terjadi error.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final Uri WhatsAppNumber =
        Uri.parse('https://wa.me/${product?["penjual_nomorWA"]}');
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : errorMessage != null
                    ? Center(child: Text(errorMessage!))
                    : product == null
                        ? const Center(child: Text("Produk tidak ditemukan."))
                        : SingleChildScrollView(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        IconButton(
                                          icon: const Icon(
                                              Icons.arrow_back_ios_new_rounded),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const Navbar()),
                                            );
                                          },
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 50),
                                          child: Image.asset(
                                            'Images/Logo.png',
                                            width: 73,
                                            height: 43,
                                          ),
                                        ),
                                        const SizedBox(height: 30),
                                      ],
                                    ),
                                  ),

                                  const SizedBox(height: 20),

                                  // Nama Produk
                                  Center(
                                    child: Text(
                                      product?["nama_produk"] ??
                                          "Nama Produk Tidak Tersedia",
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 20),

                                  // Gambar Produk
                                  Center(
                                    child: product?["img_path"] != null
                                        ? Image.network(
                                            product!['img_path'],
                                            width: 300,
                                            height: 300,
                                            fit: BoxFit.cover,
                                          )
                                        : const Placeholder(
                                            fallbackWidth: 282,
                                            fallbackHeight: 272,
                                          ),
                                  ),
                                  const SizedBox(height: 20),

                                  // Deskripsi Produk
                                  const Text(
                                    'Deskripsi Produk:',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    product?["deskripsi"] ??
                                        "Deskripsi tidak tersedia",
                                    textAlign: TextAlign.justify,
                                    style: const TextStyle(fontSize: 14),
                                  ),

                                  const SizedBox(height: 20),

                                  // Harga Produk
                                  Text(
                                    product?["harga_produk"] != null
                                        ? 'Rp ${product?["harga_produk"]}'
                                        : "Harga tidak tersedia",
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),

                                  const SizedBox(height: 20),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 1),
                                        child: product?["penjual_profilePic"] !=
                                                null
                                            ? ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                child: Image.network(
                                                  product![
                                                      'penjual_profilePic'],
                                                  width: 40,
                                                  height: 40,
                                                  fit: BoxFit.cover,
                                                ),
                                              )
                                            : const Placeholder(
                                                fallbackWidth: 40,
                                                fallbackHeight: 40,
                                              ),
                                      ),
                                      TextButton(
                                        onPressed: () {},
                                        child: Text(
                                          product?["penjual_username"] != null
                                              ? product!["penjual_username"]
                                              : "Nama User Tidak",
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 20),
                                ]),
                          ),
            const SizedBox(height: 10),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(35),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 60),
                    ),
                    onPressed: () {
                      launchUrl(WhatsAppNumber);
                    },
                    child: const Text(
                      'Chat Penjual Sekarang',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 10),
                  IconButton(
                    icon: Icon(
                      isWishlisted ? Icons.favorite : Icons.favorite_border,
                      color: isWishlisted ? Colors.red : Colors.grey,
                      size: 30,
                    ),
                    onPressed: () {
                      int idproduct = product?["id"];
                      addWishlist(idproduct);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
