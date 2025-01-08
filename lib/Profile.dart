import 'package:flutter/material.dart';
import 'package:ureveryday_ppb/Navbar.dart';
import 'package:ureveryday_ppb/api/auth_api.dart';
import 'package:ureveryday_ppb/api/user_api.dart';
import 'package:ureveryday_ppb/components/fields.dart';
import 'package:ureveryday_ppb/login.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';

class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final TextEditingController NamaDepanController = TextEditingController();
  final TextEditingController NamaBelakangController = TextEditingController();
  final TextEditingController UsernameController = TextEditingController();
  final TextEditingController EmailController = TextEditingController();
  final TextEditingController NumberController = TextEditingController();
  final TextEditingController AddressController = TextEditingController();
  var user;
  bool isLoading = false;
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    getUserProfile();
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

  Future<void> getUserProfile() async {
    if (!mounted) return;
    setState(() {
      isLoading = true;
    });
    try {
      var response = await AuthApi().getUserProfile();

      if (response['status'] == true && response['data'] != null) {
        user = response['data'];
        setState(() {
          user = response['data'];
          NamaDepanController.text = user[0]['nama_depan'].toString();
          NamaBelakangController.text = user[0]['nama_belakang'].toString();
          UsernameController.text = user[0]['username'].toString();
          EmailController.text = user[0]['email'].toString();
          NumberController.text = user[0]['no_telpon'].toString();
          AddressController.text = user[0]['alamat'].toString();
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text("Gagal memuat data pengguna: ${response['message']}")),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error memuat data pengguna: $e")),
      );
    }
    setState(() {
      isLoading = false;
    });
  }

  Future<void> logout() async {
    bool result = await AuthApi().logout();
    if (result) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Login()),
        (route) => false,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Anda sudah log out")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Logout failed")),
      );
    }
  }

  Future<void> updateProfle(String namaDepan, String namaBelakang, String email,
      String noTelpon, String alamat, File? foto) async {
    if (namaDepan.isEmpty ||
        namaBelakang.isEmpty ||
        email.isEmpty ||
        noTelpon.isEmpty ||
        alamat.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Semua field wajib diisi."),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    try {
      bool result = await UserApi().updateProfile(
          namaDepan, namaBelakang, email, noTelpon, alamat, foto);
      if (!mounted) return;
      if (result) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Navbar()),
          (route) => false,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Berhasil memperbarui profile")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Gagal memperbarui profile, coba lagi")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error dalam memperbarui profile")),
      );
      print(e);
    }
  }

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
                context, MaterialPageRoute(builder: (context) => Navbar()));
          },
        ),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(), // Loading indicator
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    SizedBox(height: 20),
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
                        GestureDetector(
                          onTap: () async {
                            await _pickImage(); // Memanggil fungsi untuk memilih gambar
                          },
                          child: CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.pink[100],
                            backgroundImage: _selectedImage != null
                                ? FileImage(
                                    _selectedImage!,
                                  )
                                : (user?[0]['img_path'] != null &&
                                        user[0]['img_path'].isNotEmpty)
                                    ? NetworkImage(user[0]['img_path'])
                                    : (_selectedImage != null
                                        ? FileImage(
                                            _selectedImage!) // Gambar yang dipilih
                                        : null) as ImageProvider?,
                            child: (user?[0]['img_path'] == null ||
                                        user[0]['img_path'].isEmpty) &&
                                    _selectedImage == null
                                ? Icon(
                                    Icons.person,
                                    size: 80,
                                    color: Colors.grey,
                                  )
                                : null,
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: () async {
                              await _pickImage(); // Memanggil fungsi untuk memilih gambar
                            },
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
                        ),
                      ],
                    ),

                    SizedBox(height: 20),
                    // Title Profil

                    SizedBox(height: 20),
                    // Form Profil
                    Fields(
                        FieldsController: NamaDepanController,
                        label: 'Nama depan',
                        value: 'value'),
                    SizedBox(height: 20),
                    Fields(
                        FieldsController: NamaBelakangController,
                        label: 'Nama belakang',
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
                    GestureDetector(
                      onTap: () async {
                        setState(() {
                          isLoading = true; // Menampilkan loading
                        });
                        String namaDepan = NamaDepanController.text;
                        String namaBelakang = NamaBelakangController.text;
                        String email = EmailController.text;
                        String noTelpon = NumberController.text;
                        String alamat = AddressController.text;

                        await updateProfle(namaDepan, namaBelakang, email,
                            noTelpon, alamat, _selectedImage);

                        setState(() {
                          isLoading = false; // Sembunyikan loading
                        });
                      },
                      child: Text(
                        'Save Account',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        logout();
                      },
                      child: Text(
                        'Log Out',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    SizedBox(height: 150),
                  ],
                ),
              ),
            ),
    );
  }
}
