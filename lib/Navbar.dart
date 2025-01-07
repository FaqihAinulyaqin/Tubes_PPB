import 'package:flutter/material.dart';
import 'HalamanUtama.dart';
import 'Wishlist.dart';
import 'Sell.dart';
import 'Profile.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HalamanUtama(),
    Sell(),
    Wishlist(),
    Profile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _pages[_currentIndex],
          Positioned(
            left: 0,
            right: 0,
            bottom: 20,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 50),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: BottomNavigationBar(
                currentIndex: _currentIndex,
                onTap: _onItemTapped,
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home, color: Colors.white),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.add_circle_outline_sharp,
                        color: Colors.white),
                    label: 'Sell',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.favorite_border, color: Colors.white),
                    label: 'Wishlist',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person, color: Colors.white),
                    label: 'Profile',
                  ),
                ],
                unselectedItemColor: Colors.white54,
                selectedItemColor: Colors.white,
                backgroundColor: Colors.transparent,
                type: BottomNavigationBarType.fixed,
                showSelectedLabels: true,
                showUnselectedLabels: false,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
