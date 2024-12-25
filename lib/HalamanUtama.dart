import 'package:flutter/material.dart';
import 'package:ureveryday_ppb/search.dart';
import 'halamanproduk.dart';
import 'chat.dart';

class HalamanUtama extends StatefulWidget {
  const HalamanUtama({super.key});

  @override
  _HalamanUtamaState createState() => _HalamanUtamaState();
}

class _HalamanUtamaState extends State<HalamanUtama> {
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
  String? selectedCategory;
  final List<String> categories = ['Category', 'Category', 'Category', 'Category'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 20),
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 20),
                          child: IconButton(
                            icon: Icon(Icons.menu),
                            onPressed: () {
                              showMenu(
                                context: context,
                                position: RelativeRect.fromLTRB(20, 50, 100, 0),
                                items: categories.map((String category) {
                                  return PopupMenuItem<String>(
                                    value: category,
                                    child: Text(category),
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
                      Image.asset(
                        'Images/Logo.png',
                        width: 73,
                        height: 43,
                      )
                    ],
                  ),
                    Row(
                      children: [
                        Container(
                          width: 36,
                          height: 36,
                          margin: EdgeInsets.only(right: 12),
                          child: Center(
                            child: Icon(Icons.notifications,size: 20, color: Colors.black,),
                          ),
                          decoration: BoxDecoration(
                            color: Color(0xFFC2D2E5),
                            borderRadius: BorderRadius.circular(180)
                          ),
                        ),
                        Container(
                          width: 36,
                          height: 36,
                          margin: EdgeInsets.only(right: 20),
                          child: Center(
                            child: IconButton(
                            onPressed: (){
                              Navigator.push(
                                context, 
                                MaterialPageRoute(builder: (context) => Chat())
                              );
                            }, 
                            icon: Icon(Icons.chat, size: 20,color: Colors.black,)
                          ),
                          ),
                          decoration: BoxDecoration(
                            color: Color(0xFFC2D2E5),
                            borderRadius: BorderRadius.circular(180)
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Row(
                children: [
                  SizedBox(height: 20,)
                ],
              ),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 10),
                    width: MediaQuery.of(context).size.width - 40,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context, 
                          MaterialPageRoute(builder: (context) => search())
                        );
                      }, 
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Search'),
                          Icon(Icons.search)
                        ],
                      )
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1),
                      borderRadius: BorderRadius.circular(20)
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(height: 20,)
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    width: MediaQuery.of(context).size.width - 50,
                    height: 200,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('Promo', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold), textAlign: TextAlign.center,)
                      ],
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color(0xFFC2D2E5),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  SizedBox(height: 20,)
                ],
              ),
              Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 2.3,
                              height: 191,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        'Jisoo\nNampyeon', 
                                        style: TextStyle(fontSize: 11),
                                      ),
                                      Image.asset(
                                        'Images/contohproduk.png',
                                        width: 85,
                                        height: 90,
                                      ),
                                    ],
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    child: TextButton(
                                      onPressed: (){
                                        Navigator.push(
                                          context, 
                                          MaterialPageRoute(builder: (context) => Halamanproduk(product: products[0],))
                                        );
                                      }, 
                                      child: Text('Buy Now', style: TextStyle(color: Colors.black))
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20)
                                    ),
                                  )
                                ],
                              ),
                              decoration: BoxDecoration(
                                color: Color(0xFFC2D2E5),
                                borderRadius: BorderRadius.circular(20) 
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 2.3,
                              height: 191,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text('Item'),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    child: TextButton(
                                      onPressed: (){
                                        
                                      }, 
                                      child: Text('Buy Now', style: TextStyle(color: Colors.black))
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20)
                                    ),
                                  )
                                ],
                              ),
                              decoration: BoxDecoration(
                                color: Color(0xFFC2D2E5),
                                borderRadius: BorderRadius.circular(20) 
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 12,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 2.3,
                              height: 191,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text('Item'),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    child: TextButton(
                                      onPressed: (){
                                        
                                      }, 
                                      child: Text('Buy Now', style: TextStyle(color: Colors.black))
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20)
                                    ),
                                  )
                                ],
                              ),
                              decoration: BoxDecoration(
                                color: Color(0xFFC2D2E5),
                                borderRadius: BorderRadius.circular(20) 
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 2.3,
                              height: 191,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text('Item'),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    child: TextButton(
                                      onPressed: (){
                                        
                                      }, 
                                      child: Text('Buy Now', style: TextStyle(color: Colors.black))
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20)
                                    ),
                                  )
                                ],
                              ),
                              decoration: BoxDecoration(
                                color: Color(0xFFC2D2E5),
                                borderRadius: BorderRadius.circular(20) 
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 12,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 2.3,
                              height: 191,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text('Item'),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    child: TextButton(
                                      onPressed: (){
                                        
                                      }, 
                                      child: Text('Buy Now', style: TextStyle(color: Colors.black))
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20)
                                    ),
                                  )
                                ],
                              ),
                              decoration: BoxDecoration(
                                color: Color(0xFFC2D2E5),
                                borderRadius: BorderRadius.circular(20) 
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 2.3,
                              height: 191,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text('Item'),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    child: TextButton(
                                      onPressed: (){
                                        
                                      }, 
                                      child: Text('Buy Now', style: TextStyle(color: Colors.black))
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20)
                                    ),
                                  )
                                ],
                              ),
                              decoration: BoxDecoration(
                                color: Color(0xFFC2D2E5),
                                borderRadius: BorderRadius.circular(20) 
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
