import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'login.dart';

class EditDataBarang extends StatefulWidget {
  final List listbarang;
  final int index;

  EditDataBarang({required this.listbarang, required this.index});

  @override
  _EditDataBarangState createState() => new _EditDataBarangState();
}

class _EditDataBarangState extends State<EditDataBarang> {
  TextEditingController controllerNamaBarang = new TextEditingController();
  TextEditingController controllerKategoriBarang = new TextEditingController();
  TextEditingController controllerStock = new TextEditingController();

  void editDataBarang() {
    var url = Uri.parse("http://10.0.2.2/sistem_inventory/editbarang.php");
    http.post(url, body: {
      "id_barang": widget.listbarang[widget.index]['id_barang'],
      "nama_barang": controllerNamaBarang.text,
      "kategori_barang": controllerKategoriBarang.text,
      "stock": controllerStock.text
    });
  }

  @override
  void initState() {
    controllerNamaBarang = new TextEditingController(
        text: widget.listbarang[widget.index]['nama_barang']);
    controllerKategoriBarang = new TextEditingController(
        text: widget.listbarang[widget.index]['kategori_barang']);
    controllerStock = new TextEditingController(
        text: widget.listbarang[widget.index]['stock']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Edit Data Barang"),
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
                    new ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40)), backgroundColor: Colors.green[500]),
                        child: new Text(
                          "Simpan Data",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          editDataBarang();
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