import 'package:flutter/material.dart';
import 'dart:convert'; // For decoding JSON
import 'package:http/http.dart' as http; // For making API calls
import 'halamanproduk.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = FlutterSecureStorage();

class Wishlist extends StatefulWidget {
  const Wishlist({super.key});

  @override
  _WishlistState createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  bool isLoading = true; // Indicates if data is loading
  List<dynamic> products = []; // Store product data

  @override
  void initState() {
    super.initState();
    fetchWishlist(); // Fetch wishlist items on initialization
  }

  Future<void> fetchWishlist() async {
    final String url =
        'http://192.168.0.106:3000/api/wishlist/getWishlist'; // Replace with your local IP
    final String? token = await storage.read(
        key: 'jwt_token'); // Get the token from secure storage

    print('Fetching wishlist with token: $token'); // Debugging log

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      print('Response status: ${response.statusCode}'); // Log status
      print('Response body: ${response.body}'); // Log body

      if (response.statusCode == 200) {
        setState(() {
          products =
              json.decode(response.body)['data']; // Get data from response
          isLoading = false; // Data has been loaded
        });
      } else {
        setState(() {
          isLoading = false;
        });
        print('Failed to load wishlist: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error fetching wishlist: $e');
    }
  }

  Future<void> removeFromWishlist(String id) async {
    final String url =
        'http://192.168.0.106:3000/api/wishlist/removeWishlist/$id'; // Replace with your local IP
    final String? token = await storage.read(
        key: 'jwt_token'); // Get the token from secure storage

    try {
      final response = await http.delete(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        print('Item successfully removed from wishlist');
      } else {
        print('Failed to remove item: ${response.statusCode}');
      }
    } catch (e) {
      print('Error removing item: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(194, 210, 229, 100),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Icon(Icons.arrow_back_ios),
                      ),
                      onPressed: () {
                        Navigator.pop(context); // Go back to the previous page
                      },
                    ),
                  ),
                  Image.asset("Images/cat.png"),
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 8),
                        decoration: const BoxDecoration(
                          color: Color.fromRGBO(194, 210, 229, 100),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.notifications_active),
                          onPressed: () {},
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          color: Color.fromRGBO(194, 210, 229, 100),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.chat),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'WishList',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${products.length} items',
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Divider(
              thickness: 1.5,
              color: Color.fromARGB(255, 73, 71, 71),
              indent: 16,
              endIndent: 16,
            ),
            const SizedBox(height: 10),
            isLoading
                ? const Center(child: CircularProgressIndicator()) // Loader
                : Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
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
                                Image.network(
                                  products[i][
                                      "product_imgPath"], // Ensure this key matches your API response
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                ),
                                const SizedBox(width: 20),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        products[i][
                                            "product_namaProduk"], // Ensure this key matches your API response
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        products[i][
                                            "product_kategori"], // Ensure this key matches your API response
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        products[i][
                                            "product_hargaProduk"], // Ensure this key matches your API response
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        products[i][
                                            "product_subKategori"], // Ensure this key matches your API response
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.favorite),
                                  onPressed: () async {
                                    await removeFromWishlist(products[i][
                                        "id"]); // Ensure this key matches your API response
                                    setState(() {
                                      products.removeAt(i);
                                    });
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content:
                                            Text('Item removed from wishlist'),
                                      ),
                                    );
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
