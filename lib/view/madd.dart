import 'dart:io';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'package:datamahasiswa/model/mmodel.dart';
import 'package:datamahasiswa/view/mlist.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:async/async.dart';
import '../service/mservices.dart';

class MahasiswaAdd extends StatefulWidget {
  const MahasiswaAdd({Key? key}) : super(key: key);

  @override
  State<MahasiswaAdd> createState() => _MahasiswaAddState();
}

class _MahasiswaAddState extends State<MahasiswaAdd> {

  late MahasiswaApiService mahasiswaApiService;

  TextEditingController namatxt = TextEditingController();
  TextEditingController jurusantxt = TextEditingController();
  TextEditingController nimtxt = TextEditingController();
  TextEditingController kelamintxt = TextEditingController();
  TextEditingController alamatxt = TextEditingController();

  File? imageFile;
  String? filePath;
  final ImagePicker picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    mahasiswaApiService = MahasiswaApiService();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Tambah Informasi",
            style: TextStyle(
                color: Colors.green
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(
                Icons.arrow_back_ios_new_outlined,
                color: Colors.green
            ),
            onPressed: () => {
              Navigator.pop(context),
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(
                  Icons.check_outlined,
                  color: Colors.green
              ),
              onPressed: () => {
                save(context),
              },
            ),
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              SizedBox(
                height: 115,
                width: 115,
                child: Stack(
                  fit: StackFit.expand,
                  clipBehavior: Clip.none,
                  children: [
                    CircleAvatar(
                      backgroundImage: setupImage(),
                    ),
                    Positioned(
                      right: -16,
                      bottom: 0,
                      child: SizedBox(
                        height: 46,
                        width: 46,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                              side: const BorderSide(color: Colors.white),
                            ),
                            primary: Colors.white,
                            backgroundColor: const Color(0xFFF5F6F9),
                          ),
                          onPressed: () {
                            checkPermission();
                          },
                          child: const Icon(Icons.camera_alt_rounded),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: const BoxDecoration(
                      color: Color(0xFFF5F6F9),
                      borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.person_outline,
                          color: Colors.black12,
                          size: 22,
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                            child: TextField(
                              cursorColor: Colors.white,
                              controller: namatxt,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                hintText: 'Nama',
                                hintStyle:TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.black),
                              ),
                            )
                        )
                      ],
                    ),
                  )
              ),
              const SizedBox(height: 20),
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: const BoxDecoration(
                      color: Color(0xFFF5F6F9),
                      borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.school_outlined,
                          color: Colors.black12,
                          size: 22,
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                            child: TextField(
                              cursorColor: Colors.white,
                              controller: jurusantxt,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                hintText: 'Jurusan',
                                hintStyle:TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.black),
                              ),
                            )
                        )
                      ],
                    ),
                  )
              ),
              const SizedBox(height: 20),
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: const BoxDecoration(
                      color: Color(0xFFF5F6F9),
                      borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.credit_card_outlined,
                          color: Colors.black12,
                          size: 22,
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                            child: TextField(
                              cursorColor: Colors.white,
                              controller: nimtxt,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                hintText: 'NIM',
                                hintStyle:TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.black),
                              ),
                            )
                        )
                      ],
                    ),
                  )
              ),
              const SizedBox(height: 20),
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: const BoxDecoration(
                      color: Color(0xFFF5F6F9),
                      borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.wc_outlined,
                          color: Colors.black12,
                          size: 22,
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                            child: TextField(
                              cursorColor: Colors.white,
                              controller: kelamintxt,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                hintText: 'Jenis Kelamin',
                                hintStyle:TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.black),
                              ),
                            )
                        )
                      ],
                    ),
                  )
              ),
              const SizedBox(height: 20),
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: const BoxDecoration(
                      color: Color(0xFFF5F6F9),
                      borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.map_outlined,
                          color: Colors.black12,
                          size: 22,
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                            child: TextField(
                              cursorColor: Colors.white,
                              controller: alamatxt,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                hintText: "Alamat",
                                hintStyle:TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.black),
                              ),
                            )
                        )
                      ],
                    ),
                  )
              ),
            ],
          ),
        )
    );
  }

  save(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 2,
                  ),
                  Text("Wait a second."),
                ],
              ),
            )
        );
      },
    );
    Future.delayed(
      const Duration(seconds: 5), () async {
        Navigator.pop(context);
        await saveImg(context).then((value) => goHome(context));
      }
    );
  }

  setupImage() {
    return imageFile == null
        ? const NetworkImage('https://via.placeholder.com/150')
        : FileImage(imageFile!);
  }

  void checkPermission() async {
    var status = await Permission.storage.status;

    if(status.isDenied){
      Permission.storage.request().whenComplete(() => getFromGallery());
    }else{
      getFromGallery();
    }
  }

  void getFromGallery() async {
    var uri = 'https://tugasuascrud.niobesad.xyz/imgs/';

    XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery,
      maxWidth: 900,
      maxHeight: 900,);

    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
        var fileName = imageFile?.path.split(Platform.pathSeparator).last;
        filePath = uri+fileName!;
      });
    }
  }

  saveImg(BuildContext context) async {
    if(imageFile!=null){
      var stream = http.ByteStream(DelegatingStream.typed(imageFile!.openRead()));
      var length = await imageFile!.length();
      var uri = Uri.parse("https://tugasuascrud.niobesad.xyz/api/upload");
      var request = http.MultipartRequest("POST", uri);
      var multipartFile = http.MultipartFile('file', stream, length,
          filename: basename(imageFile!.path));
      request.files.add(multipartFile);
      await request.send().then((value) => saveData(context));
    }else{
      saveData(context);
    }
  }

  void saveData(BuildContext context) {
    MahasiswaModel m = MahasiswaModel(
        id: 'id',
        nama: 'nama',
        jurusan: 'jurusan',
        nim: 'nim',
        jenis_kelamin: 'jenis_kelamin',
        alamat: 'alamat',
        picture: 'picture'
    );

    m.nama = namatxt.text;
    m.jurusan = jurusantxt.text;
    m.nim = nimtxt.text;
    m.jenis_kelamin = kelamintxt.text;
    m.alamat = alamatxt.text;
    if(imageFile!=null){
      m.picture = filePath!;
    }else{
      m.picture = 'https://via.placeholder.com/150';
    }

    mahasiswaApiService.createMahasiswa(
        m
    ).then((value) => goHome(context));
  }

  goHome(BuildContext context) {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (context) => const MahasiswaList()
        ));
  }
}
