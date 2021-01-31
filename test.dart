import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

import 'dart:io';
import 'package:camera/camera.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  File _file;

  Future pickercamera() async {
    final myfile = await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      _file = File(myfile.path);
    });
  }

  Future upload() async {
    if (_file == null) return;

    String base64 = base64Encode(_file.readAsBytesSync());

    String imagename = _file.path.split("/").last;

    var url = "http://192.168.10./api/uploadimage.php";
    var data = {"imagename": imagename, "image64": base64};
    var response = await http.post(url, body: data);
    print(imagename);
    //print(_file);
    //print(base64);
  }

  Future uploadImage() async {
    final uri = Uri.parse("http://192.168.10./api/up.php");
    var request = http.MultipartRequest('POST', uri);
    //request.fields['name'] = nameController.text;
    var pic = await http.MultipartFile.fromPath("image", _file.path);
    request.files.add(pic);
    var response = await request.send();

    if (response.statusCode == 200) {
      print("image Upload");
    } else {
      print("Upload Failed");
    }
  }

  // Future uploading(File imagename) async {
  //   var stream =
  //       new http.ByteStream(DelegatingStream.typed(imagename.openRead()));
  //   var length = await imagename.length();
  //   var uri = Uri.parse("");
  //   var request = new http.MultipartRequest("POST", uri);
  //   var multpartFile = new http.MultipartFile("image", stream, length,
  //       filename: basename(imagename.path));

  //   request.files.add(multpartFile);

  //   var response = await request.send();

  //   if (response.statusCode == 200) {
  //     print("image Upload");
  //   } else {
  //     print("Upload Failed");
  //   }
  // }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Image'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            RaisedButton(child: Text("Get Image"), onPressed: pickercamera),
            Center(
              child: _file == null
                  ? Text("Image not Selected")
                  : Image.file(_file),
            ),
            RaisedButton(child: Text("Upload Image"), onPressed: uploadImage),
          ],
        ),
      ),
    );
  }
}
