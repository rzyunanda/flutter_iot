import 'package:flutter/material.dart';
import 'detail.dart';

class kondisiDetail extends StatelessWidget {
  const kondisiDetail({Key? key, required this.kondisi}) : super(key: key);
  final KondisiKandang kondisi;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("BSF"),
        ),
        body: Text(kondisi.tanggal));
  }
}
