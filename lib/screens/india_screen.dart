import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../main.dart';
import '../theme/constants.dart';
import '../widgets/header.dart';
import '../models/india.dart';

class IndiaScreen extends StatefulWidget {
  final Function changeTheme;

  IndiaScreen(this.changeTheme);
  @override
  _IndiaScreenState createState() => _IndiaScreenState();
}

RegExp reg = new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
Function mathFunc = (Match match) => '${match[1]},';

Widget expandRow(String status, String deltaStatus, Color color) {
  return Expanded(
    flex: 2,
    child: Column(
      children: [
        Text(
          status.replaceAllMapped(reg, mathFunc),
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

class _IndiaScreenState extends State<IndiaScreen>
    with AutomaticKeepAliveClientMixin {
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
                    ? Header('States', data, null, widget.changeTheme)
                    : Container(
                        decoration: i % 2 == 1
                            ? BoxDecoration(
                                color: MyApp.isDarkTheme
                                    ? Color(0xff2c2c2c)
                                    : Color(0xfff3f3f3),
                                borderRadius: BorderRadius.circular(5),
                              )
                            : BoxDecoration(
                                color: MyApp.isDarkTheme
                                    ? kbAccentDarkColor22
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(5),
                              ),
                        padding: EdgeInsets.all(11),
                        margin: EdgeInsets.all(2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Text(
                                data.state,
                                style: TextStyle(
                                  color: MyApp.isDarkTheme
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            MyApp.isDarkTheme
                                ? expandRow(data.confirmed, data.deltaconfirmed,
                                    kbLightRed)
                                : expandRow(data.confirmed, data.deltaconfirmed,
                                    Colors.red),
                            MyApp.isDarkTheme
                                ? expandRow(data.recovered, data.deltarecovered,
                                    kbLightGreen)
                                : expandRow(data.recovered, data.deltarecovered,
                                    Colors.green),
                            MyApp.isDarkTheme
                                ? expandRow(
                                    data.deaths,
                                    data.deltadeaths,
                                    kbLightPurple,
                                  )
                                : expandRow(data.deaths, data.deltadeaths,
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

  @override
  bool get wantKeepAlive => true;
}
