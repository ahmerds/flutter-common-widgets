import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

import 'package:flutter/material.dart';

class JsonStorage extends StatefulWidget {
  @override
  _JsonStorageState createState() => _JsonStorageState();
}

class _JsonStorageState extends State<JsonStorage> {
  TextEditingController keyInputController = TextEditingController();
  TextEditingController valueInputController = TextEditingController();

  File jsonFile;
  Directory dir;
  String fileName = "myJSONFile.json";
  bool fileExists = false;
  Map<String, dynamic> fileContent;

  @override
  void initState() {
    super.initState();
    getApplicationDocumentsDirectory().then((Directory directory) {
      dir = directory;
      jsonFile = new File(dir.path + "/" + fileName);
      fileExists = jsonFile.existsSync();

      if(fileExists) {
        this.setState(() => fileContent = json.decode(jsonFile.readAsStringSync()));
      }
    });
  }

  @override
  void dispose() {
    keyInputController.dispose();
    valueInputController.dispose();
    super.dispose();
  }

  void createFile(Map<String, dynamic> content, Directory dir, String fileName) {
    print("Creating File");
    File file = new File(dir.path + "/" + fileName);
    file.createSync();
    fileExists = true;
    file.writeAsStringSync(json.encode(content));
  }

  void writeToFile(String key, String value) {
    print("Writing to a file");
    Map<String, dynamic> content = { key: value };
    if(fileExists) {
      print("File Exists");
      Map<String, dynamic> jsonFileContent = json.decode(jsonFile.readAsStringSync());
      jsonFileContent.addAll(content);
      jsonFile.writeAsStringSync(json.encode(jsonFileContent));
    } else {
      print("File does not exist");
      createFile(content, dir, fileName);
    }

    this.setState(() => fileContent = json.decode(jsonFile.readAsStringSync()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("JSON Storage Tutorial"), backgroundColor: Colors.amber,),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Text("File content: ", style: TextStyle(fontWeight: FontWeight.bold),),
            Text(fileContent.toString()),
            Padding(padding: EdgeInsets.only(top: 15.0)),
            Text("Add to JSON File"),
            TextField(
              controller: keyInputController,
              decoration: InputDecoration(labelText: "Enter key"),
            ),
            TextField(
              controller: valueInputController,
              decoration: InputDecoration(labelText: "Enter value"),
            ),
            RaisedButton(
              child: Text("Add key/value pair"),
              onPressed: () => writeToFile(keyInputController.text.toLowerCase(), valueInputController.text),
            )
          ],
        )
      ),
    );
  }
}