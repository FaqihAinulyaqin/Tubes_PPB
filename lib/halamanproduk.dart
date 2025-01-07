import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import 'Navbar.dart';

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

  @override
  void initState() {
    super.initState();
    fetchProductDetails(widget.productId);
  }

  Future<void> fetchProductDetails(int productId) async {
    try {
      final response = await http.get(
        Uri.parse(
            'http://192.168.100.47:3000/api/produk/getProdukById/$productId'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print("Response body: ${response.body}");

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
                                        Row(
                                          children: [],
                                        )
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
                                        ? Image.asset(
                                            product!["img_path"],
                                            width: 282,
                                            height: 272,
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
                                                child: Image.asset(
                                                  product![
                                                      "penjual_profilePic"],
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

                          SizedBox(height: 100),
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
                      setState(() {
                        isWishlisted = !isWishlisted;
                      });
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
