// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'menu.dart';

// class Login extends StatefulWidget {
//   @override
//   _LoginState createState() => _LoginState();
// }

// enum LoginStatus { notSignIn, signIn }

// class _LoginState extends State<Login> {
//   LoginStatus _loginStatus = LoginStatus.notSignIn;
//   String email = '';
//   String password = '';
//   final _key = GlobalKey<FormState>();
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

//   bool _secureText = true;

//   showHide() {
//     setState(() {
//       _secureText = !_secureText;
//     });
//   }

//   check() {
//     final form = _key.currentState;
//     if (form!.validate()) {
//       form.save();
//       login();
//     }
//   }

//   login() async {
//     try {
//       final response = await http.post(
//         Uri.parse("http://10.0.2.2/sistem_inventory/login.php"),
//         body: {"email": email, "password": password},
//       );
//       final data = jsonDecode(response.body);
//       int value = data['value'];
//       String pesan = data['message'];
//       String emailAPI = data['email'];
//       String namaAPI = data['nama'];
//       String id = data['id'];
//       if (value == 1) {
//         setState(() {
//           _loginStatus = LoginStatus.signIn;
//           savePref(value, emailAPI, namaAPI, id);
//         });
//         print(pesan);
//       } else {
//         print(pesan);
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: const Text("Login Gagal! Silahkan Ulangi Kembali"),
//           backgroundColor: Colors.red,
//           duration: Duration(seconds: 3),
//         ));
//       }
//     } catch (e) {
//       print("Error: $e");
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: const Text("Tidak dapat terhubung ke server"),
//         backgroundColor: Colors.red,
//         duration: Duration(seconds: 3),
//       ));
//     }
//   }

//   savePref(int value, String email, String nama, String id) async {
//     SharedPreferences preferences = await SharedPreferences.getInstance();
//     setState(() {
//       preferences.setInt("value", value);
//       preferences.setString("nama", nama);
//       preferences.setString("email", email);
//       preferences.setString("id", id);
//       preferences.commit();
//     });
//   }

//   var value;
//   getPref() async {
//     SharedPreferences preferences = await SharedPreferences.getInstance();
//     setState(() {
//       value = preferences.getInt("value");

//       _loginStatus = value == 1 ? LoginStatus.signIn : LoginStatus.notSignIn;
//     });
//   }

//   signOut() async {
//     SharedPreferences preferences = await SharedPreferences.getInstance();
//     setState(() {
//       preferences.setInt("value", 0);
//       preferences.commit();
//       _loginStatus = LoginStatus.notSignIn;
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     getPref();
//   }

//   @override
//   Widget build(BuildContext context) {
//     switch (_loginStatus) {
//       case LoginStatus.notSignIn:
//         return Scaffold(
//           backgroundColor: Colors.green[500],
//           key: _scaffoldKey,
//           body: Form(
//             key: _key,
//             child: ListView(
//               padding: EdgeInsets.all(20.0),
//               children: <Widget>[
//                 Column(
//                   children: <Widget>[
//                     Container(
//                       height: 45,
//                     )
//                   ],
//                 ),
//                 Column(
//                   children: <Widget>[
//                     Container(
//                       child: Image.asset('assets/images/logo.png',
//                           width: 70, height: 70),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(50),
//                         border: Border.all(
//                           color: Colors.white,
//                           width: 3,
//                         ),
//                         boxShadow: [
//                           BoxShadow(
//                             blurRadius: 2.0,
//                             color: Colors.black26,
//                             offset: Offset(0.0, 2.0),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Container(
//                       height: 15,
//                     )
//                   ],
//                 ),
//                 Text(
//                   "SISTEM INVENTORY",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 20,
//                     shadows: [
//                       Shadow(
//                         blurRadius: 2.0,
//                         color: Colors.black26,
//                         offset: Offset(0.0, 1.5),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Column(
//                   children: <Widget>[
//                     Container(
//                       height: 20,
//                     )
//                   ],
//                 ),
//                 Container(
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(15),
//                     boxShadow: [
//                       BoxShadow(
//                         blurRadius: 2.0,
//                         color: Colors.black26,
//                         offset: Offset(0.0, 1.5),
//                       ),
//                     ],
//                   ),
//                   padding: EdgeInsets.fromLTRB(15, 10, 15, 30),
//                   child: Column(
//                     children: <Widget>[
//                       Column(
//                         children: <Widget>[
//                           Container(
//                             height: 20,
//                           )
//                         ],
//                       ),
//                       TextFormField(
//                         validator: (e) {
//                           if (e!.isEmpty) {
//                             return "   Tolong Masukan Username";
//                           }
//                           return null;
//                         },
//                         onSaved: (e) => email = e!,
//                         decoration: InputDecoration(
//                           contentPadding:
//                               const EdgeInsets.symmetric(vertical: 10.0),
//                           labelText: "Username",
//                           hintText: "Masukan Username",
//                           prefixIcon: Icon(Icons.account_circle),
//                           fillColor: Colors.white,
//                           filled: true,
//                           border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(30)),
//                         ),
//                       ),
//                       Column(
//                         children: <Widget>[
//                           Container(
//                             height: 15,
//                           )
//                         ],
//                       ),
//                       TextFormField(
//                         obscureText: _secureText,
//                         validator: (e) {
//                           if (e!.isEmpty) {
//                             return "   Tolong Masukan Password";
//                           }
//                           return null;
//                         },
//                         onSaved: (e) => password = e!,
//                         decoration: InputDecoration(
//                           contentPadding:
//                               const EdgeInsets.symmetric(vertical: 10.0),
//                           labelText: "Password",
//                           hintText: "Masukan Password",
//                           prefixIcon: Icon(Icons.lock),
//                           fillColor: Colors.white,
//                           filled: true,
//                           border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(40)),
//                           suffixIcon: IconButton(
//                             onPressed: showHide,
//                             icon: Icon(_secureText
//                                 ? Icons.visibility_off
//                                 : Icons.visibility),
//                           ),
//                         ),
//                       ),
//                       Column(
//                         children: <Widget>[
//                           Container(
//                             height: 15,
//                           )
//                         ],
//                       ),
//                       MaterialButton(
//                         color: Colors.green[500],
//                         height: 45,
//                         minWidth: 300,
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(40)),
//                         onPressed: () {
//                           check();
//                         },
//                         child: Text(
//                           "Login",
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Column(
//                   children: <Widget>[
//                     Container(
//                       height: 15,
//                     )
//                   ],
//                 ),
//                 Text(
//                   "Copyright ©2024 Sistem Inventory",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 10,
//                     shadows: [
//                       Shadow(
//                         blurRadius: 2.0,
//                         color: Colors.black26,
//                         offset: Offset(0.0, 1.5),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       case LoginStatus.signIn:
//         return MainMenu(signOut);
//     }
//   }
// }

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'menu.dart';

// class Login extends StatefulWidget {
//   @override
//   _LoginState createState() => _LoginState();
// }

// enum LoginStatus { notSignIn, signIn }

// class _LoginState extends State<Login> {
//   LoginStatus _loginStatus = LoginStatus.notSignIn;
//   String email = '';
//   String password = '';
//   final _key = GlobalKey<FormState>();
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

//   bool _secureText = true;

//   showHide() {
//     setState(() {
//       _secureText = !_secureText;
//     });
//   }

//   check(Future pushReplacement) {
//     final form = _key.currentState;
//     if (form!.validate()) {
//       form.save();
//       login();
//     }
//   }

//   login() async {
//     try {
//       final response = await http.post(
//         Uri.parse("http://10.0.2.2/sistem_inventory/login.php"),
//         body: {"email": email, "password": password},
//       );
//       final data = jsonDecode(response.body);
//       print(data); // Print response for debugging
//       int value = data['value'];
//       String pesan = data['message'];
//       String emailAPI = data['email'];
//       String namaAPI = data['nama'];
//       String id = data['id'];
//       if (value == 1) {
//         setState(() {
//           _loginStatus = LoginStatus.signIn;
//           savePref(value, emailAPI, namaAPI, id);
//         });
//         print(pesan);
//         // Navigate to the main menu
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => MainMenu(signOut)),
//         );
//       } else {
//         print(pesan);
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: const Text("Login Gagal! Silahkan Ulangi Kembali"),
//           backgroundColor: Colors.red,
//           duration: Duration(seconds: 3),
//         ));
//       }
//     } catch (e) {
//       print("Error: $e");
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: const Text("Tidak dapat terhubung ke server"),
//         backgroundColor: Colors.red,
//         duration: Duration(seconds: 3),
//       ));
//     }
//   }

//   savePref(int value, String email, String nama, String id) async {
//     SharedPreferences preferences = await SharedPreferences.getInstance();
//     preferences.setInt("value", value);
//     preferences.setString("nama", nama);
//     preferences.setString("email", email);
//     preferences.setString("id", id);
//     preferences.commit();
//   }

//   var value;
//   getPref() async {
//     SharedPreferences preferences = await SharedPreferences.getInstance();
//     value = preferences.getInt("value") ?? 0;

//     setState(() {
//       _loginStatus = value == 1 ? LoginStatus.signIn : LoginStatus.notSignIn;
//     });
//   }

//   signOut() async {
//     SharedPreferences preferences = await SharedPreferences.getInstance();
//     preferences.setInt("value", 0);
//     preferences.commit();
//     setState(() {
//       _loginStatus = LoginStatus.notSignIn;
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     getPref();
//   }

//   @override
//   Widget build(BuildContext context) {
//     switch (_loginStatus) {
//       case LoginStatus.notSignIn:
//         return Scaffold(
//           backgroundColor: Colors.green[500],
//           key: _scaffoldKey,
//           body: Form(
//             key: _key,
//             child: ListView(
//               padding: EdgeInsets.all(20.0),
//               children: <Widget>[
//                 Column(
//                   children: <Widget>[
//                     Container(
//                       height: 45,
//                     )
//                   ],
//                 ),
//                 Column(
//                   children: <Widget>[
//                     Container(
//                       child: Image.asset('assets/images/logo.png',
//                           width: 70, height: 70),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(50),
//                         border: Border.all(
//                           color: Colors.white,
//                           width: 3,
//                         ),
//                         boxShadow: [
//                           BoxShadow(
//                             blurRadius: 2.0,
//                             color: Colors.black26,
//                             offset: Offset(0.0, 2.0),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Container(
//                       height: 15,
//                     )
//                   ],
//                 ),
//                 Text(
//                   "SISTEM INVENTORY",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 20,
//                     shadows: [
//                       Shadow(
//                         blurRadius: 2.0,
//                         color: Colors.black26,
//                         offset: Offset(0.0, 1.5),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Column(
//                   children: <Widget>[
//                     Container(
//                       height: 20,
//                     )
//                   ],
//                 ),
//                 Container(
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(15),
//                     boxShadow: [
//                       BoxShadow(
//                         blurRadius: 2.0,
//                         color: Colors.black26,
//                         offset: Offset(0.0, 1.5),
//                       ),
//                     ],
//                   ),
//                   padding: EdgeInsets.fromLTRB(15, 10, 15, 30),
//                   child: Column(
//                     children: <Widget>[
//                       Column(
//                         children: <Widget>[
//                           Container(
//                             height: 20,
//                           )
//                         ],
//                       ),
//                       TextFormField(
//                         validator: (e) {
//                           if (e!.isEmpty) {
//                             return "   Tolong Masukan Username";
//                           }
//                           return null;
//                         },
//                         onSaved: (e) => email = e!,
//                         decoration: InputDecoration(
//                           contentPadding:
//                               const EdgeInsets.symmetric(vertical: 10.0),
//                           labelText: "Username",
//                           hintText: "Masukan Username",
//                           prefixIcon: Icon(Icons.account_circle),
//                           fillColor: Colors.white,
//                           filled: true,
//                           border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(30)),
//                         ),
//                       ),
//                       Column(
//                         children: <Widget>[
//                           Container(
//                             height: 15,
//                           )
//                         ],
//                       ),
//                       TextFormField(
//                         obscureText: _secureText,
//                         validator: (e) {
//                           if (e!.isEmpty) {
//                             return "   Tolong Masukan Password";
//                           }
//                           return null;
//                         },
//                         onSaved: (e) => password = e!,
//                         decoration: InputDecoration(
//                           contentPadding:
//                               const EdgeInsets.symmetric(vertical: 10.0),
//                           labelText: "Password",
//                           hintText: "Masukan Password",
//                           prefixIcon: Icon(Icons.lock),
//                           fillColor: Colors.white,
//                           filled: true,
//                           border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(40)),
//                           suffixIcon: IconButton(
//                             onPressed: showHide,
//                             icon: Icon(_secureText
//                                 ? Icons.visibility_off
//                                 : Icons.visibility),
//                           ),
//                         ),
//                       ),
//                       Column(
//                         children: <Widget>[
//                           Container(
//                             height: 15,
//                           )
//                         ],
//                       ),
//                       MaterialButton(
//                         color: Colors.green[500],
//                         height: 45,
//                         minWidth: 300,
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(40)),
//                         onPressed: () {
//                           check(
//                               // Navigate to the main menu
//                               Navigator.pushReplacement(
//                                 context,
//                                 MaterialPageRoute(builder: (context) => MainMenu(signOut)),
//                               ),
                          
//                           );
//                         },
//                         child: Text(
//                           "Login",
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Column(
//                   children: <Widget>[
//                     Container(
//                       height: 15,
//                     )
//                   ],
//                 ),
//                 Text(
//                   "Copyright ©2024 Sistem Inventory",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 10,
//                     shadows: [
//                       Shadow(
//                         blurRadius: 2.0,
//                         color: Colors.black26,
//                         offset: Offset(0.0, 1.5),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       case LoginStatus.signIn:
//         return MainMenu(signOut);
//     }
//   }
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'menu.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

enum LoginStatus { notSignIn, signIn }

class _LoginState extends State<Login> {
  LoginStatus _loginStatus = LoginStatus.notSignIn;
  String email = '';
  String password = '';
  final _key = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _secureText = true;

  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  check() {
    final form = _key.currentState;
    if (form!.validate()) {
      form.save();
      login();
    }
  }

  login() async {
    try {
      final response = await http.post(
        Uri.parse("http://10.0.2.2/sistem_inventory/login.php"),
        body: {"email": email, "password": password},
      );
      final data = jsonDecode(response.body);
      print(data); // Print response for debugging
      int value = data['value'];
      String pesan = data['message'];
      String emailAPI = data['email'];
      String namaAPI = data['nama'];
      String id = data['id'];
      if (value == 1) {
        setState(() {
          _loginStatus = LoginStatus.signIn;
          savePref(value, emailAPI, namaAPI, id);
        });
        print(pesan);
        // Navigate to the main menu
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MainMenu(signOut)),
        );
      } else {
        print(pesan);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text("Login Gagal! Silahkan Ulangi Kembali"),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ));
      }
    } catch (e) {
      print("Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text("Tidak dapat terhubung ke server"),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
      ));
    }
  }

  savePref(int value, String email, String nama, String id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt("value", value);
    preferences.setString("nama", nama);
    preferences.setString("email", email);
    preferences.setString("id", id);
    preferences.commit();
  }

  var value;
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    value = preferences.getInt("value") ?? 0;

    setState(() {
      _loginStatus = value == 1 ? LoginStatus.signIn : LoginStatus.notSignIn;
    });
  }

  signOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt("value", 0);
    preferences.commit();
    setState(() {
      _loginStatus = LoginStatus.notSignIn;
    });
  }

  @override
  void initState() {
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    switch (_loginStatus) {
      case LoginStatus.notSignIn:
        return Scaffold(
          backgroundColor: Colors.green[500],
          key: _scaffoldKey,
          body: Form(
            key: _key,
            child: ListView(
              padding: EdgeInsets.all(20.0),
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      height: 45,
                    )
                  ],
                ),
                Column(
                  children: <Widget>[
                    Container(
                      child: Image.asset('assets/images/logo.png',
                          width: 70, height: 70),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                          color: Colors.white,
                          width: 3,
                        ),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 2.0,
                            color: Colors.black26,
                            offset: Offset(0.0, 2.0),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 15,
                    )
                  ],
                ),
                Text(
                  "SISTEM INVENTORY",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    shadows: [
                      Shadow(
                        blurRadius: 2.0,
                        color: Colors.black26,
                        offset: Offset(0.0, 1.5),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: <Widget>[
                    Container(
                      height: 20,
                    )
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 2.0,
                        color: Colors.black26,
                        offset: Offset(0.0, 1.5),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.fromLTRB(15, 10, 15, 30),
                  child: Column(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Container(
                            height: 20,
                          )
                        ],
                      ),
                      TextFormField(
                        validator: (e) {
                          if (e!.isEmpty) {
                            return "   Tolong Masukan Username";
                          }
                          return null;
                        },
                        onSaved: (e) => email = e!,
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 10.0),
                          labelText: "Username",
                          hintText: "Masukan Username",
                          prefixIcon: Icon(Icons.account_circle),
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30)),
                        ),
                      ),
                      Column(
                        children: <Widget>[
                          Container(
                            height: 15,
                          )
                        ],
                      ),
                      TextFormField(
                        obscureText: _secureText,
                        validator: (e) {
                          if (e!.isEmpty) {
                            return "   Tolong Masukan Password";
                          }
                          return null;
                        },
                        onSaved: (e) => password = e!,
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 10.0),
                          labelText: "Password",
                          hintText: "Masukan Password",
                          prefixIcon: Icon(Icons.lock),
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40)),
                          suffixIcon: IconButton(
                            onPressed: showHide,
                            icon: Icon(_secureText
                                ? Icons.visibility_off
                                : Icons.visibility),
                          ),
                        ),
                      ),
                      Column(
                        children: <Widget>[
                          Container(
                            height: 15,
                          )
                        ],
                      ),
                      MaterialButton(
                        color: Colors.green[500],
                        height: 45,
                        minWidth: 300,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40)),
                        onPressed: () {
                          check();
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: <Widget>[
                    Container(
                      height: 15,
                    )
                  ],
                ),
                Text(
                  "Copyright ©2024 Sistem Inventory",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                    shadows: [
                      Shadow(
                        blurRadius: 2.0,
                        color: Colors.black26,
                        offset: Offset(0.0, 1.5),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      case LoginStatus.signIn:
        return MainMenu(signOut);
    }
  }
}
