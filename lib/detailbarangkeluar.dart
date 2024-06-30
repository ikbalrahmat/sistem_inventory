import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'login.dart';

class DetailBarangKeluar extends StatefulWidget {
  List listbarangkeluar;
  int index;
  DetailBarangKeluar({required this.index, required this.listbarangkeluar});
  @override
  _DetailBarangKeluarState createState() => new _DetailBarangKeluarState();
}

class _DetailBarangKeluarState extends State<DetailBarangKeluar> {
  void deleteDataBarangKeluar() {
    var url = Uri.parse("http://10.0.2.2/sistem_inventory/deletebarangkeluar.php");
    http.post(url, body: {
      'id_barang_keluar': widget.listbarangkeluar[widget.index]['id_barang_keluar']
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Detail Barang Keluar"),
        backgroundColor: Colors.green[500],
      ),
      body: new Container(
        height: 275.0,
        padding: const EdgeInsets.all(10.0),
        child: new Card(
          child: new Center(
            child: new Column(
              children: <Widget>[
                new Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                ),
                new Text(
                  "Barang : ${widget.listbarangkeluar[widget.index]['nama_barang']}",
                  style: new TextStyle(fontSize: 18.0),
                ),
                new Text(
                  "Tanggal : ${widget.listbarangkeluar[widget.index]['tgl_barang_keluar']}",
                  style: new TextStyle(fontSize: 18.0),
                ),
                new Text(
                  "Customer : ${widget.listbarangkeluar[widget.index]['nama_customer']}",
                  style: new TextStyle(fontSize: 18.0),
                ),
                new Text(
                  "Banyak Barang : ${widget.listbarangkeluar[widget.index]['banyak_barang_keluar']}",
                  style: new TextStyle(fontSize: 18.0),
                ),
                new Text(
                  "Harga Jual : ${widget.listbarangkeluar[widget.index]['harga_jual']}",
                  style: new TextStyle(fontSize: 18.0),
                ),
                new Text(
                  "Total Bayar : ${widget.listbarangkeluar[widget.index]['total_bayar_keluar']}",
                  style: new TextStyle(fontSize: 18.0),
                ),
                new Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                ),
                new Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    new ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40)), backgroundColor: Colors.red),
                        child: new Text(
                          "Hapus",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          deleteDataBarangKeluar();
                          Navigator.of(context).push(new MaterialPageRoute(
                            builder: (BuildContext context) => Login(),
                          ));
                        }),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}