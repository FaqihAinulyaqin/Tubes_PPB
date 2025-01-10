import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ureveryday_ppb/login.dart';
import 'halamanproduk.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Wishlist extends StatefulWidget {
  const Wishlist({super.key});

  @override
  _WishlistState createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  bool isLoading = true;
  List<dynamic> products = [];
  final String apiUrl = dotenv.env['API_URL'].toString();

  @override
  void initState() {
    super.initState();
    fetchWishlist();
  }

 Future<void> fetchWishlist() async {
  try {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    if (token == null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Login()),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Harap login kembali.')),
      );

      return;
    }

    final response = await http.get(
      Uri.parse('$apiUrl/api/wishlist/getWishlist'),
      headers: {
        'Authorization': 'Bearer $token', // Header otentikasi
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);

      // Pastikan `data` ada dan merupakan List
      if (responseData['data'] != null && responseData['data'] is List) {
        final List<dynamic> data = responseData['data'];

        if (data.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Anda belum menambahkan wishlist')),
          );
          setState(() {
            isLoading = false;
          });
        } else {
          setState(() {
            isLoading = false;
            products = data; // Update daftar produk
          });
        }
      } else {
        throw Exception("Data tidak valid: ${responseData['data']}");
      }
    } else {
      setState(() {
        isLoading = false;
      });
      final error = json.decode(response.body);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal mengambil wishlist: ${error['message']}')),
      );
    }
  } catch (e) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Terjadi kesalahan: $e')),
    );
  }
}


  Future<void> removeFromWishlist(String id) async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(194, 210, 229, 100),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Icon(Icons.arrow_back_ios),
                      ),
                      onPressed: () {
                        Navigator.pop(context); // Go back to the previous page
                      },
                    ),
                  ),
                  Image.asset("Images/cat.png"),
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 8),
                        decoration: const BoxDecoration(
                          color: Color.fromRGBO(194, 210, 229, 100),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.notifications_active),
                          onPressed: () {},
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          color: Color.fromRGBO(194, 210, 229, 100),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.chat),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'WishList',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${products.length} items',
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Divider(
              thickness: 1.5,
              color: Color.fromARGB(255, 73, 71, 71),
              indent: 16,
              endIndent: 16,
            ),
            const SizedBox(height: 10),
            isLoading
                ? const Center(child: CircularProgressIndicator()) // Loader
                : products.isEmpty
                    ? Center(
                        child: Text(
                          'Wishlist Anda kosong.',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                        ),
                      )
                    : Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: products.length,
                          itemBuilder: (context, i) {
                            return Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: InkWell(
                                onTap: () {
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) =>
                                  //         Halamanproduk(product: products[i]),
                                  //   ),
                                  // );
                                },
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.network(
                                      products[i][
                                          "product_imgPath"], // Ensure this key matches your API response
                                      width: 80,
                                      height: 80,
                                      fit: BoxFit.cover,
                                    ),
                                    const SizedBox(width: 20),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            products[i][
                                                "product_namaProduk"], // Ensure this key matches your API response
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            products[i][
                                                "product_kategori"], // Ensure this key matches your API response
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Text(
                                            products[i][
                                                "product_hargaProduk"].toString(), // Ensure this key matches your API response
                                            style:
                                                const TextStyle(fontSize: 14),
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            products[i][
                                                "product_subKategori"], // Ensure this key matches your API response
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.favorite),
                                      onPressed: () async {
                                        await removeFromWishlist(products[i][
                                            "id"]); // Ensure this key matches your API response
                                        setState(() {
                                          products.removeAt(i);
                                        });
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                                'Item removed from wishlist'),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
          ],
        ),
      ),
    );
  }
}
