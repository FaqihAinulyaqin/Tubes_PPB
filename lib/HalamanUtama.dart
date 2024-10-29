import 'package:flutter/material.dart';
import 'package:ureveryday_ppb/Profile.dart';
import ''; //import file disini

class HalamanUtama extends StatefulWidget {
  const HalamanUtama({super.key});

  @override
  _HalamanUtamaState createState() => _HalamanUtamaState();
}

class _HalamanUtamaState extends State<HalamanUtama> {
  String? selectedCategory;
  final List<String> categories = ['Category', 'Category', 'Category', 'Category'];
  TextEditingController searchController = TextEditingController();

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
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 20),
                          child: Image.asset(
                            'Images/Logo.png',
                            height: 43,
                            width: 74,
                          )
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 12),
                          padding: EdgeInsets.all(5),
                          child: Icon(Icons.notifications),
                          decoration: BoxDecoration(
                            color: Color(0xFFC2D2E5),
                            borderRadius: BorderRadius.circular(180)
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          margin: EdgeInsets.only(right: 20),
                          child: Icon(Icons.chat),
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
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 20, right: 10),
                        width: MediaQuery.of(context).size.width - 100,
                        child: TextField(
                          controller: searchController,
                          decoration: InputDecoration(
                            hintText: 'Search...',
                            fillColor: Colors.white,
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Colors.black, width: 1),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 20),
                        padding: EdgeInsets.all(10),
                        child: Icon(Icons.search, weight: 24,),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(180),
                          color: Color(0xFFD9D9D9),
                        ),
                      )
                    ],
                  )
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
                              width: 220,
                              height: 200,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text('Item'),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(50, 12, 50, 12),
                                    child: TextButton(
                                      onPressed: (){
                                        Navigator.push(
                                          context, 
                                          MaterialPageRoute(builder: (context) => Profile()) //Profile ganti ke class yang dituju
                                          );
                                      }, 
                                      child: Text('Buy Now')
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
                              width: 173,
                              height: 191,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text('Item'),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(50, 12, 50, 12),
                                    child: TextButton(
                                      onPressed: (){
                                        Navigator.push(
                                          context, 
                                          MaterialPageRoute(builder: (context) => Profile()) //Profile ganti ke class yang dituju
                                          );
                                      }, 
                                      child: Text('Buy Now')
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
                              width: 173,
                              height: 191,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text('Item'),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(50, 12, 50, 12),
                                    child: TextButton(
                                      onPressed: (){
                                        Navigator.push(
                                          context, 
                                          MaterialPageRoute(builder: (context) => Profile()) //Profile ganti ke class yang dituju
                                          );
                                      }, 
                                      child: Text('Buy Now')
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
                              width: 173,
                              height: 191,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text('Item'),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(50, 12, 50, 12),
                                    child: TextButton(
                                      onPressed: (){
                                        Navigator.push(
                                          context, 
                                          MaterialPageRoute(builder: (context) => Profile()) //Profile ganti ke class yang dituju
                                          );
                                      }, 
                                      child: Text('Buy Now')
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
                              width: 173,
                              height: 191,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text('Item'),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(50, 12, 50, 12),
                                    child: TextButton(
                                      onPressed: (){
                                        Navigator.push(
                                          context, 
                                          MaterialPageRoute(builder: (context) => Profile()) //Profile ganti ke class yang dituju
                                          );
                                      }, 
                                      child: Text('Buy Now')
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
                              width: 173,
                              height: 191,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text('Item'),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(50, 12, 50, 12),
                                    child: TextButton(
                                      onPressed: (){
                                        Navigator.push(
                                          context, 
                                          MaterialPageRoute(builder: (context) => Profile()) //Profile ganti ke class yang dituju
                                          );
                                      }, 
                                      child: Text('Buy Now')
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
