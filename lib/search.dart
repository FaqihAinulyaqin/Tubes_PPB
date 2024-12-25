import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class search extends StatefulWidget {
  const search({super.key});

  @override
  SearchState createState() => SearchState();
}

class SearchState extends State<search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Container(
            width: 40.0,
            height: 40.0,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFC2D2E6),
            ),
            child: Center(
              child: IconButton(
                icon: const Icon(
                  Icons.keyboard_arrow_left_outlined,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
                padding: const EdgeInsets.only(left: 0.0),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ),
        title: Container(
          width: 300,
          height: 49.0,
          padding: const EdgeInsets.only(right: 20.0),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'search Here...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              suffixIcon: const Icon(
                Icons.search,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 85,
                    height: 29,
                    decoration: BoxDecoration(
                      color: const Color(0xFFC2D2E6),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Center(
                      child: Text(
                        'Sukapura',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Container(
                      width: 85,
                      height: 29,
                      decoration: BoxDecoration(
                        color: const Color(0xFFC2D2E6),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Center(
                        child: Text(
                          'Sukabirus',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Container(
                      width: 85,
                      height: 29,
                      decoration: BoxDecoration(
                        color: const Color(0xFFC2D2E6),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Center(
                        child: Text(
                          'DayeuhKolot',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30), 
            
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                'Recent Searches',
                style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 15),

            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 85,
                    height: 29,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(230, 230, 230, 1),
                      borderRadius: BorderRadius.circular(15.0)
                    ),
                    child: const Center(
                      child: Text(
                        'Sapu Lidi',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w100
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30.0),

             Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                'Suggessted Product',
                style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 15),

            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 85,
                    height: 29,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                        color: Colors.black,
                      )
                    ),
                    child: const Center(
                      child: Text(
                        'Album Wendy',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
