import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/screens/detail.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BSF"),
      ),
      body: RefreshIndicator(
        onRefresh: () => getProducts(),
        color: Colors.red,
        child: FutureBuilder(
          future: getProducts(),
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
                                builder: (context) => CageDetail(
                                      cage: snapshot.data[index],
                                    )));
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        height: 120,
                        child: Card(
                          elevation: 10,
                          child: Row(
                            children: [
                              Container(
                                  padding: EdgeInsets.all(10),
                                  height: 120,
                                  width: 120,
                                  child: Image.network(
                                      "http://www.peternakankita.com/wp-content/uploads/2019/01/Kandang-BSF-Minimalis-3.jpg")),
                              Text(snapshot.data[index].name)
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

  Future<List<Cage>> getProducts() async {
    final String url = 'https://maggot.medsosmining.com/api/openapi/kandangs';
    var response = await http.get(Uri.parse(url));
    var jsonData = json.decode(response.body);

    List<Cage> cages = [];

    for (var u in jsonData) {
      Cage cage = Cage(u["id"], u["name"]);
      cages.add(cage);
    }

    return cages;
  }
}

class Cage {
  final int id;
  final String name;

  Cage(this.id, this.name);
}
