import 'package:flutter/material.dart';
import 'halamanproduk.dart';
<<<<<<< HEAD
import 'package:ureveryday_ppb/HalamanUtama.dart';
=======
>>>>>>> origin/Faqih-1302220086

class Wishlist extends StatefulWidget {
  const Wishlist({super.key});

  @override
  _WishlistState createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  final List<Map<String, dynamic>> products = [
    {
      'image': 'Images/camera.png',
      'name': 'Nikon D7500',
      'category': 'DSLR-Camera',
      'price': 'Rp. 13.000.000,00',
      'bundle': 'Non-Bundle',
    },
    {
      'image': 'Images/gitar.png',
      'name': 'Gitar Yamaha LL16D ARE',
      'category': 'Guitar',
      'price': 'Rp. 14.500.000,00',
      'bundle': 'Bundle + Capo',
    },
    {
      'image': 'Images/light stick.png',
      'name': 'Lightstick Le Sserafim',
      'category': 'Lightstick',
      'price': 'Rp. 814.000,00',
      'bundle': 'K-Pop',
    },
    {
      'image': 'Images/boots.png',
      'name': 'black boots',
      'category': 'footwear',
      'price': 'Rp. 529.000,00',
      'bundle': 'Non-Bundle',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20),
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
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
            ),
            SizedBox(height: 20),
            //konten
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'WishList',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${products.length} items',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
<<<<<<< HEAD
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {},
                  ),
=======
>>>>>>> origin/Faqih-1302220086
                ],
              ),
            ),
            SizedBox(height: 10),
            Divider(
              thickness: 1.5,
              color: const Color.fromARGB(255, 73, 71, 71),
              indent: 16,
              endIndent: 16,
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16),
                itemCount: products.length,
                itemBuilder: (context, i) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                Halamanproduk(product: products[i]),
                          ),
                        );
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            products[i]["image"],
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  products[i]["name"],
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  products[i]["category"],
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  products[i]["price"],
                                  style: TextStyle(fontSize: 14),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  products[i]["bundle"],
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.favorite),
                            onPressed: () {
                              setState(() {
                                products.removeAt(i);
                              });
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
