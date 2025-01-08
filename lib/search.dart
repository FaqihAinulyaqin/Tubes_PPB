import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ureveryday_ppb/halamanproduk.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _controller = TextEditingController();
  List<Map<String, dynamic>> _products = [];
  bool _isLoading = false;
  final String apiUrl = dotenv.env['API_URL'].toString();

  // Fungsi untuk memanggil API pencarian produk
  Future<void> _searchProduk(String searchTerm) async {
    final url =
        Uri.parse('$apiUrl/api/search/searchProduk?searchTerm=$searchTerm');

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['data'] != null) {
          setState(() {
            _products = List<Map<String, dynamic>>.from(data['data']);
            _isLoading = false;
          });
        }
      } else {
        setState(() {
          _isLoading = false;
        });
        throw Exception('Failed to load products');
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pencarian Produk'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // TextField untuk mencari produk
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Cari Produk',
                labelStyle: TextStyle(color: Colors.blue),
                filled: true,
                fillColor: Colors.blue[50],
                contentPadding:
                    EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(color: Colors.blue, width: 2.0),
                ),
                suffixIcon: IconButton(
                  icon: Icon(Icons.search, color: Colors.blue),
                  onPressed: () {
                    _searchProduk(_controller
                        .text); // Menjalankan pencarian saat ikon search diklik
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            // Menampilkan hasil pencarian
            Container(
              padding: const EdgeInsets.all(8.0),
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _products.isEmpty
                      ? const Center(child: Text('Tidak ada Produk Tersedia'))
                      :  GridView.builder(
                              shrinkWrap: true,
                              physics: const AlwaysScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                              ),
                              itemCount: _products.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Halamanproduk(
                                          productId: _products[index]['id'],
                                        ),
                                      ),
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.blue[50],
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          // Gambar Produk
                                          Image.network(
                                            _products[index]['img_path'],
                                            width: 100,
                                            height: 100,
                                            fit: BoxFit.cover,
                                          ),

                                          const SizedBox(height: 8),
                                          // Nama Produk
                                          Text(
                                            _products[index]['nama_produk'],
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          // Harga Produk
                                          Text(
                                            'Rp ${_products[index]['harga_produk']}',
                                            style: const TextStyle(
                                                color: Colors.green),
                                          ),
                                          // Kategori Produk
                                          Text(
                                            _products[index]['kategori'],
                                            style: const TextStyle(
                                                color: Colors.grey),
                                          ),
                                        ],
                                      ),
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
