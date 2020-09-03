import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../widgets/header.dart';
import '../models/india.dart';

Future<List<India>> fetchData() async {
  final response = await http.get('https://api.covid19india.org/data.json');

  if (response.statusCode == 200) {
    List<India> data = [];
    var finalData = json.decode(response.body);
    var returnData = finalData['statewise'];

    for (int i = 0; i < returnData.length; i++) {
      data.add(India(
        active: returnData[i]['active'],
        confirmed: returnData[i]['confirmed'],
        deltaconfirmed: returnData[i]['deltaconfirmed'],
        deaths: returnData[i]['deaths'],
        deltadeaths: returnData[i]['deltadeaths'],
        recovered: returnData[i]['recovered'],
        deltarecovered: returnData[i]['deltarecovered'],
        lastupdatedtime: returnData[i]['lastupdatedtime'],
        migratedother: returnData[i]['migratedother'],
        state: returnData[i]['state'],
        statecode: returnData[i]['statecode'],
        statenotes: returnData[i]['statenotes'],
      ));
    }

    return data;
  } else {
    print('error');
    throw Exception('Failed to load album');
  }
}

class IndiaScreen extends StatefulWidget {
  @override
  _IndiaScreenState createState() => _IndiaScreenState();
}

Widget expandRow(String status, String deltaStatus, Color color) {
  return Expanded(
    flex: 2,
    child: Column(
      children: [
        Text(
          status,
          style: TextStyle(
              color: color, fontSize: 15, fontWeight: FontWeight.bold),
        ),
        if (deltaStatus != '0')
          Text(
            '↑$deltaStatus',
            style: TextStyle(color: Colors.grey, fontSize: 15),
          ),
      ],
    ),
  );
}

class _IndiaScreenState extends State<IndiaScreen> {
  Future<List<India>> futureData;

  @override
  void initState() {
    super.initState();
    futureData = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<List<India>>(
        future: futureData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemBuilder: (context, i) {
                final data = snapshot.data[i];
                return i == 0
                    ? Header('States', data)
                    : Container(
                        color: i % 2 == 1 ? Color(0xfff3f3f3) : Colors.white,
                        padding: EdgeInsets.all(11),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Text(
                                data.state,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            expandRow(data.confirmed, data.deltaconfirmed,
                                Colors.red),
                            expandRow(data.recovered, data.deltarecovered,
                                Colors.green),
                            expandRow(data.deaths, data.deltadeaths,
                                Colors.deepPurple),
                          ],
                        ),
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
    );
  }
}
