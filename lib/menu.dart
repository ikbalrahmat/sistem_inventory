import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'detailbarang.dart';
import 'detailbarangmasuk.dart';
import 'detailbarangkeluar.dart';
import 'tambahbarang.dart';
import 'listbarangmasuk.dart';
import 'listbarangkeluar.dart';

class MainMenu extends StatefulWidget {
  final VoidCallback signOut;
  MainMenu(this.signOut);
  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  Future<List> getDataBarang() async {
    final response = await http.get(Uri.parse("http://10.0.2.2/sistem_inventory/getbarang.php"));
    return json.decode(response.body);
  }

  Future<List> getDataBarangMasuk() async {
    final response = await http.get(Uri.parse("http://10.0.2.2/sistem_inventory/getbarangmasuk.php"));
    return json.decode(response.body);
  }

  Future<List> getDataBarangKeluar() async {
    final response = await http.get(Uri.parse("http://10.0.2.2/sistem_inventory/getbarangkeluar.php"));
    return json.decode(response.body);
  }

  signOut() {
    setState(() {
      widget.signOut();
    });
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.green[500],
            title: Text("  Sistem Inventory"),
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            backgroundColor: Colors.green[500],
            onPressed: () => _modal(context),
          ),
          drawer: Drawer(
            child: ListView(
              children: <Widget>[
                UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                  ),
                  accountName: Row(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            color: Colors.grey[50]),
                        padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                        height: 25,
                        width: 75,
                        child: Row(
                          children: <Widget>[
                            Text(" "),
                            Icon(
                              Icons.lens,
                              color: Colors.green,
                              size: 8,
                            ),
                            Text(" Online",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black54))
                          ],
                        ),
                      )
                    ],
                  ),
                  accountEmail: Text("Administrator",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black54)),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor:
                        Theme.of(context).platform == TargetPlatform.iOS
                            ? Colors.green
                            : Colors.green[500],
                    child: Text(
                      "A",
                      style: TextStyle(fontSize: 40.0, color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  color: Colors.green[500],
                  height: 400,
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        title: Text("Keluar",
                            style: TextStyle(color: Colors.white)),
                        trailing: IconButton(
                          onPressed: () {
                            signOut();
                          },
                          icon: Icon(
                            Icons.directions_run,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: Container(
            color: Colors.green[500],
            child: TabBar(
              indicator: BoxDecoration(
                color: Colors.green[700],
                border: Border(
                  bottom: BorderSide(color: Colors.white, width: 3)
                )
              ),
              tabs: <Widget>[
                Tab(
                  icon: Icon(Icons.dashboard),
                  child: Text("Dashboard", style: TextStyle(fontSize: 8)),
                ),
                Tab(
                  icon: Icon(Icons.devices_other),
                  child: Text("Barang", style: TextStyle(fontSize: 8)),
                ),
                Tab(
                  icon: Icon(Icons.archive),
                  child: Text("Barang Masuk", style: TextStyle(fontSize: 7.1)),
                ),
                Tab(
                  icon: Icon(Icons.unarchive),
                  child: Text("Barang Keluar", style: TextStyle(fontSize: 7.1)),
                ),
              ],
            )
          ),
          body: TabBarView(
            children: <Widget>[
              Center(
                child: Column(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Center(
                        child: Column(
                          children: <Widget>[
                            Text(""),
                            Text(
                              "Dashboard",
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
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.fromLTRB(0, 7, 0, 0),
                        color: Colors.white,
                        child: ListView(
                          children: <Widget>[
                            Container(
                              child: Card(
                                child: ListTile(
                                  title: Text("Data Barang"),
                                  leading: CircleAvatar(
                                    backgroundColor: Colors.red[700],
                                    child: Icon(
                                      Icons.devices_other,
                                      color: Colors.white,
                                    ),
                                  ),
                                  subtitle: Text("4 Data"),
                                ),
                              ),
                            ),
                            Card(
                              child: ListTile(
                                title: Text("Data Barang Masuk"),
                                leading: CircleAvatar(
                                  backgroundColor: Colors.yellow[700],
                                  child: Icon(
                                    Icons.archive,
                                    color: Colors.white,
                                  ),
                                ),
                                subtitle: Text("3 Data"),
                              ),
                            ),
                            Card(
                              child: ListTile(
                                title: Text("Data Barang Keluar"),
                                leading: CircleAvatar(
                                  backgroundColor: Colors.blue[700],
                                  child: Icon(
                                    Icons.unarchive,
                                    color: Colors.white,
                                  ),
                                ),
                                subtitle: Text("3 Data"),
                              ),
                            ),
                          ]
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Center(
                child: FutureBuilder<List>(
                  future: getDataBarang(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) print(snapshot.error);
                    return snapshot.hasData
                        ? ListBarang(listbarang: snapshot.data!)
                        : Center(child: CircularProgressIndicator());
                  },
                ),
              ),
              Center(
                child: FutureBuilder<List>(
                  future: getDataBarangMasuk(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) print(snapshot.error);
                    return snapshot.hasData
                        ? ListBarangMasuk(listbarangmasuk: snapshot.data!)
                        : Center(child: CircularProgressIndicator());
                  },
                ),
              ),
              Center(
                child: FutureBuilder<List>(
                  future: getDataBarangKeluar(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) print(snapshot.error);
                    return snapshot.hasData
                        ? ListBarangKeluar(listbarangkeluar: snapshot.data!)
                        : Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            ],
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
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Center(
              child: Column(
                children: <Widget>[
                  Text(""),
                  Text(
                    "Data Barang",
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
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.fromLTRB(0, 7, 0, 0),
              color: Colors.white,
              child: ListView.builder(
                itemCount: listbarang.length,
                itemBuilder: (context, i) {
                  return Container(
                    padding: const EdgeInsets.fromLTRB(5, 0, 5, 2.5),
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) => DetailBarang(
                            listbarang: listbarang,
                            index: i,
                          )
                        )
                      ),
                      child: Card(
                        child: ListTile(
                          title: Text(listbarang[i]['nama_barang']),
                          leading: CircleAvatar(
                            backgroundColor: Colors.red[700],
                            child: Icon(
                              Icons.devices_other,
                              color: Colors.white,
                            ),
                          ),
                          subtitle: Text("Stock : ${listbarang[i]['stock']}"),
                        ),
                      ),
                    ),
                  );
                }
              ),
            )
          ),
        ],
      ),
    );
  }
}

class ListBarangMasuk extends StatelessWidget {
  final List listbarangmasuk;
  ListBarangMasuk({required this.listbarangmasuk});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Center(
              child: Column(
                children: <Widget>[
                  Text(""),
                  Text(
                    "Data Barang Masuk",
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
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.fromLTRB(0, 7, 0, 0),
              color: Colors.white,
              child: ListView.builder(
                itemCount: listbarangmasuk.length,
                itemBuilder: (context, i) {
                  return Container(
                    padding: const EdgeInsets.fromLTRB(5, 0, 5, 2.5),
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) => DetailBarangMasuk(
                            listbarangmasuk: listbarangmasuk,
                            index: i,
                          )
                        )
                      ),
                      child: Card(
                        child: ListTile(
                          title: Text(listbarangmasuk[i]['nama_barang']),
                          leading: CircleAvatar(
                            backgroundColor: Colors.yellow[700],
                            child: Icon(
                              Icons.archive,
                              color: Colors.white,
                            ),
                          ),
                          subtitle: Text(
                            "Tanggal Transaksi : ${listbarangmasuk[i]['tgl_barang_masuk']}"
                          ),
                        ),
                      ),
                    ),
                  );
                }
              ),
            )
          ),
        ],
      ),
    );
  }
}

class ListBarangKeluar extends StatelessWidget {
  final List listbarangkeluar;
  ListBarangKeluar({required this.listbarangkeluar});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Center(
              child: Column(
                children: <Widget>[
                  Text(""),
                  Text(
                    "Data Barang Keluar",
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
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.fromLTRB(0, 7, 0, 0),
              color: Colors.white,
              child: ListView.builder(
                itemCount: listbarangkeluar.length,
                itemBuilder: (context, i) {
                  return Container(
                    padding: const EdgeInsets.fromLTRB(5, 0, 5, 2.5),
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) => DetailBarangKeluar(
                            listbarangkeluar: listbarangkeluar,
                            index: i,
                          )
                        )
                      ),
                      child: Card(
                        child: ListTile(
                          title: Text(listbarangkeluar[i]['nama_barang']),
                          leading: CircleAvatar(
                            backgroundColor: Colors.blue[700],
                            child: Icon(
                              Icons.unarchive,
                              color: Colors.white,
                            ),
                          ),
                          subtitle: Text(
                            "Tanggal Transaksi : ${listbarangkeluar[i]['tgl_barang_keluar']}"
                          ),
                        ),
                      ),
                    ),
                  );
                }
              ),
            )
          ),
        ],
      ),
    );
  }
}

void _modal(context) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext bc) {
      return Container(
        child: Wrap(
          children: <Widget>[
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.red[700],
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
              title: Text(
                'Data Barang',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.red[700]
                )
              ),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => TambahBarang(),
                )
              ),
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.yellow[700],
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
              title: Text(
                'Data Barang Masuk',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.yellow[700]
                )
              ),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => ListTambahBarangMasuk(),
                )
              ),
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blue[700],
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
              title: Text(
                'Data Barang Keluar',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[700]
                )
              ),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => ListTambahBarangKeluar(),
                )
              ),
            ),
          ],
        ),
      );
    }
  );
}
