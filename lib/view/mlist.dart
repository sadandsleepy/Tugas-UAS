import 'package:datamahasiswa/service/mservices.dart';
import 'package:datamahasiswa/view/mdetail.dart';
import 'package:flutter/material.dart';

import '../model/mmodel.dart';
import 'madd.dart';

class MahasiswaList extends StatefulWidget {
  const MahasiswaList({Key? key}) : super(key: key);

  @override
  State<MahasiswaList> createState() => _MahasiswaListState();
}

class _MahasiswaListState extends State<MahasiswaList> {
  late MahasiswaApiService mahasiswaApiService;

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
          "Daftar Mahasiswa",
          style: TextStyle(
              color: Colors.green
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(
                Icons.add_outlined,
                color: Colors.green
            ),
            onPressed: () => {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const MahasiswaAdd()
                )
              )
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: mahasiswaApiService.getMahasiswa(),
        builder: (context, snapshot){
          if(snapshot.hasError){
            return Center(
              child: Text(
                "Something wrong with message: ${snapshot.error.toString()}",
                textAlign: TextAlign.center,
              ),
            );
          }
          else if(snapshot.connectionState == ConnectionState.done){
            List<MahasiswaModel> mahasiswa = snapshot.data as List<MahasiswaModel>;
            return Center(
              child: Column(
                children: [
                  const Expanded(
                    flex: 1,
                    child: Text("Lihat, Tambahkan, Edit dan Hapus.",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w100,
                          fontFamily: 'Open Sans',
                          fontSize: 20),
                    ),
                  ),
                  const SizedBox(height: 5,),
                  Expanded(
                    flex: 20,
                    child: _buildListView(mahasiswa),
                  )
                ],
              ),
            );
          }else{
            return Center(
              child: Container(),
            );
          }
        },
      ),
    );
  }

  Widget _buildListView(List<MahasiswaModel> mahasiswalist) {
    return RefreshIndicator(
      onRefresh: pullRefresh,
      child: ListView.separated(
        separatorBuilder: (BuildContext context, int i) => const Divider(color: Colors.white,),
        itemCount: mahasiswalist.length,
        itemBuilder: (context, index) {
          MahasiswaModel mahasiswa = mahasiswalist[index];
          return GestureDetector(
              onTap: (){
                Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => MahasiswaDetail(id: mahasiswa.id)
                    )
                );
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(10))
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                          width: MediaQuery.of(context).size.width * 0.25,
                          margin: const EdgeInsets.all(5),
                          alignment: Alignment.center,
                          child: FittedBox(
                            fit: BoxFit.fill,
                            child: Image.network(mahasiswa.picture, width: 75, height: 75,),
                          )
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.25,
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children : [
                                  Text(
                                    mahasiswa.nim,
                                    style: const TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    mahasiswa.nama,
                                    style: const TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ]
                            )
                        ),
                      ),
                    ),
                  ],
                ),
              )
          );
        },
      ),
    );
  }

  Future<void> pullRefresh() async  {
    setState(() {});
  }
}
