import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ureveryday_ppb/HalamanUtama.dart';
import 'package:ureveryday_ppb/Navbar.dart';
import 'package:ureveryday_ppb/api/auth_api.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _obscureText = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String emailErrorMessage = '';
  String passErrorMessage = '';
  bool mailIsEror = false;
  bool passIsEror = false;
  bool isLoading = false;

  // Fungsi login untuk mengakses API Node.js
  bool isEmailValid(String email) {
    return email.contains('@');
  }

  bool isPassValid(String pass) {
    return pass.isNotEmpty;
  }

  bool cekEmailnPass(String email, String pass) {
    return (email.isNotEmpty && pass.isNotEmpty);
  }

  void LoginUser(String email, String pass) async {
    setState(() {
      emailErrorMessage = '';
      passErrorMessage = '';
      mailIsEror = false;
      passIsEror = false;
      isLoading = true;
    });

    if (!isEmailValid(email)) {
      setState(() {
        emailErrorMessage = 'Email harus mengandung "@"';
        mailIsEror = true;
        isLoading = false;
      });
      return;
    }

    if (!isPassValid(pass)) {
      setState(() {
        passErrorMessage = 'Password tidak boleh kosong';
        passIsEror = true;
        isLoading = false;
      });
      return;
    }

    var response = await AuthApi().login(email, pass);
    if (response['status'] == true) {
      var user = await AuthApi().getUserProfile();
      if (user['status'] == true && user['data'] != null) {
        var found = user['data'][0];

        if (found != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Navbar()), // Widget untuk pelamar
          );
        }
      } else {
        setState(() {
          emailErrorMessage = "Username or password is incorrect";
          passErrorMessage = "Username or password is incorrect";

          mailIsEror = true;
          passIsEror = true;
          isLoading = false;
        });
      }
    } else {
      setState(() {
        emailErrorMessage =
            response['massage'] ?? "Username or password is incorrect";
        passErrorMessage =
            response['massage'] ?? "Username or password is incorrect";

        mailIsEror = true;
        passIsEror = true;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 50, bottom: 20),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: IntrinsicHeight(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      'UREveryday',
                      style: GoogleFonts.inter(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: Image.asset(
                      'assets/Online security (2).png',
                      width: 354,
                      height: 224,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: 300,
                    padding: const EdgeInsets.all(25.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFFC2D2E6),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Email',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 5),
                        TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            fillColor: Colors.white,
                            filled: true,
                          ),
                        ),
                        if (emailErrorMessage.isNotEmpty)
                          Text(
                            emailErrorMessage,
                            style: TextStyle(color: Colors.red),
                          ),
                        const SizedBox(height: 7),
                        Text(
                          'Password',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 5),
                        TextField(
                          controller: _passwordController,
                          obscureText: _obscureText,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            fillColor: Colors.white,
                            filled: true,
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureText
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                            ),
                          ),
                        ),
                        if (passErrorMessage.isNotEmpty)
                          Text(
                            passErrorMessage,
                            style: TextStyle(color: Colors.red),
                          ),
                        const SizedBox(height: 20),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              String email = _emailController.text;
                              String password = _passwordController.text;

                              LoginUser(email, password);
                            },
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(200, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              backgroundColor: Colors.white,
                            ),
                            child: Text(
                              'Login',
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
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
          ),
        ),
      ),
    );
  }
}
