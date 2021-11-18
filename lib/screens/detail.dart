import 'package:flutter/material.dart';
import 'package:flutter_application_2/screens/homepage.dart';
import 'package:flutter_application_2/screens/kondisiDetail.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

class CageDetail extends StatelessWidget {
  const CageDetail({Key? key, required this.cage}) : super(key: key);
  final Cage cage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BSF"),
      ),
      body: RefreshIndicator(
        onRefresh: () => getKondisi(),
        color: Colors.red,
        child: FutureBuilder(
          future: getKondisi(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Text("data error");
            } else {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => kondisiDetail(
                                    kondisi: snapshot.data[index])));
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        height: 120,
                        child: Card(
                          elevation: 10,
                          child: Row(
                            children: [
                              Text("id = ${snapshot.data[index].id}"),
                              Text(snapshot.data[index].tanggal),
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            }
          },
        ),
      ),
    );
  }

  Future<List<KondisiKandang>> getKondisi() async {
    final String url =
        'https://maggot.medsosmining.com/api/openapi/kondisi-kandangs/byKandang?page=0&size=20&sort=id,asc&kandangId=${cage.id}';
    var response = await http.get(Uri.parse(url));
    var jsonData = json.decode(response.body);

    List<KondisiKandang> kondisi = [];

    for (var u in jsonData) {
      KondisiKandang kandang = KondisiKandang(u["id"], u["tanggal"], u["jam"],
          u["menit"], u["suhu"], u["kelembaban"], u["cahaya"]);
      kondisi.add(kandang);
    }
    return kondisi;
  }
}

class KondisiKandang {
  final int id;
  final String tanggal;
  final int jam;
  final int menit;
  final int suhu;
  final int kelembaban;
  final int cahaya;

  KondisiKandang(this.id, this.tanggal, this.jam, this.menit, this.suhu,
      this.kelembaban, this.cahaya);
}
