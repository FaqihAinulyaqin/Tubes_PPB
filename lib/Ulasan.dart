import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'HalamanUtama.dart';
<<<<<<< HEAD
import 'halamanproduk.dart';
=======
>>>>>>> origin/Faqih-1302220086

class Ulasan extends StatefulWidget {
  const Ulasan({super.key});

  @override
  State<Ulasan> createState() => _UlasanState();
}

class _UlasanState extends State<Ulasan> {
  double _currentRating = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            children: [
              SizedBox(height: 20),
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(194, 210, 229, 100),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Icon(Icons.arrow_back_ios),
                      ),
                      onPressed: () {},
                    ),
                  ),
                  Image.asset("Images/cat.png"),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(194, 210, 229, 100),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: Icon(Icons.notifications_active),
                          onPressed: () {},
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(194, 210, 229, 100),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: Icon(Icons.chat),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 35),
              // Konten
              Text(
                'Ulasan',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Berikan Ulasan anda',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 10),
              TextField(
                maxLines: 2,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Tuliskan ulasan Anda di sini...',
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Tambahkan Foto :',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 10),

              ElevatedButton(
                onPressed: () {},
                child: Text(
                  'Pilih Foto',
                  style:
                      TextStyle(color: const Color.fromARGB(255, 67, 93, 125)),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Berikan rating :',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 10),

              RatingBar(
                minRating: 1,
<<<<<<< HEAD
                maxRating: 5,
=======
                maxRating: 4,
>>>>>>> origin/Faqih-1302220086
                initialRating: _currentRating,
                allowHalfRating: true,
                onRatingUpdate: (rating) {
                  setState(() {
                    _currentRating = rating;
                  });
                },
                glowColor: const Color.fromARGB(255, 153, 172, 235),
                glowRadius: 5,
                itemSize: 36,
                tapOnlyMode: true,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                ratingWidget: RatingWidget(
                    full: Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    half: Icon(Icons.star, color: Colors.amber),
                    empty: Icon(
                      Icons.star,
                      color: const Color.fromARGB(255, 82, 96, 126),
                    )),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Berhasil'),
                        content: Text('Ulasan Anda berhasil dikirim!'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              // Kembali ke halaman utama
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HalamanUtama(),
                                ),
                                (Route<dynamic> route) => false,
                              );
                            },
                            child: Text('Kembali ke Halaman Utama'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text(
                  'Submit',
                  style:
                      TextStyle(color: const Color.fromARGB(255, 67, 93, 125)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
