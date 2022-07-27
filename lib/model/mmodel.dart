import 'dart:convert';

class MahasiswaModel {

  String id;
  String nama;
  String jurusan;
  String nim;
  String jenis_kelamin;
  String alamat;
  String picture;


  MahasiswaModel(
      {
        required this.id,
        required this.nama,
        required this.jurusan,
        required this.nim,
        required this.jenis_kelamin,
        required this.alamat,
        required this.picture
      });

  factory MahasiswaModel.fromJson(Map<String, dynamic> map) {
    return MahasiswaModel(
        id: map["id"],
        nama: map["nama"],
        jurusan: map["jurusan"],
        nim: map["nim"],
        jenis_kelamin: map["jenis_kelamin"],
        alamat: map["alamat"],
        picture: map["picture"]
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "nama": nama,
      "jurusan": jurusan,
      "nim": nim,
      "jenis_kelamin": jenis_kelamin,
      "alamat": alamat,
      "picture": picture,
    };
  }

  @override
  String toString() {
    return 'Users{id: $id, nama: $nama, jurusan: $jurusan, nim: $nim, jenis_kelamin: $jenis_kelamin, alamat: $alamat, picture: $picture,}';
  }
}

List<MahasiswaModel> userFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<MahasiswaModel>.from(data.map((item) => MahasiswaModel.fromJson(item)));
}

String userToJson(MahasiswaModel data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}