import 'package:datamahasiswa/model/mmodel.dart';
import 'package:datamahasiswa/view/medit.dart';
import 'package:datamahasiswa/view/mlist.dart';
import 'package:flutter/material.dart';

import '../service/mservices.dart';

class MahasiswaDetail extends StatefulWidget {
  const MahasiswaDetail({Key? key, required this.id}) : super(key: key);

  final String id;

  @override
  State<MahasiswaDetail> createState() => _MahasiswaDetailState();
}

class _MahasiswaDetailState extends State<MahasiswaDetail> {

  late MahasiswaApiService mahasiswaApiService;
  late MahasiswaModel mahasiswaModel;

  @override
  void initState() {
    super.initState();
    mahasiswaApiService = MahasiswaApiService();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.green),
        title: const Text(
          "Detail",
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
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onPressed: (){
                editDialog();
              },
              icon: const Icon(
                  Icons.edit_outlined,
                  color: Colors.green
              ))
        ],
      ),
      backgroundColor: Colors.white,
      body: FutureBuilder<MahasiswaModel?>(
        future: mahasiswaApiService.getMahasiswaBy(widget.id),
        builder: (BuildContext context, snapshot){
          if(snapshot.hasError){
            return Center(
              child: Text(
                "Something wrong with message: ${snapshot.error.toString()}",
                textAlign: TextAlign.center,
              ),
            );
          }
          else if(snapshot.connectionState == ConnectionState.done && snapshot.data!= null){
            mahasiswaModel = snapshot.data!;
            if(mahasiswaModel.id.isNotEmpty){
              return SingleChildScrollView(
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
                            backgroundImage: NetworkImage(mahasiswaModel.picture),
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(height: 20),
                    const Text(
                      "Detail Mahasiswa",
                      style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                    ),
                    const SizedBox(height: 20),
                    ProfileMenu(
                      text: mahasiswaModel.nama,
                      icon: Icons.person_outline_outlined,
                      press: () => {},
                    ),
                    ProfileMenu(
                      text: mahasiswaModel.jurusan,
                      icon: Icons.school_outlined,
                      press: () => {},
                    ),
                    ProfileMenu(
                      text: mahasiswaModel.nim,
                      icon: Icons.credit_card_outlined,
                      press: () => {},
                    ),
                    ProfileMenu(
                      text: mahasiswaModel.jenis_kelamin,
                      icon: Icons.wc_outlined,
                      press: () => {},
                    ),
                    ProfileMenu(
                      text: mahasiswaModel.alamat,
                      icon: Icons.map_outlined,
                      press: () => {},
                    ),
                  ]
                )
              );
            }else{
              return const Text("User Not Found");
            }
          }else{
            return Center(
              child: Container(),
            );
          }
        },
      ),
    );
  }

  void editDialog() {

    AlertDialog alert = AlertDialog(
      title: const Text("Action Needed"),
      content: const Text("What You Want To Do?"),
      actions: [
        TextButton(
            onPressed: (){edit();},
            child: const Text("Edit")
        ),
        TextButton(
            onPressed: () {delete();},
            child: const Text("Delete")
        )
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  edit() {
    Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => MahasiswaEdit(mhs: mahasiswaModel)
        )
    );
  }

  delete() {
    mahasiswaApiService.deleteMahasiswa(id: int.parse(mahasiswaModel.id));
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (context) => const MahasiswaList()
        )
    );
  }
}

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key? key,
    required this.text,
    required this.icon,
    this.press,
  }) : super(key: key);

  final String text;
  final IconData icon;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextButton(
        style: TextButton.styleFrom(
          primary: Colors.black,
          padding: const EdgeInsets.all(20),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: const Color(0xFFF5F6F9),
        ),
        onPressed: press,
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.green,
              size: 22,
            ),
            const SizedBox(width: 20),
            Expanded(
                child: Text(text)
            )
          ],
        ),
      ),
    );
  }
}
