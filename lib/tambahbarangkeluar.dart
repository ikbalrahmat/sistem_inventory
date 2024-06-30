import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'login.dart';

class TambahBarangKeluar extends StatefulWidget {
  final List listbarang;
  final int index;

  TambahBarangKeluar({required this.listbarang, required this.index});

  @override
  _TambahBarangKeluarState createState() => new _TambahBarangKeluarState();
}

class _TambahBarangKeluarState extends State<TambahBarangKeluar> {
  TextEditingController controllerIdBarang = new TextEditingController();
  TextEditingController controllerNamaBarang = new TextEditingController();
  TextEditingController controllerTanggalKeluar = new TextEditingController();
  TextEditingController controllerCustomer = new TextEditingController();
  TextEditingController controllerBanyakBarang = new TextEditingController();
  TextEditingController controllerHargaJual = new TextEditingController();

  void addDataBarangKeluar() {
    var url =
        "http://localhost/sistem_inventory/addbarangkeluar.php";

    http.post(url as Uri, body: {
      "tgl_barang_keluar": controllerTanggalKeluar.text,
      "id_barang": controllerIdBarang.text,
      "nama_customer": controllerCustomer.text,
      "banyak_barang_keluar": controllerBanyakBarang.text,
      "harga_jual": controllerHargaJual.text
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
        title: new Text("Tambah Barang Keluar"),
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
                      controller: controllerTanggalKeluar,
                      keyboardType: TextInputType.number,
                      decoration: new InputDecoration(
                          hintText: "yyyy-mm-dd", labelText: "Tanggal Keluar"),
                    ),
                    new TextField(
                      controller: controllerCustomer,
                      decoration: new InputDecoration(
                          hintText: "Masukan Customer", labelText: "Customer"),
                    ),
                    new TextField(
                      controller: controllerBanyakBarang,
                      keyboardType: TextInputType.number,
                      decoration: new InputDecoration(
                          hintText: "Masukan Banyak Barang",
                          labelText: "Banyak Barang"),
                    ),
                    new TextField(
                      controller: controllerHargaJual,
                      keyboardType: TextInputType.number,
                      decoration: new InputDecoration(
                          hintText: "Masukan Harga Jual", labelText: "Harga Jual"),
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
                            addDataBarangKeluar();
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
