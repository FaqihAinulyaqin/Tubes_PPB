import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:ureveryday_ppb/api/sell_api.dart';
import 'Navbar.dart';

class Sell extends StatefulWidget {
  const Sell({super.key});

  @override
  State<Sell> createState() => _SellState();
}

class _SellState extends State<Sell> {
  final _formKey = GlobalKey<FormState>();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final TextEditingController _namaBarang = TextEditingController();
  final TextEditingController _hargaBarang = TextEditingController();
  final TextEditingController _stok = TextEditingController();
  final TextEditingController _kategori = TextEditingController();
  final TextEditingController _subKategori = TextEditingController();
  final TextEditingController _deskripsiKategori = TextEditingController();

  List<Map<String, dynamic>> products = [];
  File? _selectedImage;
  String errMessage = '';
  bool isLoading = false;

  void initState() {
    super.initState();
    _initializeNotifications();
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
      'add_product_channel',
      'add new product Notifications',
      channelDescription: 'Notifications for add new product',
      importance: Importance.high,
      priority: Priority.high,
      ticker: 'ticker',
    );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      'Yeeey!!!!',
      'Produk anda sudah ditambahkann!',
      platformChannelSpecifics,
    );
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<void> pickImage(ImageSource source) async {
    if (source == ImageSource.camera &&
        !(await Permission.camera.request().isGranted)) {
      openAppSettings();
      print("Camera permission denied");
      return;
    }

    if (source == ImageSource.gallery &&
        !(await Permission.photos.request().isGranted)) {
      openAppSettings();
      print("Photo library permission denied");
      return;
    }

    try {
      final pickedImage = await ImagePicker().pickImage(source: source);
      if (pickedImage != null) {
        setState(() {
          _selectedImage = File(pickedImage.path);
        });
      }
    } catch (e) {
      print("Error picking image: $e");
    }
  }

  Future<void> _addProduk(
    String namaproduk,
    String hargaproduk,
    String stok,
    String kategori,
    String subkategori,
    String deskripsi,
    File? foto,
  ) async {
    // Validasi untuk memastikan semua field tidak kosong
    if (namaproduk.isEmpty ||
        hargaproduk.isEmpty ||
        stok.isEmpty ||
        kategori.isEmpty ||
        foto == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Semua field wajib diisi, termasuk foto."),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      if (!mounted) return;
      setState(() {
        isLoading = true;
      });
      var response = await SellApi().addProduk(namaproduk, hargaproduk, stok,
          kategori, subkategori, deskripsi, foto);
      
      if (!mounted) return;
      if (response['status'] == true) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Navbar()),
          (route) => false,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Produk berhasil diupload.')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response['message'])),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Terjadi kesalahan saat mengunggah produk.')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
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
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: 10),
                        Text(
                          'Upload Produk',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.center, // Pusatkan kolom
                      children: [
                        const Text(
                          'Upload Images',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 20),

                        // Validasi apakah gambar sudah diunggah atau belum
                        if (_selectedImage == null)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ElevatedButton.icon(
                                onPressed: () async {
                                  await pickImage(ImageSource.gallery);
                                  setState(() {});
                                },
                                icon: const Icon(Icons.upload),
                                label: const Text('Choose File'),
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                'Maximum 1 image.',
                                style:
                                    TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                'Anda belum mengunggah gambar.',
                                style:
                                    TextStyle(color: Colors.red, fontSize: 14),
                              ),
                            ],
                          )
                        else
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Gambar berhasil diunggah!',
                                style: TextStyle(
                                    color: Colors.green, fontSize: 14),
                              ),
                              const SizedBox(height: 10),
                              // Tampilkan preview gambar yang diunggah
                              Image.file(
                                _selectedImage!,
                                width: 200,
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(height: 20),
                              ElevatedButton.icon(
                                onPressed: () async {
                                  // Ganti gambar
                                  await pickImage(ImageSource.gallery);
                                  setState(() {});
                                },
                                icon: const Icon(Icons.refresh),
                                label: const Text('Change Image'),
                              ),
                            ],
                          ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Nama Produk
                    TextFormField(
                      controller: _namaBarang,
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
                      controller: _hargaBarang,
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
                      controller: _stok,
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
                      controller: _kategori,
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
                      controller: _subKategori,
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
                      controller: _deskripsiKategori,
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

                    // Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            String namaproduk = _namaBarang.text;
                            String hargaproduk = _hargaBarang.text;
                            String stok = _stok.text;
                            String kategori = _kategori.text;
                            String subkategori = _subKategori.text;
                            String deskripsi = _deskripsiKategori.text;
                            _addProduk(namaproduk, hargaproduk, stok, kategori,
                                subkategori, deskripsi, _selectedImage);
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
                    if (isLoading)
                      const Center(
                        child: CircularProgressIndicator(),
                      ),
                    const SizedBox(height: 150),
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
