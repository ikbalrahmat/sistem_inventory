import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'login.dart';

class TambahBarangMasuk extends StatefulWidget {
  final List listbarang;
  final int index;

  TambahBarangMasuk({required this.listbarang, required this.index});

  @override
  _TambahBarangMasukState createState() => new _TambahBarangMasukState();
}

class _TambahBarangMasukState extends State<TambahBarangMasuk> {
  TextEditingController controllerIdBarang = new TextEditingController();
  TextEditingController controllerNamaBarang = new TextEditingController();
  TextEditingController controllerTanggalMasuk = new TextEditingController();
  TextEditingController controllerSupplier = new TextEditingController();
  TextEditingController controllerBanyakBarang = new TextEditingController();
  TextEditingController controllerHargaBeli = new TextEditingController();

  void addDataBarangMasuk() {
    var url =
        "http://localhost/sistem_inventory/addbarangmasuk.php";

    http.post(url as Uri, body: {
      "tgl_barang_masuk": controllerTanggalMasuk.text,
      "id_barang": controllerIdBarang.text,
      "nama_supplier": controllerSupplier.text,
      "banyak_barang_masuk": controllerBanyakBarang.text,
      "harga_beli": controllerHargaBeli.text
    });
  }

  @override
  void initState() {
    controllerNamaBarang = new TextEditingController(
      text: widget.listbarang[widget.index]['nama_barang'],
    );
    controllerIdBarang = new TextEditingController(
      text: widget.listbarang[widget.index]['id_barang'],
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Tambah Barang Masuk"),
        backgroundColor: Colors.green[500],
      ),
      body: Container(
        height: 500,
        padding: const EdgeInsets.all(10.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 5, 15, 15),
            child: ListView(
              children: <Widget>[
                new Column(
                  children: <Widget>[
                    new TextField(
                      controller: controllerIdBarang,
                      readOnly: true,
                      decoration: new InputDecoration(
                          hintText: "Masukan Id Barang", labelText: "Id Barang"),
                    ),
                    new TextField(
                      controller: controllerNamaBarang,
                      readOnly: true,
                      decoration: new InputDecoration(
                          hintText: "Masukan Nama Barang",
                          labelText: "Nama Barang"),
                    ),
                    new TextField(
                      controller: controllerTanggalMasuk,
                      keyboardType: TextInputType.number,
                      decoration: new InputDecoration(
                          hintText: "yyyy-mm-dd", labelText: "Tanggal Masuk"),
                    ),
                    new TextField(
                      controller: controllerSupplier,
                      decoration: new InputDecoration(
                          hintText: "Masukan Supplier", labelText: "Supplier"),
                    ),
                    new TextField(
                      controller: controllerBanyakBarang,
                      keyboardType: TextInputType.number,
                      decoration: new InputDecoration(
                          hintText: "Masukan Banyak Barang",
                          labelText: "Banyak Barang"),
                    ),
                    new TextField(
                      controller: controllerHargaBeli,
                      keyboardType: TextInputType.number,
                      decoration: new InputDecoration(
                          hintText: "Masukan Harga Beli", labelText: "Harga Beli"),
                    ),
                    new Padding(
                      padding: const EdgeInsets.all(10.0),
                    ),
                    new ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40)), backgroundColor: Colors.green[500],
                        ),
                        child: new Text(
                            "Simpan Data",
                            style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                            addDataBarangMasuk();
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
