import 'dart:io';
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mime/mime.dart';

class SellApi {
  final String apiUrl = dotenv.env['API_URL'].toString();

  Future<Map<String, dynamic>> addProduk(
    String namaproduk,
    String hargaproduk,
    String stok,
    String kategori,
    String subkategori,
    String deskripsi,
    File foto,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    if (token == null) {
      return {
        'status': false,
        'message': 'Anda belum login',
      };
    }

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('$apiUrl/api/produk/addProduk'),
    );
    request.headers['Authorization'] = 'Bearer $token';

    request.fields['nama_produk'] = namaproduk;
    request.fields['harga_produk'] = hargaproduk;
    request.fields['stok'] = stok;
    request.fields['kategori'] = kategori;
    request.fields['sub_kategori'] = subkategori;
    request.fields['deskripsi'] = deskripsi;

    if (await foto.exists()) {
      final mimeType = lookupMimeType(foto.path);
      request.files.add(await http.MultipartFile.fromPath('foto', foto.path,
          contentType: MediaType.parse(mimeType ?? 'image/*')));
    } else {
      return {
        'status': false,
        'message': 'anda belum mengupload gambar',
      };
    }

    try {
      var response = await request.send();

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        final decoded = jsonDecode(responseBody);

        return {
          'status': true,
          'message': 'Produk berhasil ditambahkan',
          'data': decoded,
        };
      } else {
        final responseBody = await response.stream.bytesToString();
        final decoded = jsonDecode(responseBody);

        return {
          'status': false,
          'message': decoded['message'] ?? 'Gagal menambahkan produk',
        };
      }
    } catch (e) {
      return {
        'status': false,
        'message': 'Error: $e',
      };
    }
  }
}
