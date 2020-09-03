import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './album.dart';

void main() {
  runApp(MyApp());
}

Future<List<Album>> fetchAlbum() async {
  final response =
      await http.get('https://jsonplaceholder.typicode.com/photos');

  if (response.statusCode == 200) {
    List<Album> data = [];
    var returnData = json.decode(response.body);

    for (int i = 0; i < returnData.length; i++) {
      data.add(Album(
          albumId: returnData[i]['albumId'],
          id: returnData[i]['id'],
          title: returnData[i]['title'],
          url: returnData[i]['url'],
          thumbnailUrl: returnData[i]['thumbnailUrl']));
    }
    print(data);
    return data;
  } else {
    throw Exception('Failed to load album');
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<List<Album>> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Covid19',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Covid19 Tracker'),
        ),
        body: Center(
          child: FutureBuilder<List<Album>>(
            future: futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemBuilder: (context, i) {
                    return ListTile(
                      leading: CircleAvatar(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.network(snapshot.data[i].thumbnailUrl),
                        ),
                      ),
                      title: Text(snapshot.data[i].title),
                      subtitle: Text(snapshot.data[i].albumId.toString()),
                    );
                  },
                  itemCount: snapshot.data.length,
                );
              } else if (snapshot.hasError) {
                return Text('Error!');
              }
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
