import 'package:flutter/material.dart';

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
          //header
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
          // wishlist
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
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Container(
            height: 1.5,
            width: 380,
            color: const Color.fromARGB(255, 73, 71, 71),
          ),
          SizedBox(height: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              for (int i = 0; i < products.length; i++)
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    // width: 200,
                    // height: 80,
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image.asset(products[i]["image"],
                            width: 80, height: 80, fit: BoxFit.cover),
                        const SizedBox(width: 10),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                products[i]["name"],
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                products[i]["category"],
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                products[i]["price"],
                                style: const TextStyle(fontSize: 14),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 10),
                              Text(
                                products[i]["bundle"],
                                style: const TextStyle(
                                    fontSize: 14,
                                    color: Color.fromARGB(255, 131, 131, 131)),
                                textAlign: TextAlign.center,
                              ),
                            ]),
                        const SizedBox(width: 10),
                        IconButton(
                          icon: Icon(Icons.heart_broken),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          )
        ],
      ),
    ));
  }
}
