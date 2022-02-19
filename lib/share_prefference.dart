// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

import 'package:shared_preferences/shared_preferences.dart';

String savePath='';

class SavePath {
  set_value(String id_count) async {
    savePath = await get_book_path(id_count) ?? 0.toString();
  }

  get_book_path(String id) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(id);
  }

  set_book_path(String id, String path) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(id, path);
  }
}













//     String savePath = "";
//   int global_path = 0;
//   int count_id = 0;


// class prefference extends StatefulWidget {


//   // prefference({this.savePath,required this.global_path,this.count_id});
//   @override
//   State createState() {
//     return prefferenceState();
//   }
// }

// class prefferenceState extends State<prefference> {
//   @override
//   void initState() {
//     super.initState();
//     for (var i = 0; i <= count_id; i++) {
//       set_value(i.toString());
//     }
//   }

//   set_value(String id_count) async {
//     savePath = await get_book_path(id_count) ?? 0.toString();
//   }

//   get_book_path(String id) async {
//     SharedPreferences pref = await SharedPreferences.getInstance();
//     return pref.getString(id);
//   }

//   set_book_path(String id, String path) async {
//     SharedPreferences pref = await SharedPreferences.getInstance();
//     pref.setString(id, path);
//   }
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         theme: ThemeData(primaryColor: Colors.pink),
//         home: Scaffold(
//           appBar: AppBar(
//             title: Text("${global_path}"),
//             backgroundColor: Colors.pink,
//           ),
//         ));
//   }
// }
