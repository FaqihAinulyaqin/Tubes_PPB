import 'dart:io';
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mime/mime.dart';

class UserApi {
  final String apiUrl = dotenv.env['API_URL'].toString();

  Future<bool> updateProfile(
    String namaDepan,
    String namaBelakang,
    String email,
    String noTelpon,
    String alamat,
    File? foto,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    if (token == null) {
      return false;
    }

    final request = http.MultipartRequest(
      'PUT',
      Uri.parse('$apiUrl/api/users/updateProfile'),
    );
    request.headers['Authorization'] = 'Bearer $token';

    request.fields['nama_depan'] = namaDepan;
    request.fields['nama_belakang'] = namaBelakang;
    request.fields['email'] = email;
    request.fields['no_telpon'] = noTelpon;
    request.fields['alamat'] = alamat;

    if (foto != null && await foto.exists()) {
      final mimeType = lookupMimeType(foto.path);
      request.files.add(await http.MultipartFile.fromPath(
        'foto',
        foto.path,
        contentType: MediaType.parse(mimeType ?? 'image/*'),
      ));
    }
    final response = await request.send();

    if (response.statusCode == 200) {
      print(response.statusCode);
      return true;
    } else {
      print(response.statusCode);
      return false;
    }
  }
}
