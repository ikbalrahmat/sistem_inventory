import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'tambahbarangkeluar.dart';

class ListTambahBarangKeluar extends StatefulWidget {
  @override
  _ListTambahBarangKeluarState createState() => _ListTambahBarangKeluarState();
}

class _ListTambahBarangKeluarState extends State<ListTambahBarangKeluar> {
  Future<List> getDataBarang() async {
    final response = await http.get(Uri.parse("http://10.0.2.2/sistem_inventory/getbarang.php"));
    return json.decode(response.body);
  }

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Pilih Barang"),
        backgroundColor: Colors.green[500],
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: FutureBuilder<List>(
                future: getDataBarang(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) print(snapshot.error);
                  return snapshot.hasData
                      ? new ListBarang(
                          listbarang: snapshot.data!,
                        )
                      : new Center(
                          child: new CircularProgressIndicator(),
                        );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ListBarang extends StatelessWidget {
  final List listbarang;
  ListBarang({required this.listbarang});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            width: 300,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Center(
              child: new Text(
                "Barang Keluar",
                style: TextStyle(
                  color: Colors.green[500],
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  shadows: [
                    Shadow(
                      blurRadius: 2.0,
                      color: Colors.black26,
                      offset: Offset(0.0, 0.8),
                    ),
                  ],
                ),
              ),
            ),
          ),
          new Expanded(
              child: Container(
            padding: EdgeInsets.fromLTRB(0, 3, 0, 0),
            color: Colors.white,
            child: new ListView.builder(
                itemCount: listbarang.length,
                itemBuilder: (context, i) {
                  return new Container(
                    padding: const EdgeInsets.fromLTRB(2, 0, 2, 2.5),
                    child: new GestureDetector(
                      onTap: () => Navigator.of(context).push(
                          new MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  new TambahBarangKeluar(
                                    listbarang: listbarang,
                                    index: i,
                                  ))),
                      child: new Card(
                        child: new ListTile(
                          title: new Text(listbarang[i]['nama_barang']),
                          leading: CircleAvatar(
                            backgroundColor: Colors.red[700],
                            child: new Icon(
                              Icons.devices_other,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          )),
        ],
      ),
    );
  }
}