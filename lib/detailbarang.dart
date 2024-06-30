import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sistem_inventory/editbarang.dart';
import 'login.dart';

class DetailBarang extends StatefulWidget {
  List listbarang;
  int index;
  DetailBarang({required this.index, required this.listbarang});
  @override
  _DetailBarangState createState() => new _DetailBarangState();
}

class _DetailBarangState extends State<DetailBarang> {
  void deleteDataBarang() {
    var url = Uri.parse("http://10.0.2.2/sistem_inventory/deletebarang.php");
    http.post(url, body: {'id_barang': widget.listbarang[widget.index]['id_barang']});
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Detail Barang"),
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
                  "Barang : ${widget.listbarang[widget.index]['nama_barang']}",
                  style: new TextStyle(fontSize: 18.0),
                ),
                new Text(
                  "Kategori : ${widget.listbarang[widget.index]['kategori_barang']}",
                  style: new TextStyle(fontSize: 18.0),
                ),
                new Text(
                  "Stock Barang : ${widget.listbarang[widget.index]['stock']}",
                  style: new TextStyle(fontSize: 18.0),
                ),
                new Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                ),
                new Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    // Assuming EditDataBarang class exists and is corrected
                    new ElevatedButton(
                      child: new Text("Edit",
                          style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40)), backgroundColor: Colors.green),
                      onPressed: () => Navigator.of(context).push(
                        new MaterialPageRoute(
                          builder: (BuildContext context) => new EditDataBarang( // Assuming EditDataBarang class exists and is corrected
                            listbarang: widget.listbarang,
                            index: widget.index,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8), // For spacing
                    new ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40)), backgroundColor: Colors.red),
                        child: new Text(
                          "Hapus",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          deleteDataBarang();
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