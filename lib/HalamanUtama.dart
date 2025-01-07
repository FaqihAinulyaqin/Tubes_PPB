import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ureveryday_ppb/search.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class HalamanUtama extends StatefulWidget {
  const HalamanUtama({super.key});

  @override
  State<HalamanUtama> createState() => _HalamanUtamaState();
}

class _HalamanUtamaState extends State<HalamanUtama> {
  bool loading = true;
  List<Map<String, dynamic>> products = [];
  String? selectedCategory;
  List<String> categories = [];
  final String apiUrl = dotenv.env['API_URL'].toString();

  // Mengambil produk dari API
  Future<void> _getProduk() async {
    try {
      final respon = await http
          .get(Uri.parse('$apiUrl/api/produk/getProduk'));
      if (respon.statusCode == 200) {
        final data = jsonDecode(respon.body);
        setState(() {
          products = List<Map<String, dynamic>>.from(data['data']);
          loading = false;
        });
      } else {
        setState(() {
          loading = false;
        });
        _showSnackBar(
            'Failed to fetch products. Status Code: ${respon.statusCode}');
      }
    } catch (e) {
      setState(() {
        loading = false;
      });
      _showSnackBar('Error fetching products: $e');
    }
  }

  // Mengambil kategori dari API
  Future<void> _getCategory() async {
    try {
      final respon = await http
          .get(Uri.parse('$apiUrl/api/produk/getCategory'));
      if (respon.statusCode == 200) {
        final data = jsonDecode(respon.body);
        setState(() {
          categories =
              List<String>.from(data['data'].map((item) => item['kategori']));
          loading = false;
        });
      } else {
        setState(() {
          loading = false;
        });
        _showSnackBar(
            'Failed to fetch category. Status Code: ${respon.statusCode}');
      }
    } catch (e) {
      setState(() {
        loading = false;
      });
      _showSnackBar('Error fetching categories: $e');
    }
  }

  // Mengambil produk sesuai kategori dari API
  Future<void> _getProdukByCategory(String category) async {
    setState(() {
      loading = true;
    });
    try {
      final respon = await http.get(Uri.parse(
          '$apiUrl/api/produk/getProduk/$category'));
      if (respon.statusCode == 200) {
        final data = jsonDecode(respon.body);
        setState(() {
          products = List<Map<String, dynamic>>.from(data['data']);
          loading = false;
        });
      } else {
        setState(() {
          loading = false;
        });
        _showSnackBar(
            'Failed to fetch products. Status Code: ${respon.statusCode}');
      }
    } catch (e) {
      setState(() {
        loading = false;
      });
      _showSnackBar('Error fetching products by category: $e');
    }
  }

  // Fungsi untuk refresh data produk
  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      loading = true;
    });
    _showSnackBar('Refreshed');
    await _getProduk();
  }

  // Snackbar
  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _getProduk();
    _getCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 20),
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 20),
                          child: IconButton(
                            icon: const Icon(Icons.menu),
                            onPressed: () {
                              showMenu(
                                context: context,
                                position:
                                    const RelativeRect.fromLTRB(20, 50, 100, 0),
                                items: categories.map((String category) {
                                  return PopupMenuItem<String>(
                                    value: category,
                                    child: TextButton(
                                        onPressed: () {
                                          _getProdukByCategory(category);
                                        },
                                        child: Text(category)),
                                  );
                                }).toList(),
                              ).then((String? newValue) {
                                if (newValue != null) {
                                  setState(() {
                                    selectedCategory = newValue;
                                  });
                                }
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextButton(
                            onPressed: _onRefresh,
                            child: Image.asset(
                              'Images/Logo.png',
                              width: 73,
                              height: 43,
                            ))
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: 36,
                          height: 36,
                          margin: const EdgeInsets.only(right: 12),
                          decoration: BoxDecoration(
                            color: const Color(0xFFC2D2E5),
                            borderRadius: BorderRadius.circular(180),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.notifications,
                              size: 20,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Container(
                          width: 36,
                          height: 36,
                          margin: const EdgeInsets.only(right: 20),
                          decoration: BoxDecoration(
                            color: const Color(0xFFC2D2E5),
                            borderRadius: BorderRadius.circular(180),
                          ),
                          child: Center(
                            child: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.chat,
                                size: 20,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Row(
                children: [
                  SizedBox(height: 20),
                ],
              ),
              // Tombol pencarian
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 20, right: 10),
                    width: MediaQuery.of(context).size.width - 40,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const search()),
                        );
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Search'),
                          Icon(Icons.search),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const Row(
                children: [
                  SizedBox(height: 20),
                ],
              ),
              // Promo Section
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    width: MediaQuery.of(context).size.width - 50,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color(0xFFC2D2E5),
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Promo',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  )
                ],
              ),
              const Row(
                children: [
                  SizedBox(height: 20),
                ],
              ),
              // Menampilkan Produk
              Container(
                padding: const EdgeInsets.all(8.0),
                child: loading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : products.isEmpty
                        ? const Center(
                            child: Text('Tidak ada Produk Tersedia'),
                          )
                        : GridView.builder(
                            shrinkWrap: true,
                            physics: const AlwaysScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                            itemCount: products.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.blue[50],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      // Gambar Produk
                                      Image.network(
                                        products[index]['img_path'],
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                      ),
                                      const SizedBox(height: 8),
                                      // Nama Produk
                                      Text(
                                        products[index]['nama_produk'],
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      // Harga Produk
                                      Text(
                                        'Rp ${products[index]['harga_produk']}',
                                        style: const TextStyle(
                                            color: Colors.green),
                                      ),
                                      // Kategori Produk
                                      Text(
                                        products[index]['kategori'],
                                        style:
                                            const TextStyle(color: Colors.grey),
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
      ),
    );
  }
}
