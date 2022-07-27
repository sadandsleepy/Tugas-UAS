import 'package:http/http.dart' show Client;
import 'dart:convert';
import '../model/mmodel.dart';

class MahasiswaApiService {

  final String baseUrl = "https://tugasuascrud.niobesad.xyz/api";
  Client client = Client();

  Future<List<MahasiswaModel>> getMahasiswa() async {
    final response = await client.get(Uri.parse("$baseUrl/mahasiswa"));
    if (response.statusCode == 200) {
      return userFromJson(response.body);
    } else {
      return [];
    }
  }

  Future<bool> createMahasiswa(MahasiswaModel data) async {
    final response = await client.post(
        Uri.parse("$baseUrl/mahasiswa"),
        body: {
          "id": data.id,
          "nama": data.nama,
          "jurusan" : data.jurusan,
          "nim": data.nim,
          "jenis_kelamin": data.jenis_kelamin,
          "alamat": data.alamat,
          "picture": data.picture,
        }
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<MahasiswaModel?> getMahasiswaBy(String? id) async {
    final response = await client.get(
        Uri.parse("$baseUrl/mahasiswa/$id")
    );
    if (response.statusCode == 200) {
      final data = MahasiswaModel.fromJson(json.decode(response.body));
      return data;
    } else {
      return null;
    }
  }

  Future<bool> updateMahasiswa({required String id, required MahasiswaModel data}) async {
    final response = await client.post(
        Uri.parse("$baseUrl/update/$id"),
        body: {
          "nama": data.nama,
          "nim": data.nim,
          "jurusan" : data.jurusan,
          "jenis_kelamin": data.jenis_kelamin,
          "alamat": data.alamat,
          "picture": data.picture,
        }
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<int> deleteMahasiswa({required int id}) async {
    final response = await client.delete(
        Uri.parse("$baseUrl/mahasiswa/$id")
    );
    if (response.statusCode == 200) {
      return 1;
    } else {
      return 0;
    }
  }
}