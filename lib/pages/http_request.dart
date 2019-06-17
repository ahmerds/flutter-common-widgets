import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class Items {
  final int albumId;
  final int id;
  final String title;
  final String url;
  final String thumbnailUrl;

  Items({this.albumId, this.id, this.title, this.url, this.thumbnailUrl});

  factory Items.fromJson(Map<String, dynamic> json) {
    return Items(
      albumId: json['albumId'] as int,
      id: json['id'] as int,
      title: json['title'] as String,
      url: json['url'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String
    );
  }
}

List<Items> parseItems(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Items>((json) => Items.fromJson(json)).toList();
}

Future<List<Items>> fetchItems(http.Client client) async {
  final response = await client.get("https://jsonplaceholder.typicode.com/photos");

  return compute(parseItems, response.body);
}

Widget futureList = FutureBuilder(
  future: fetchItems(http.Client()),
  builder: (context, snapshot) {
    if(snapshot.hasError) {
      print(snapshot.error);
      return Center(child: Text("An error occured"));
    }

    return snapshot.hasData ?
        ListViewItems(items: snapshot.data) : Center(child: CircularProgressIndicator());
  },
);

class ListViewItems extends StatelessWidget {
  final List<Items> items;

  ListViewItems({Key key, this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        padding: EdgeInsets.all(15.0),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Column(
            children: <Widget>[
              Divider(),
              ListTile(
                title: Text("${items[index].title}",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16.0
                  ),
                ),
                subtitle: Text("Album ID: ${items[index].albumId}"),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage("${items[index].thumbnailUrl}"),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}

class HttpRequest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("HTTP Request Demo"), backgroundColor: Colors.cyan,),
      body: Container(
        child: futureList,
      )
    );
  }
}