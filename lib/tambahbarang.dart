import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'login.dart';

class TambahBarang extends StatefulWidget {
  @override
  _TambahBarangState createState() => new _TambahBarangState();
}

class _TambahBarangState extends State<TambahBarang> {
  TextEditingController controllerNamaBarang = new TextEditingController();
  TextEditingController controllerKategoriBarang = new TextEditingController();
  TextEditingController controllerStock = new TextEditingController();

  void addDataBarang() {
    var url = Uri.parse("http://10.0.2.2/sistem_inventory/addbarang.php");

    http.post(url, body: {
      "nama_barang": controllerNamaBarang.text,
      "kategori_barang": controllerKategoriBarang.text,
      "stock": controllerStock.text
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Tambah Data Barang"),
        backgroundColor: Colors.green[500],
      ),
      body: Container(
        height: 320,
        padding: const EdgeInsets.all(10.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: ListView(
              children: <Widget>[
                new Column(
                  children: <Widget>[
                    new TextField(
                      controller: controllerNamaBarang,
                      decoration: new InputDecoration(
                          hintText: "Masukan Nama Barang",
                          labelText: "Nama Barang"),
                    ),
                    new TextField(
                      controller: controllerKategoriBarang,
                      decoration: new InputDecoration(
                          hintText: "Masukan Kategori", labelText: "Kategori"),
                    ),
                    new TextField(
                      controller: controllerStock,
                      keyboardType: TextInputType.number,
                      decoration: new InputDecoration(
                          hintText: "Masukan Stock", labelText: "Stock"),
                    ),
                    new Padding(
                      padding: const EdgeInsets.all(10.0),
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40)), backgroundColor: Colors.green[500]),
                        child: new Text(
                          "Simpan Data",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          addDataBarang();
                          Navigator.of(context).push(new MaterialPageRoute(
                            builder: (BuildContext context) => Login(),
                          ));
                        }),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}