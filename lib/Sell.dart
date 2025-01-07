import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'Navbar.dart';
import 'package:http/http.dart' as http;

class Sell extends StatefulWidget {
  const Sell({super.key});

  @override
  State<Sell> createState() => _SellState();
}

class _SellState extends State<Sell> {
  List<Map<String, dynamic>> products = [];
  final _formKey = GlobalKey<FormState>();
  File? _selectedImage;

  Future<void> sendData(products) async {
    final url = Uri.parse('http://localhost:3000/api/produk/addProduk');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode(products);

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      print('Data sent successfully');
    } else {
      print('Failed to send data');
    }
  }

  void initState() {
    super.initState();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File (pickedFile.path);
      });
    }
  }

  void toJson(String img_path, String nama_produk, int harga_produk, int stok,
      String kategori, String sub_kategori, String deskripsi) {
    final products = {
      'img_path': img_path,
      'nama_produk': nama_produk,
      'harga_produk': harga_produk,
      'stok': stok,
      'kategori': kategori,
      'sub_kategori': sub_kategori,
      'deskripsi': deskripsi
    };
    sendData(products);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Header with logo
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'images/Logo.png',
                          height: 50,
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          'Upload Produk',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Nama Produk
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Nama Produk',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Nama produk harus diisi';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),

                    // Harga Produk
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Harga',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Harga harus diisi';
                        }
                        if (int.tryParse(value) == null) {
                          return 'Harga harus berupa angka';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),

                    // Stok Produk
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Stok',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Stok harus diisi';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),

                    // Kategori
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Kategori',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Kategori harus diisi';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),

                    // Sub Kategori
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Sub Kategori',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Sub kategori harus diisi';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),

                    // Deskripsi
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Deskripsi',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 4,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Deskripsi harus diisi';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),

                    // Upload Image
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Upload Images',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton.icon(
                          onPressed: () {
                            // Implement file picker logic here
                          },
                          icon: const Icon(Icons.upload),
                          label: const Text('Choose File'),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Maximum 1 image.',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              // Save
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Produk berhasil disimpan'),
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 40,
                              vertical: 15,
                            ),
                            backgroundColor: Colors.blue,
                          ),
                          child: const Text('Save'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Navbar(), 
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 40,
                              vertical: 15,
                            ),
                            backgroundColor: Colors.grey,
                          ),
                          child: const Text('Cancel'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
