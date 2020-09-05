import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sher_in_the_city/main.dart';
import 'package:sher_in_the_city/theme/constants.dart';
import '../widgets/header.dart';
import '../models/world.dart';

class WorldScreen extends StatefulWidget {
  final Function changeTheme;
  WorldScreen(this.changeTheme);
  @override
  _WorldScreenState createState() => _WorldScreenState();
}

RegExp reg = new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
Function mathFunc = (Match match) => '${match[1]},';

Widget expandRow(int status, int deltaStatus, Color color) {
  return Expanded(
    flex: 2,
    child: Column(
      children: [
        Text(
          status.toString().replaceAllMapped(reg, mathFunc),
          style: TextStyle(
              color: color, fontSize: 15, fontWeight: FontWeight.bold),
        ),
        if (deltaStatus != 0)
          Text(
            '↑${deltaStatus.toString().replaceAllMapped(reg, mathFunc)}',
            style: TextStyle(
                color: MyApp.isDarkTheme ? Colors.grey : Color(0xff919191),
                fontSize: 15),
          ),
      ],
    ),
  );
}

class _WorldScreenState extends State<WorldScreen>
    with AutomaticKeepAliveClientMixin {
  var totalConfirmed = 0;
  var totalRecovered = 0;
  var totalDeaths = 0;
  var deltaConfirmed = 0;
  var deltaRecovered = 0;
  var deltaDeaths = 0;

  Future<List<World>> fetchData() async {
    final response = await http.get('https://api.covid19api.com/summary');

    if (response.statusCode == 200) {
      List<World> data = [];
      var finalData = json.decode(response.body);
      var returnData = finalData['Countries'];

      for (int i = 0; i < returnData.length + 1; i++) {
        if (i == 0) {
          for (int i = 0; i < returnData.length; i++) {
            totalConfirmed += returnData[i]['TotalConfirmed'];
            deltaConfirmed += returnData[i]['NewConfirmed'];
            totalRecovered += returnData[i]['TotalRecovered'];
            deltaRecovered += returnData[i]['NewRecovered'];
            totalDeaths += returnData[i]['TotalDeaths'];
            deltaDeaths += returnData[i]['NewDeaths'];
          }

          data.add(World(
              Country: 'Total',
              CountryCode: 'TT',
              Slug: 'tt',
              NewConfirmed: deltaConfirmed,
              TotalConfirmed: totalConfirmed,
              NewDeaths: deltaDeaths,
              TotalDeaths: totalDeaths,
              NewRecovered: deltaRecovered,
              TotalRecovered: totalRecovered,
              Date: returnData[0]['Date']));
        } else {
          data.add(World(
            Country: returnData[i - 1]['Country'],
            CountryCode: returnData[i - 1]['CountryCode'],
            Slug: returnData[i - 1]['Slug'],
            NewDeaths: returnData[i - 1]['NewDeaths'],
            TotalDeaths: returnData[i - 1]['TotalDeaths'],
            NewRecovered: returnData[i - 1]['NewRecovered'],
            TotalRecovered: returnData[i - 1]['TotalRecovered'],
            NewConfirmed: returnData[i - 1]['NewConfirmed'],
            TotalConfirmed: returnData[i - 1]['TotalConfirmed'],
            Date: returnData[i - 1]['Date'],
          ));
        }
      }

      var finalList = [];
      data.sort((b, a) => a.TotalConfirmed.compareTo(b.TotalConfirmed));
      // for (int i = 0; i < data.length + 1; i++) {
      //   finalList.add(data[data.length - i]);
      // }
      return data;
    } else {
      print('error');
      throw Exception('Failed to load album');
    }
  }

  Future<List<World>> futureData;

  @override
  void initState() {
    super.initState();
    futureData = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<List<World>>(
        future: futureData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemBuilder: (context, i) {
                final data = snapshot.data[i];
                return i == 0
                    ? Header('Countries', null, data, widget.changeTheme)
                    : Container(
                        decoration: i % 2 == 1
                            ? BoxDecoration(
                                color: MyApp.isDarkTheme
                                    ? Color(0xff2c2c2c)
                                    : Colors.grey.withOpacity(0.15),
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
                                data.Country,
                                style: TextStyle(
                                  color: MyApp.isDarkTheme
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            expandRow(data.TotalConfirmed, data.NewConfirmed,
                                MyApp.isDarkTheme ? kbLightRed : Colors.red),
                            expandRow(
                                data.TotalConfirmed,
                                data.NewRecovered,
                                MyApp.isDarkTheme
                                    ? kbLightGreen
                                    : Colors.green),
                            expandRow(
                                data.TotalDeaths,
                                data.NewDeaths,
                                MyApp.isDarkTheme
                                    ? kbLightPurple
                                    : Colors.deepPurple),
                          ],
                        ),
                      );
              },
              itemCount: snapshot.data.length,
            );
          } else if (snapshot.hasError) {
            return Text('Error!');
          }
          return CircularProgressIndicator(
            backgroundColor: Theme.of(context).primaryColor,
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
