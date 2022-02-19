import 'package:down_and_store_share_prefference/share_prefference.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:open_file/open_file.dart';

void main() {
  runApp(DownloadFile());
}

class DownloadFile extends StatefulWidget {
  @override
  State createState() {
    return _DownloadFileState();
  }
}

class _DownloadFileState extends State {
  var imageUrl =
      "https://www.itl.cat/pngfile/big/10-100326_desktop-wallpaper-hd-full-screen-free-download-full.jpg";
  bool downloading = true;
  String downloadingStr = "No data";
  String savePath = "";
  int count_id = 0;
  String updata = '';
  @override
  void initState() {
    super.initState();
    check_save_path(count_id.toString());
    if (savePath == "") {
      downloadFile();
      set_value(count_id.toString());
    }
  }

  check_save_path(String id_count) async {
    savePath = await get_book_path(id_count) ?? 0.toString();
  }

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

  Future downloadFile() async {
    try {
      Dio dio = Dio();

      String fileName = imageUrl.substring(imageUrl.lastIndexOf("/") + 1);

      savePath = await getFilePath(fileName);
      SavePath().set_book_path(count_id.toString(), savePath);
      // count_id++;
      await dio.download(imageUrl, savePath, onReceiveProgress: (rec, total) {
        setState(() {
          downloading = true;
          // download = (rec / total) * 100;
          downloadingStr = "Downloading Image : $rec";
        });
      });
      setState(() {
        downloading = false;
        downloadingStr = "Completed";
      });
    } catch (e) {
      print(e.toString());
    }
  }
  Future<String> getFilePath(uniqueFileName) async {
    String path = '';

    Directory dir = await getApplicationDocumentsDirectory();

    path = '${dir.path}/$uniqueFileName';

    return path;
  }
  Future<File> file_wait(String path) async {
    return File(path);
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.pink),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Download File"),
          backgroundColor: Colors.pink,
        ),
        body: Center(
          child: savePath == ''
              ? Container(
                  height: 250,
                  width: 250,
                  child: Card(
                    color: Colors.pink,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(
                          backgroundColor: Colors.white,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          downloadingStr,
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                )
              : Container(
                  height: 250,
                  width: 250,
                  child: Center(
                    child: ElevatedButton(
                        onPressed: () {
                          
                            OpenFile.open(savePath);
                          
                        },
                        child: Text('click to open')),
                  ),
                ),
        ),
      ),
    );
  }
}
