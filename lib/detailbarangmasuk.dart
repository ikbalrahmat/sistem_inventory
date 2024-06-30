import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'login.dart';

class DetailBarangMasuk extends StatefulWidget {
  List listbarangmasuk;
  int index;
  DetailBarangMasuk({required this.index, required this.listbarangmasuk});
  @override
  _DetailBarangMasukState createState() => new _DetailBarangMasukState();
}

class _DetailBarangMasukState extends State<DetailBarangMasuk> {
  void deleteDataBarangMasuk() {
    var url = Uri.parse("http://10.0.2.2/sistem_inventory/deletebarangmasuk.php");
    http.post(url, body: {
      'id_barang_masuk': widget.listbarangmasuk[widget.index]['id_barang_masuk']
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Detail Barang Masuk"),
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
                  "Barang : ${widget.listbarangmasuk[widget.index]['nama_barang']}",
                  style: new TextStyle(fontSize: 18.0),
                ),
                new Text(
                  "Tanggal : ${widget.listbarangmasuk[widget.index]['tgl_barang_masuk']}",
                  style: new TextStyle(fontSize: 18.0),
                ),
                new Text(
                  "Supplier : ${widget.listbarangmasuk[widget.index]['nama_supplier']}",
                  style: new TextStyle(fontSize: 18.0),
                ),
                new Text(
                  "Banyak Barang : ${widget.listbarangmasuk[widget.index]['banyak_barang_masuk']}",
                  style: new TextStyle(fontSize: 18.0),
                ),
                new Text(
                  "Harga Beli : ${widget.listbarangmasuk[widget.index]['harga_beli']}",
                  style: new TextStyle(fontSize: 18.0),
                ),
                new Text(
                  "Total Bayar : ${widget.listbarangmasuk[widget.index]['total_bayar_masuk']}",
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
                          deleteDataBarangMasuk();
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